#lang planet dyoo/simply-scheme:2

; We really don’t want to have to use type-check explicitly every time. Instead, we’d like to be able to
; use a safe-sqrt procedure.

; Don’t write safe-sqrt! Instead, write a procedure make-safe that you can use this way:

; It should take two arguments, a function and a type-checking predicate, and return a new function that
; returns #f if its argument doesn’t satisfy the predicate


(define (type-check fn pred x)
  (if (pred x)
      (fn x)
      #f
  ))

(define (make-safe fn pred)
  (lambda (x) (type-check fn pred x)))

(define safe-sqrt (make-safe sqrt number?))

(safe-sqrt 'hello) ; #f
(safe-sqrt 4) ; 2