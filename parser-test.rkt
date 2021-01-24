#lang br
(require"parser.rkt"
        "tokenizer.rkt"
         brag/support
         rackunit)

(define test-program-1 #<<HERE
HAI
    I HAS A VAR1 ITZ 5.12
KTHXBYE
HERE
)
  
(parse-to-datum
  (apply-tokenizer-maker make-tokenizer test-program-1))


(define test-program-2 #<<HERE
HAI
    I HAS A VAR1 ITZ 5.12
    I HAS A VAR2
    VAR2 R "A string"
    VAR1 R 42
    VAR1 R WIN
    VAR1 R FAIL
    VAR1 R VAR2
KTHXBYE
HERE
)
  
(parse-to-datum
  (apply-tokenizer-maker make-tokenizer test-program-2))