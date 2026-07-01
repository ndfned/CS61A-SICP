#lang sicp

; SICP Exercise 2.27:

(define (square x) (* x x))

(define x (list (list 1 2) (list 3 4)))
; x ; ((1 2) (3 4))

(define y (list (list 1 2) (list 3 (list 4 5))))
; y ; '((1 2) (3 (4 5)))

(define (reverse x)
  (if (null? x)
      '()
      (append (reverse (cdr x)) (list (car x)))
  ))

(define (reverse2 x)
  (define (iter x acc)
    (if (null? x)
        acc
        (iter (cdr x) (cons (car x) acc))
    ))
  (iter x '()))
; (reverse2 '(2 3 4 5))

(define (deep-reverse x)
  (define (iter x acc)
    (cond ((null? x) acc)
          ((not (pair? x)) x)
          (else (iter (cdr x) (cons (deep-reverse (car x)) acc)))
    ))  
  (iter x '()))
; (deep-reverse x) ; ((4 3) (2 1))
; (deep-reverse y) ; (((5 4) 3) (2 1))

(define (deep-reverse2 x)
  (cond ((null? x) '())
        ((not (pair? x)) x)
        (else (reverse (cons (deep-reverse2 (car x)) (deep-reverse2 (cdr x)))))
  ))

(deep-reverse2 x) ; ((4 3) (2 1))
(deep-reverse2 y) ; (((5 4) 3) (2 1))
