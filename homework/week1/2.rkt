#lang planet dyoo/simply-scheme:2

; Write a procedure squares that takes a sentence of numbers as its argument and
; returns a sentence of the squares of the numbers:
; > (squares ’(2 3 4 5))
; (4 9 16 25)


(define (square x) (* x x))
  
(define (squares numbers)
  (if (empty? numbers)
      '()
      (se (square (first numbers)) (squares (bf numbers)))))

(squares '(2 3 4 5)) ; (4 9 16 25)
