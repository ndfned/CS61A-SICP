#lang planet dyoo/simply-scheme:2

; Identify two ways to change the program to reverse the order in which coins are tried, that is, to change
; the program so that pennies are tried first, then nickels, then dimes, and so on


(define (count-change amount) (cc amount 1))
(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 6)) 0)
        (else (+ (cc amount
                     (+ kinds-of-coins 1))
                 (cc (- amount
                        (first-denomination
                          kinds-of-coins))
                     kinds-of-coins)))))
(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))

(count-change 100) ; 292

; 1. First way is to reverse order of coins from {1,5,10,25,50} to {50,25,10,5,1}
; (define (first-denomination-reversed kinds-of-coins)
;   (cond ((= kinds-of-coins 5) 1)
;         ((= kinds-of-coins 4) 5)
;         ((= kinds-of-coins 3) 10)
;         ((= kinds-of-coins 2) 25)
;         ((= kinds-of-coins 1) 50)))

; 2. Second way is to change processing order of coins, so with {1,5,10,25,50} we start from 1 not 50


