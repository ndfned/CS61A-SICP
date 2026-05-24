#lang planet dyoo/simply-scheme:2

; SICP Exercise 1.40:

(define (square x) (* x x))
(define (cube x) (* x x x))

(define (cubic a b c)
  (lambda (x) (+ (cube x) (* a (square x)) (* b x) c)))
