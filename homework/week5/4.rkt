#lang sicp

; SICP Exercise 2.29:

; (define (make-mobile left right)
;   (list left right))

; (define (make-branch length structure)
;   (list length structure))

(define (make-mobile left right) (cons left right))
(define (make-branch length structure)
  (cons length structure))

(define (left-branch mobile) (car mobile))
(define (right-branch mobile) (cdr mobile))

(define (branch-length branch) (car branch))
(define (branch-structure branch) (cdr branch))

(define (mobile? branch-structure) (pair? branch-structure))


(define (total-weight mobile)
  (+
    (branch-weight (left-branch mobile))
    (branch-weight (right-branch mobile))))

(define (branch-weight branch)
  (if (mobile? (branch-structure branch))
      (total-weight (branch-structure branch))
      (branch-structure branch)
      ))

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

(define (torque branch)
  (* (branch-length branch)
     (branch-weight branch)))

(define (balanced? mobile)
  (define (branch-balanced? branch)
    (if (mobile? (branch-structure branch))
        (balanced? (branch-structure branch))
        #t
        ))
  (and
    (=
      (torque (left-branch mobile))
      (torque (right-branch mobile)))
    (branch-balanced? (left-branch mobile))
    (branch-balanced? (right-branch mobile))
    ))

(balanced? m1) ; #f
(balanced? m2) ; #f
