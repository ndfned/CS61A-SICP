#lang planet dyoo/simply-scheme:2

; Your task is to find a way to express the fact procedure in a Scheme without any way to
; define global names.

; (define (fact n)
;   (if (= n 0)
;       1
;       (* n (fact (- n 1)))))

; (fact 5)

((lambda (fn) (fn fn 5))
 (lambda (self n)
   (if (= n 0)
       1
       (* n (self self (- n 1))))))
