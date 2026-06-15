#lang sicp

; SICP Exercise 2.17:

(define (last-pair items) 
  (if (or (null? items) (null? (cdr items)))
      items
      (last-pair (cdr items))
  ))

(last-pair (list 23 72 149 34)) ; 34
(last-pair (list 149 34)) ; 34
(last-pair (list 34)) ; 34
(last-pair '()) ; ()
