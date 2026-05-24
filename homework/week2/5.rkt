#lang planet dyoo/simply-scheme:2

; SICP Exercise 1.41:

(define (inc x) (+ x 1))

(define (double f)
  (lambda (x) (f (f x))))

(define inc2 (double inc))
(inc2 3) ; 5


(((double (double double)) inc) 5) ; 21
((double (double (double (double inc)))) 5) ; 21
; double double (f f x) -> double ((double double x) = fn) -> fn fn inc -> fn (double double inc) ->
; fn (double inc2) -> fn inc4 -> double double inc4 -> double inc8 -> inc16
