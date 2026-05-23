#lang planet dyoo/simply-scheme:2

; SICP Exercise 1.31:


(define (inc x) (+ x 1))
(define (identity x) x)

(define (product term start next end)
  (if (> start end)
      1
      (* (identity start) (product term (next start) next end))
  ))


(define (product-iter term start next end)
  (define (iter counter acc)
    (if (> counter end)
        acc
        (iter (next counter) (* (term counter) acc))
    ))

  (iter start 1))


(define (factorial n) (product-iter identity 1 inc n))
(factorial 5)
(factorial 3)
