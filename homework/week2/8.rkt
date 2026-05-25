#lang planet dyoo/simply-scheme:2

; SICP Exercise 1.46b:

(define (iterative-improve good-enough? improve)
  (lambda (guess)
    (if (good-enough? guess)
        guess
        ((iterative-improve good-enough? improve) (improve guess))
        )
    ))

(define (fixed-point f first-guess)
  (define tolerance 0.00001)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2))
       tolerance))

  ((iterative-improve
     (lambda (guess) (close-enough? guess (f guess)))
     f)
   first-guess))


(fixed-point cos 1.0) ; .7390822985224023
(fixed-point (lambda (y) (+ (sin y) (cos y)))
             1.0) ; 1.2587315962971173
