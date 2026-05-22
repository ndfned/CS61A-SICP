#lang planet dyoo/simply-scheme:2

; Type each of the following into Scheme, and note the results. See when you can predict the results before
; letting Scheme do the computation.

(lambda (x) (+ x 3)) ; proc
((lambda (x) (+ x 3)) 7) ; 10

(define (make-adder num)
  (lambda (x) (+ x num)))
((make-adder 3) 7) ; 10

(define plus3 (make-adder 3))
(plus3 7); 10

(define (square x) (* x x))
(square 5) ; 25
(define sq (lambda (x) (* x x)))
(sq 5) ; 25

(define (try f) (f 3 5))
(try +) ; 8
(try word) ; 35
