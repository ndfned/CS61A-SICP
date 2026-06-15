#lang sicp

; SICP Exercise 2.20:

(define (same-parity? x y)
  (= (remainder x 2) (remainder y 2)))

(define (same-parity n . items)
  (define (f items)
    (if (null? items)
        '()
        (if (same-parity? n (car items))
            (cons (car items) (f (cdr items)))
            (f (cdr items))
            )
        ))
  (cons n (f items)))

(same-parity 1 2 3 4 5 6 7)
; (1 3 5 7)
(same-parity 2 3 4 5 6 7)
; (2 4 6)
