#lang planet dyoo/simply-scheme:2

; SICP Exercise 1.32:


(define (inc x) (+ x 1))
(define (identity x) x)

(define (accumulate combiner null-value term start next end)
  (if (> start end)
      null-value
      (combiner (term start) (accumulate combiner null-value term (next start) next end))
  ))


(define (accumulate-iter combiner null-value term start next end)
  (define (iter counter acc)
    (if (> counter end)
        acc
        (iter (next counter) (combiner (term counter) acc))
    ))

  (iter start null-value))


(define (product term start next end) (accumulate (lambda (x y) (* x y)) 1 term start next end))
(define (factorial n) (product identity 1 inc n))

(factorial 5)
(factorial 3)

(define (sum term start next end) (accumulate (lambda (x y) (+ x y)) 0 term start next end))