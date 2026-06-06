#lang planet dyoo/simply-scheme:2

; Rewrite number-of-partitions with (Continuation Passing Style) (self assigned)


(define (number-of-partitions n) (cc n n (lambda (x) x)))

(define (cc n kinds next)
  (cond ((= n 0) (next 1))
        ((or (< n 0) (= kinds 0)) (next 0))
        (else (cc n (- kinds 1)
                  (lambda (x1) (cc (- n kinds) kinds
                                   (lambda (x2) (next (+ x1 x2)))))
                  ))

        ))

(number-of-partitions 5) ; 7
(number-of-partitions 10) ; 42
(number-of-partitions 13) ; 101
(number-of-partitions 17) ; 297
