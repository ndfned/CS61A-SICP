#lang planet dyoo/simply-scheme:2

; SICP Exercise 1.46a:

(define (iterative-improve good-enough? improve)
  (lambda (guess)
    (if (good-enough? guess)
        guess
        ((iterative-improve good-enough? improve) (improve guess))
        )
    ))

(define (sqrt x)
  (define (square x) (* x x))
  (define (good-enough? guess x)
    (< (abs (- (square guess) x)) 0.001))
  (define (average x y)
    (/ (+ x y) 2))
  (define (improve guess x)
    (average guess (/ x guess)))
  ((iterative-improve
     (lambda (guess) (good-enough? guess x))
     (lambda (guess) (improve guess x)))
   1.0))

(sqrt 9) ; 3.0
(sqrt 15) ; 3.87
(sqrt 36) ; 6.0
