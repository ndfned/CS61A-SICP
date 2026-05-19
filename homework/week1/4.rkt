#lang planet dyoo/simply-scheme:2

; Write a predicate ordered? that takes a sentence of numbers as its argument and
; returns a true value if the numbers are in ascending order, or a false value otherwise.

; (ordered? '(2 3 4)) ; true
; (ordered? '(3 2 4)) ; false

(define (ordered? numbers)
  (define (iter numbers prev)
    (cond ((empty? numbers) #t)
          ((null? prev) (iter (bf numbers) (first numbers)))
          ((> prev (first numbers)) #f)
          (else (iter (bf numbers) (first numbers)))))

  (iter numbers null))


(ordered? '(2 3 4)) ; true
(ordered? '(3 2 4)) ; false
(ordered? '()) ; true
(ordered? '(3 3 4)) ; true
(ordered? '(3 4 4 1)) ; false