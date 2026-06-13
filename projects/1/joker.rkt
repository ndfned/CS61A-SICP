#lang planet dyoo/simply-scheme:2

; generates same cards without these lines
(require racket/base)
(random-seed (current-seconds))


(define (twenty-one strategy)
  (define (play-dealer customer-hand dealer-hand-so-far rest-of-deck)
    (cond ((> (best-total dealer-hand-so-far) 21) 1)
          ((< (best-total dealer-hand-so-far) 17)
           (play-dealer customer-hand
                        (se dealer-hand-so-far (first rest-of-deck))
                        (bf rest-of-deck)))
          ((< (best-total customer-hand) (best-total dealer-hand-so-far)) -1)
          ((= (best-total customer-hand) (best-total dealer-hand-so-far)) 0)
          (else 1)))

  (define (play-customer customer-hand-so-far dealer-up-card rest-of-deck)
    (cond ((> (best-total customer-hand-so-far) 21) -1)
          ((strategy customer-hand-so-far dealer-up-card)
           (play-customer (se customer-hand-so-far (first rest-of-deck))
                          dealer-up-card
                          (bf rest-of-deck)))
          (else
            (play-dealer customer-hand-so-far
                         (se dealer-up-card (first rest-of-deck))
                         (bf rest-of-deck)))))

  (let ((deck (make-deck)))
    (play-customer (se (first deck) (first (bf deck)))
                   (first (bf (bf deck)))
                   (bf (bf (bf deck))))))

(define (make-ordered-deck)
  (define (make-jokers)
    (se "RR" "RR")) ; no suit for joker -> joker1=joker2
  (define (make-suit s)
    (every (lambda (rank) (word rank s)) '(A 2 3 4 5 6 7 8 9 10 J Q K)))
  (se (make-suit 'H) (make-suit 'S) (make-suit 'D) (make-suit 'C) (make-jokers)))


(define (make-deck)
  (define (shuffle deck size)
    (define (move-card in out which)
      (if (= which 0)
          (se (first in) (shuffle (se (bf in) out) (- size 1)))
          (move-card (bf in) (se (first in) out) (- which 1))))
    (if (= size 0)
        deck
        (move-card deck '() (random size))))
  (shuffle (make-ordered-deck) 52))

(define (card-value card)
  (let ((rank (bl card)))
    (cond ((member? rank '(J Q K)) 10)
          ((equal? rank "A") 11)
          ((equal? rank "R") 11)
          (else rank))
    ))
(define (card-suit card) (last card))
(define (card-ace? card)
  (equal? (first card) "A"))
(define (card-joker? card)
  (equal? (first card) "R"))
(define (card-special? card)
  (or (card-ace? card) (card-joker? card)))


(define (best-total hand)
  (define (count-jokers hand)
    (if (empty? hand)
        0
        (+ (if (card-joker? (first hand)) 1 0)
           (count-jokers (bf hand)))))

  (define (take-as-needed sum min max)
    (let ((remaining (- 21 sum)))
      (+ sum
         (cond
           ((< remaining min) min)
           ((> remaining max) max)
           (else remaining)))))
  (define (add-jokers hand sum)
    (cond ((= (count-jokers hand) 0) sum)
          ((= (count-jokers hand) 1) (take-as-needed sum 1 11))
          ((= (count-jokers hand) 2) (take-as-needed sum 2 22))
          (else sum)
          ))
  (define (add-aces hand sum)
    (if (empty? hand)
        sum
        (if (card-ace? (first hand))
            (if (> sum 10)
                (add-aces (bf hand) (+ sum 1))
                (add-aces (bf hand) (+ sum 11))
                )
            (add-aces (bf hand) sum)
            )
        ))

  (define (count-cards hand sum)
    (if (empty? hand)
        sum
        (count-cards
          (bf hand)
          (if (card-special? (first hand))
              sum
              (+ sum (card-value (first hand)))))
        ))

  (add-jokers hand
               (add-aces hand
                         (count-cards hand 0)))
  )


; (best-total '(AD 8S RR)) ; 21 -> 11+8=19, joker counts as 2 here, so 19+2=21
; (best-total '(AD RR)) ; 21 -> 11+8=19, joker counts as 10
; (best-total '(RR)) ; 11
; (best-total '(8S RR)) ; 19
; (best-total '(8S AD)) ; 19
; (best-total '(RR 8S AD AH)) ; 21
; (best-total '(RR 8S RR AH)) ; 21
; (best-total '(AD 2S 2S RR)) ; 21

; currently jokers work mostly, except weird hands with multiple jokers and aces, like:
; (best-total '(RR 8S AD AH AS)) ; 22
; the result should be 21 but now it returns 22
; so u actually need to solve it using some kinda tree recursive solution
; (tho im not sure if it's actually what was originally expected from a student)
; (maybe current solution would satisfy original task)
; TODO: later figure it out
