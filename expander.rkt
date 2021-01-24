#lang br/quicklang

(define-macro (lol-mb PARSE-TREE)
  #'(#%module-begin
     PARSE-TREE))

(provide (rename-out [lol-mb #%module-begin]))

(define-macro (program BLOCK)
  #'BLOCK)

(define-macro (statement CONTENTS) #'CONTENTS)

(define-macro (block STATEMENT ...)
  #'(begin STATEMENT ...))

(define-macro-cases declare
  [(declare VAR) #'(define VAR (void))]
  [(declare VAR EXPR) #'(define VAR EXPR)])

(define-macro (assign VAR VAL) #'(set! VAR VAL))

(define-macro (expression VAL) #'VAL)

(define (cast expr type)
  (match type
    ["TROOF" (expr->bool expr)] ; only #f, [], "", and 0 are falsey
    ["YARN" (format "~a" expr)]
    ["NUMBR" (expr->int expr) ]
    ["NUMBAR" (expr->float expr) ]
    ["NOOB" (void)]))

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

(provide program block statement declare assign expression cast)