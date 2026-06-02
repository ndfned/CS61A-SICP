#lang planet dyoo/simply-scheme:2


; Modify the cc procedure so that its kinds-of-coins parameter, instead of being an integer, is a
; sentence that contains the values of the coins to be used in making change. The coins should be tried in the
; sequence they appear in the sentence

(define (count-change amount)
  (cc amount '(50 25 10 5 1)))

(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (empty? kinds-of-coins)) 0)
        (else (+ (cc amount
                     (bf kinds-of-coins))
                 (cc (- amount
                        (first kinds-of-coins))
                     kinds-of-coins)))))

(count-change 10)   ; 4
(count-change 25)   ; 13
(count-change 100) ; 292
