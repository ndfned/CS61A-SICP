#lang sicp

(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((= x (car set)) #t)
        ((< x (car set)) #f)
        (else (element-of-set? x (cdr set)))))

(define (intersection-set set1 set2)
  (if (or (null? set1) (null? set2))
      '()
      (let ((x1 (car set1)) (x2 (car set2)))
        (cond ((= x1 x2)
               (cons x1 (intersection-set (cdr set1)
                                          (cdr set2))))
              ((< x1 x2)
               (intersection-set (cdr set1) set2))
              ((< x2 x1)
               (intersection-set set1 (cdr set2)))))))

; Exercise 2.61
(define (adjoin-set x set)
  (cond ((null? set) (cons x set))
        ((= x (car set)) set)
        ((< x (car set)) (cons x set))
        (else (cons (car set) (adjoin-set x (cdr set))))))
(adjoin-set 4 (list 2 3 5)) ; (2 3 4 5)
(adjoin-set 6 (list 2 3 5)) ; (2 3 5 6)
(adjoin-set 6 (list 2)) ; (2 6)
(adjoin-set 6 (list 6)) ; (6)
(adjoin-set 6 '()) ; (6)

; Exercise 2.62
(define (union-set set1 set2)
  (if (or (null? set1) (null? set2))
      (if (null? set1) set2 set1)
      (let ((x1 (car set1)) (x2 (car set2)))
        (cond ((= x1 x2)
               (cons x1 (union-set (cdr set1)
                                   (cdr set2))))
              ((< x1 x2)
               (cons x1 (union-set (cdr set1) set2)))
              ((< x2 x1)
               (cons x2 (union-set set1 (cdr set2)))
               )))))

(union-set
  (list 2 3 20)
  (list 1 3 9 11 15)) ; (1 2 3 9 11 15 20)
(union-set
  (list 2 3 20 24 41)
  (list 1 3 9 11 15)) ; (1 2 3 9 11 15 20 24 41)
(union-set
  (list 1 2 3)
  (list 1 3 4 5)) ; (1 2 3 4 5)
(union-set
  (list 1 2 3)
  '()) ; (1 2 3)
(union-set
  '()
  '()) ; ()
