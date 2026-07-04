#lang sicp

; SICP Exercise 2.29:

(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

(define (left-branch mobile) (car mobile))
(define (right-branch mobile) (cadr mobile))

(define (branch-length branch) (car branch))
(define (branch-structure branch) (cadr branch))

(define (mobile? branch) (pair? branch))


(define (total-weight mobile)
  (define (branch-weight branch)
    (if (mobile? (branch-structure branch))
        (total-weight (branch-structure branch))
        (branch-structure branch)
        ))
  (+
    (branch-weight (left-branch mobile))
    (branch-weight (right-branch mobile))))

(define m1 (make-mobile
             (make-branch 3 (make-mobile (make-branch 2 5) (make-branch 3 4)))
             (make-branch 2 (make-mobile (make-branch 2 3) (make-branch 3 3)))
             ))
(total-weight m1) ; 15

(define m2 (make-mobile
             (make-branch 3 (make-mobile (make-branch 2 5) (make-branch 3 4)))
             (make-branch 2 (make-mobile (make-branch 2 3) (make-branch 3 (make-mobile (make-branch 2 3) (make-branch 3 3)))))
             ))
(total-weight m2) ; 18


