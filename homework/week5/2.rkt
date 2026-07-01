#lang sicp

; SICP Exercise 2.31:

(define (square x) (* x x))

(define (tree-map fn x)
  (cond ((null? x) '())
        ((not (pair? x)) (fn x))
        (else (cons (tree-map fn (car x)) (tree-map fn (cdr x))))
  ))

(define (square-tree x) (tree-map square x))
(square-tree
  (list 1
        (list 2 (list 3 4) 5)
        (list 6 7))) ; (1 (4 (9 16) 25) (36 49))
