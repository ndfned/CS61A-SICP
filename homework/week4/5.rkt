#lang planet dyoo/simply-scheme:2

; Write a procedure substitute that takes three arguments: a list, an old word, and a
; new word. It should return a copy of the list, but with every occurrence of the old word
; replaced by the new word, even in sublists

(define (substitute items old new)
  (cond ((null? items) '())
        ((list? (car items)) (cons (substitute (car items) old new) (substitute (cdr items) old new)))
        ((equal? (car items) old) (cons new (substitute (cdr items) old new)))
        (else (cons (car items) (substitute (cdr items) old new)))
  ))

(substitute '((lead guitar) (bass guitar) (rhythm guitar) drums) 'guitar 'axe)
; ((lead axe) (bass axe) (rhythm axe) drums)
