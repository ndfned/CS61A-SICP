#lang planet dyoo/simply-scheme:2

; SICP Exercise 1.43:

(define (square x) (* x x))

(define (repeated f n)
  (define (rec x n)
    (if (< n 1)
        x
        (f (rec x (- n 1)))))
  (define (iter count acc)
    (if (> count n)
        acc
        (iter (+ 1 count) (f acc))))

  (lambda (x) (rec x n)))

(define (repeated2 f n)
  (if (= n 0)
    (lambda (x) x)
    (lambda (x) ((repeated2 f (- n 1)) (f x)))
  ))

((repeated2 square 2) 5) ; 625
((repeated2 square 1) 5) ; 25
((repeated2 square 0) 5) ; 5
