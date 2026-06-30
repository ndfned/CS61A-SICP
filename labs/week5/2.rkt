#lang sicp

; implement treemap

(define (square x) (* x x))

(define x (list (list 1 2) (list 3 4)))
; x ; ((1 2) (3 4))

(define y (list (list 1 2) (list 3 (list 4 5))))
; y ; '((1 2) (3 (4 5)))

(define (tree-map fn x)
  (cond ((null? x) '())
        ((not (pair? x)) (fn x))
        (else (cons (tree-map fn (car x)) (tree-map fn (cdr x))))
  ))

(tree-map square x) ; ((1 4) (9 16))
(tree-map square y) ; ((1 4) (9 (16 25)))
