#lang sicp

; SICP Exercise 2.30:

(define (square x) (* x x))

(define (square-tree x)
  (if (pair? x)
    (map (lambda (y) (square-tree y)) x)
    (square x)
  ))

(square-tree
  (list 1
        (list 2 (list 3 4) 5)
        (list 6 7))) ; (1 (4 (9 16) 25) (36 49))


(define (square-tree2 x)
  (cond ((null? x) '())
        ((not (pair? x)) (square x))
        (else (cons (square-tree2 (car x)) (square-tree2 (cdr x))))
  ))
(square-tree2
  (list 1
        (list 2 (list 3 4) 5)
        (list 6 7))) ; (1 (4 (9 16) 25) (36 49))
