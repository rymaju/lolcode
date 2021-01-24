#lang br/quicklang
(require "parser.rkt" "tokenizer.rkt" racket/contract)

(define (read-syntax path port)
  (define parse-tree (parse path (make-tokenizer port)))
  
  (define module-datum (strip-bindings
                        #`(module lolcode "expander.rkt"
                            #,parse-tree)))
  (datum->syntax #f module-datum))

(provide (contract-out
          [read-syntax (any/c input-port? . -> . syntax?)]))