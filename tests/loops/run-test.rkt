#lang racket

(module test racket
  (require racket/system)
  (require rackunit)
  (test-case
   "hello world"
   (check-equal?
    (with-output-to-string (thunk (system (string-append "racket " (path->string (current-directory)) "test.rkt"))))
    (file->string "expected.txt"))))
