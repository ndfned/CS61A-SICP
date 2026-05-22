#lang planet dyoo/simply-scheme:2

; For each of the following expressions, what must f be in order for the evaluation of the expression to
; succeed, without causing an error? For each expression, give a definition of f such that evaluating the
; expression will not cause an error, and say what the expression’s value will be, given your definition.


; f
; (define f 3)
; can define f and assign any value 

; (f)
; (define f (lambda () 1))
; f should be a procedure that doesnt take any argument

; (f 3)
; (define f (lambda (x) x))
; f should be a procedure that takes one argument

; ((f))
; (define (f)
;   (lambda () 1))
; f should be a procedure that takes no arguments and returns another procedure that takes no arguments


; (((f)) 3)
; (define (f)
;   (lambda ()
;     (lambda (x) x)))
; f should be a procedure that returns procedure that returns procedure that takes one argument