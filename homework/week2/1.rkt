#lang planet dyoo/simply-scheme:2

; SICP Exercise 1.31(a):

(define (product term a next b)
  (if (> a b)
      1
      (* (term a) (product term (next a) next b))))

(define (inc x) (+ x 1))
(define (identity x) x)

(product identity 3 inc 5) ; 60
(product identity 3 inc 7) ; 60

(define (factorial n) (product identity 1 inc n))

(factorial 3) ; 6
(factorial 5) ; 120


(define (pi terms) (* 4 (product
                          (lambda (x) (/ (* 2 (inc (floor (/ x 2))))
                                         (inc (* 2 (ceiling (/ x 2))))))
                          1 inc terms)))
