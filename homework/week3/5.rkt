#lang planet dyoo/simply-scheme:2

; Write a procedure (next-perf n) that tests numbers starting
; with n and continuing with n+1, n+2, etc. until a perfect number is found

(define (perfect? number)
  (define (sum-of-divisors current acc)
    (cond ((>= current number) acc)
          ((= (remainder number current) 0) (sum-of-divisors (+ current 1) (+ acc current)))
          (else (sum-of-divisors (+ current 1) acc))
          ))

  (= (sum-of-divisors 1 0) number))

(define (next-perf n)
  (if (perfect? n)
      n
      (next-perf (+ n 1))
      ))

(next-perf 4) ; 6
(next-perf 20) ; 28
(next-perf 30) ; 496
