#lang sicp

; SICP Exercise 2.18:

(define (reverse2 l) 
  (if (null? l)
    '()
    (append (reverse (cdr l)) (list (car l)))))

(define (reverse l) 
  (define (iter items acc)
    (if (null? items)
      acc
      (iter (cdr items) (cons (car items) acc))
    ))
  (iter l '()))

(reverse (list 1 4 9 16 25))
; (25 16 9 4 1)
