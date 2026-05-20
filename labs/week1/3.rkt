#lang planet dyoo/simply-scheme:2

; Define a procedure that takes three numbers as arguments and returns the sum of the squares of the two
; larger numbers.

(define (square x) (* x x))

(define (proc x y z)
  (cond ((and (>= x y) (>= y z)) (+ (square x) (square y)))
        ((and (>= x y) (>= z y)) (+ (square x) (square z)))
        ((and (>= y x) (>= z x)) (+ (square y) (square z)))
  ))

(proc 3 2 1) ; 13
(proc 1 2 3) ; 13
(proc 1 3 2) ; 13
(proc 5 1 4) ; 41
(proc 1 6 4) ; 52
(proc 2 4 9) ; 97
(proc 5 5 1) ; 50
(proc 5 4 4) ; 41
(proc 3 3 3) ; 18
(proc 4 4 2) ; 32
(proc 4 2 4) ; 32