#lang planet dyoo/simply-scheme:2

; Abelson and Sussman claim that this change would not affect the correctness of the computation.
; However, it does affect the efficiency of the computation. Implement one of the ways you devised in
; exercise 1 for reversing the order in which coins are tried, and determine the extent to which the number
; of calls to cc is affected by the revision. Verify your answer on the computer, and provide an explanation.
; Hint: limit yourself to nickels and pennies, and compare the trees resulting from (cc 5 2) for each order.


(define (count-change amount) (cc amount 5))
(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount
                     (- kinds-of-coins 1))
                 (cc (- amount
                        (first-denomination
                          kinds-of-coins))
                     kinds-of-coins)))))

(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 5)
	((= kinds-of-coins 2) 1)))

(cc 5 2)


; Something to do with how amount calculated. In original version they start deducting with largest coin,
; here we start with lowest. So the decision chain is longer