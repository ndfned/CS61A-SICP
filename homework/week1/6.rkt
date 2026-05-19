#lang planet dyoo/simply-scheme:2

; Most versions of Lisp provide and and or procedures like the ones on page 19. In
; principle there is no reason why these can’t be ordinary procedures, but some versions of
; Lisp make them special forms. Suppose, for example, we evaluate
; (or (= x 0) (= y 0) (= z 0))

; If or is an ordinary procedure, all three argument expressions will be evaluated before or
; is invoked. But if the variable x has the value 0, we know that the entire expression has
; to be true regardless of the values of y and z. A Lisp interpreter in which or is a special
; form can evaluate the arguments one by one until either a true one is found or it runs out
; of arguments.

; Your mission is to devise a test that will tell you whether Scheme’s and and or are special
; forms or ordinary functions. This is a somewhat tricky problem, but it’ll get you thinking
; about the evaluation process more deeply than you otherwise might.

(define (new-and exp1 exp2)
  (if exp1 exp2 exp1))

(define (new-or exp1 exp2)
  (if exp1 exp1 exp2))

(define (test-spec-form x)
  (cond ((= 1 x) #f)
        (else (and (test-spec-form 1) (test-spec-form 0)))
        ))

(define (test-proc x)
  (cond ((= 1 x) #f)
        (else (new-and (test-proc 1) (test-proc 0)))
        ))

(test-spec-form 0)
(test-proc 0)
; new-and procedure stucks in a infinite loop,
; which means that it is implemented as procedure, not special form


; Why might it be advantageous for an interpreter to treat or as a special form and evaluate
; its arguments one at a time?

; efficiency, doesnt need to spend time evaluating irrelevant code


;Can you think of reasons why it might be advantageous to
; treat or as an ordinary function?

; less special = forms, easier evaluation process
; makes interpretator less complex