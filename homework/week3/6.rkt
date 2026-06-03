#lang planet dyoo/simply-scheme:2

; Write a procedure number-of-partitions that computes the number of partitions of its
; nonnegative integer argument

(define (number-of-partitions n) (cc n n))

(define (cc n kinds)
  (cond ((= n 0) 1)
        ((or (< n 0) (= kinds 0)) 0)
        (else (+ 
                (cc n (- kinds 1))
                (cc (- n kinds) kinds)))

  ))

(number-of-partitions 5) ; 7
(number-of-partitions 10) ; 42
(number-of-partitions 13) ; 101
(number-of-partitions 17) ; 297
