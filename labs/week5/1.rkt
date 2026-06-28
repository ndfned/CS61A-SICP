#lang sicp

; SICP Exercise 2.25:

(define x '(1 3 (5 7) 9))
(car (cdaddr x)) ; 7

(define y '((7)))
(car (car y)) ; 7

(define z '(1 (2 (3 (4 (5 (6 7)))))))
(cadadr (cadadr (cadadr z))) ; 7
