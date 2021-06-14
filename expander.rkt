#lang br/quicklang


;; Auxilary state

(define return-cc-stack empty)

(define (pop-return!)
  (when (empty? return-cc-stack) (error "Cannot return from top level"))
  (let [(top (car return-cc-stack))]
    (set! return-cc-stack (cdr return-cc-stack))
    top))
    

(define (push-return! cc)
  (set! return-cc-stack (cons cc return-cc-stack)))

(define it-stack (list (void)))

(define (pop-it!) 
  (when (empty? it-stack) (error "!!! IT-stack was empty, invariant broken (panic and scream) !!!"))
  (let [(top (car it-stack))]
    (set! it-stack (cdr it-stack))
    top))

(define (push-it! expr)
  (set! it-stack (cons expr it-stack)))

(define (set-it! expr)
  (set! it-stack (cons expr (cdr it-stack))))

(define (peek-it)
  (car it-stack))

(define it peek-it)

; todo: bop-it!, pull-it!, twist-it!, spin-it!

;-------------------------------------------------------------------------


(define-macro (lol-mb PARSE-TREE)
  #'(#%module-begin
     PARSE-TREE))

(provide (rename-out [lol-mb #%module-begin]))

(define-macro (program BLOCK)
  #'BLOCK)

(define-macro (statement CONTENTS) #'CONTENTS)

(define-macro (block STATEMENT ...)
  #'(begin STATEMENT ... (void)))

(define-macro-cases declare
  [(declare VAR) #'(define VAR (void))]
  [(declare VAR EXPR) #'(define VAR EXPR)])

(define-macro (assign VAR VAL) #'(set! VAR VAL))

(define-macro (expression VAL) #'VAL)


(define (hexchar->number ch)
  (match (char-upcase ch)
             [#\A 10]
             [#\B 11]
             [#\C 12]
             [#\D 13]
             [#\E 14]
             [#\F 15]
             [else (if (char-numeric? ch) (- (char->integer ch) 48) (error "Invalid hex"))]
             ))

(define (hexstring->number hexstring)
  (foldl (lambda (hex acc) (+ (* acc 16) (hexchar->number hex)))
         0 (string->list hexstring)))

(define (convert-lolcode-hex lolcode-hexstring)
  (number->string (hexstring->number (substring lolcode-hexstring 2 (sub1 (string-length lolcode-hexstring))))))




(define (lol-string . tokens) (apply string-append (map (lambda (x) (format "~a" x)) tokens)))


;; (regexp-replace* #rx":\\([0-9a-fA-F]+\\)" "qwewqe :(abcedf29218) wqeqwe" convert-lolcode-hex)
;; (let ([x 5])(regexp-replace* #rx":{[A-Za-z]+([A-Za-z]|[0-9]|_)*}" "qwewqe :{x} wqeqwe" convert-lolcode-var-template)) 
;; (let ([x 5])(regexp-replace* #rx":{([A-Za-z]+([A-Za-z]|[0-9]|_)*)}" "qwewqe :{x} wqeqwe" convert-lolcode-var-template)) 



(define (statement-expresssion expr) (set-it! expr))

(define (cast expr type)
  (match type
    ["TROOF" (expr->bool expr)] ; only #f, [], "", and 0 are falsey
    ["YARN" (expr->string expr)]
    ["NUMBR" (expr->int expr) ]
    ["NUMBAR" (expr->float expr) ]
    ["NOOB" (void)]))

(define (expr->string expr)
  (format "~a" expr))

(define (expr->bool expr)
  (not (fail? expr)))

(define (fail? expr)
  (or (void? expr)
      (not expr)
      (equal? expr "")
      (equal? expr 0)
      (equal? expr (vector))))

; number coercion is not super well defined
; if its a number return that, else if its a string try to parse it, otherwise cast, WIN=1 FAIL=0
(define (expr->float expr) 
  (cond [(number? expr) (exact->inexact expr)]
        [(string? expr) (exact->inexact (string->number expr))]
        [(expr->bool expr) 1.0]
        [else 0.0]))

(define (expr->int expr) 
  (cond [(number? expr) (inexact->exact expr)]
        [(string? expr) (inexact->exact (string->number expr))]
        [(expr->bool expr) 1]
        [else 0]))

(define-macro-cases define-func
  [(define-func ID BLOCK)
   #'(define (ID)
       (let/ec return-cc
         (push-return! return-cc)
         (push-it! (peek-it))
         BLOCK
         (pop-return!)
         (pop-it!)))]
  [(define-func ID ARG ... BLOCK)
   #'(define (ID ARG ...)
       (let/ec return-cc
         (push-return! return-cc)
         (push-it! (peek-it))
         BLOCK
         (pop-return!)
         (pop-it!)))])


(define-macro-cases return
  [(return) #'(let ()
                (pop-it!)
                ((pop-return!) (void)))]
  [(return EXPR) #'(let ([ret-val EXPR])
                     (pop-it!)
                     ((pop-return!) ret-val))])


(define-macro (call-func FUNC ARG ...)
  #'(FUNC ARG ...))


(define (math operator expression1 expression2)
  (match operator
    ["SUM OF" (+ expression1 expression2)]
    ["DIFF OF" (- expression1 expression2)]
    ["PRODUKT OF" (* expression1 expression2)]
    ["QUOSHUNT OF" (/ expression1 expression2)]
    ["MOD OF" (modulo expression1 expression2)]
    ["BIGGR OF" (max expression1 expression2)]
    ["SMALLR OF" (min expression1 expression2)]))

(define (compare operator expression1 expression2)
  (match operator
    ["BOTH SAEM" (equal? expression1 expression2)]
    ["DIFFRINT" (not (equal? expression1 expression2))]))

(define visible identity)

(define (visible-print . args)
  (display (string-join (map (lambda (x) (format "~a" x)) args))))
(define (visible-println . args)
  (displayln (string-join (map (lambda (x) (format "~a" x)) args))))

(define-macro-cases if-then
  [(if-then) (void)]
  [(if-then "NO WAI" BLOCK) #'BLOCK]
  [(if-then "MEBBE" EXPR BLOCK REST ...) #'(if EXPR BLOCK (if-then REST ...))]
  [(if-then "YA RLY" BLOCK REST ...) #'(if (expr->bool (peek-it)) BLOCK (if-then REST ...))])

(define-macro (case-statement BRANCHES ...)
  #'(let/cc break
      (push-return! break)
      (push-it! (peek-it))
      (case-ladder (peek-it) #f BRANCHES ...)
      (pop-return!)
      (pop-it!)
      (void)))

(define-macro-cases case-ladder
  [(case-ladder IT FALLING?) (void)]
  [(case-ladder IT FALLING? ELSE-BLOCK) #'ELSE-BLOCK]
  [(case-ladder IT FALLING? CASE BLOCK REST ...) #'(if (or FALLING? (equal? CASE IT))
                                                     (let ()
                                                       BLOCK
                                                       (case-ladder IT #t REST ...))
                                                     (case-ladder IT #f REST ...))])
  
(define-macro-cases loop
  [(loop BLOCK) #'(let/cc break
                        (push-return! break)
                        (for ([i (in-naturals)])
                          BLOCK)
                        (pop-return!)
                        (void))]
  [(loop OP VAR BLOCK) #'(let/cc break
                               (push-return! break)
                               (for ([i (in-naturals)])
                                 (inc/dec OP VAR)
                                 BLOCK)
                               (pop-return!)
                               (void))]
  [(loop OP VAR "TIL" EXPR BLOCK) #'(let/cc break
                                          (push-return! break)
                                          (for ([i (in-naturals)]
                                                #:break EXPR)
                                            (inc/dec OP VAR)
                                            BLOCK)
                                          (pop-return!)
                                          (void))]
  [(loop OP VAR "WILE" EXPR BLOCK) #'(let/cc break
                                          (push-return! break)
                                          (for ([i (in-naturals)]
                                                #:break (not EXPR))
                                            (inc/dec OP VAR)
                                            BLOCK)
                                          (pop-return!)
                                          (void))])
(define-macro-cases inc/dec
  [(inc/dec "UPPIN" VAR) #'(set! VAR (add1 VAR))]
  [(inc/dec "NERFIN" VAR) #'(set! VAR (sub1 VAR))])

(define (string-concat . exprs) (apply string-append (map expr->string exprs)))

(define-macro (scanline ID) #'(let ([data (read-line (current-input-port) 'any)])
                                (if (string? data) (set! ID data) (error "Unexpected EOF."))))



(provide program block statement declare assign expression cast define-func call-func return
         statement-expresssion it math compare visible visible-print visible-println if-then
         case-statement loop string-concat scanline lol-string   )
