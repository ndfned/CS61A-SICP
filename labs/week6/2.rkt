#lang sicp

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1) (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

; Exercise 2.59
(define (union-set set1 set2)
  (cond ((or (null? set1) (null? set2)) set2)
        ((element-of-set? (car set1) set2)
         (union-set (cdr set1) set2))
        (else (cons (car set1) (union-set (cdr set1) set2)))))

(union-set
  (list 1 2 3)
  (list 1 3 4 5)) ; (2 1 3 4 5)

; Exercise 2.60
(define (element-of-set2? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))
(element-of-set2? 2 (list 2 3 2 1 3 2 2)) ; #t

(define adjoin-set2 cons)
(adjoin-set2 2 (list 2 3 2 1 3 2 2)) ; (2 2 3 2 1 3 2 2)

(define (union-set2 set1 set2)
  (cond ((or (null? set1) (null? set2)) set2)
        (else (cons (car set1) (union-set2 (cdr set1) set2)))))
(union-set2
  (list 1 2 3)
  (list 1 3 4 5)) ; (1 2 3 1 3 4 5)
