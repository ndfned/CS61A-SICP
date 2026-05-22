#lang planet dyoo/simply-scheme:2

; Find the values of the expressions
; where 1+ is a primitive procedure that adds 1 to its argument, and t is defined as follows:

(define (t f)
  (lambda (x) (f (f (f x)))) )

(define (plus1 x) (+ 1 x))

((t plus1) 0) ; 3
((t (t plus1)) 0) ; 9
(((t t) plus1) 0) ; 27
