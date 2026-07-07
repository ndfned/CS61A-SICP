#lang sicp

; SICP Exercise 2.54:

(define (equal? lst1 lst2)
  (cond ((and (null? lst1) (null? lst2)) #t)
        ((not (eq? (car lst1) (car lst2))) #f)
        (else (equal? (cdr lst1) (cdr lst2)))
        ))

(equal? '(this is a list) '(this is a list)) ; #t
(equal? '(this is a list) '(this (is a) list)) ; #f
