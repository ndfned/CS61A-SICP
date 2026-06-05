#lang planet dyoo/simply-scheme:2

; rewrite fib with (Continuation Passing Style) (self assigned)


(define (fib n)
  (define (f n next)
    (cond
      ((= n 0)
       (next 0))
      ((= n 1)
       (next 1))
      (else
       (f (- n 1)
          (lambda (n1)
            (f (- n 2)
               (lambda (n2)
                 (next (+ n1 n2)))))))))
  (f n (lambda (x) x)))

(fib 3) ; 3
(fib 5) ; 5
(fib 7) ; 13
