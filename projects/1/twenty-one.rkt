#lang planet dyoo/simply-scheme:2

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
  (define (make-suit s)
    (every (lambda (rank) (word rank s)) '(A 2 3 4 5 6 7 8 9 10 J Q K)))
  (se (make-suit 'H) (make-suit 'S) (make-suit 'D) (make-suit 'C)))

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


; 1. The program in the library is incomplete. It lacks a procedure best-total that takes a
; hand (a sentence of card words) as argument, and returns the total number of points in the
; hand. It’s called best-total because if a hand contains aces, it may have several different
; totals. The procedure should return the largest possible total that’s less than or equal to
; 21, if possible

(define (card-value card)
  (let ((rank (bl card)))
    (cond ((member? rank '(j q k)) 10)
          ((eq? rank 'a) 0)
          (else rank))
    ))
(define (card-ace? card)
  (eq? (first card) 'a))


(define (best-total hand)
  (define (add-aces hand sum)
    (if (empty? hand)
        sum
        (if (card-ace? (first hand))
            (if (> sum 10)
                (add-aces  (bf hand) (+ sum 1))
                (add-aces (bf hand) (+ sum 11))
                )
            (add-aces (bf hand) sum)
            )
        ))

  (define (count-cards hand sum)
    (if (empty? hand)
        sum
        (count-cards (bf hand) (+ sum (card-value (first hand))))
        ))

  (add-aces hand (count-cards hand 0))
  )


(best-total '(ad 8s)) ; 19 in this hand the ace counts as 11
(best-total '(ad 8s 5h)) ; 14 here it must count as 1 to avoid busting
(best-total '(ad as 9h)) ; 21 here one counts as 11 and the other as 1
(best-total '(10s 9h))     ; 19, no aces
(best-total '(10s 10h 5d)) ; 25, bust case
(best-total '(ad ac 9h))   ; 21, mixed aces
(best-total '(ad ac 9h 2d)) ; 13, forced adjustment
(best-total '(ad 10s))     ; 21, ace as 11 works exactly
