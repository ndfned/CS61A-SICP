#lang planet dyoo/simply-scheme:2

; 2. Type each of the following expressions into Scheme, ending the line with the Enter (carriage return) key.
; Think about the results! Try to understand how Scheme interprets what you type.

3
(+ 2 3)
(+ 5 6 7 8)
(+)
(sqrt 16)
+
'+
'hello
'(+ 2 3)
'(good morning)
(first 274)
(butfirst 274)


(first 'hello)
; (first hello) -> unbound identifier (uncomment to check)
(first (bf 'hello))
(+ (first 23) (last 45))
(define pi 3.14159)
(+ (* 3 4) 5) pi
'pi
(+ pi 7)
(* pi pi)
(define (square x) (* x x))
(square 5)
(square (+ 2 3))
