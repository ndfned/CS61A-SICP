#lang planet dyoo/simply-scheme:2

; Write the procedure cxr-function that takes as its argument a word starting with c,
; ending with r, and having a string of letters a and/or d in between, such as cdddadaadar.
; It should return the corresponding function.

(define (cxr-function word)
  (define (iter word fn)
    (cond ((equal? (first word) 'c) (iter (bf word) fn))
          ((equal? (first word) 'r) fn)
          ((equal? (first word) 'a) (iter (bf word) (lambda (pair) (car (fn pair)))))
          ((equal? (first word) 'd) (iter (bf word) (lambda (pair) (cdr (fn pair)))))
          (else (error "unknown instruction"))
    ))

  (iter word (lambda (pair) pair))
)


; (cxr-function 'cdddadaadar) ; -> fn
(define cddar (cxr-function 'cddar))
(cddar (cons 1 (cons 2 (cons 3 4)))) ; 3

(define cdddr (cxr-function 'cdddr))
(cdddr (cons 1 (cons 2 (cons 3 4)))) ; 4
