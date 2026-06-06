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
    (cond ((member? rank '(J Q K)) 10)
          ((equal? rank "A") 11)
          (else rank))
    ))
(define (card-suit card) (last card))
(define (card-ace? card)
  (equal? (first card) "A"))


(define (best-total hand)
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
          (if (card-ace? (first hand))
              sum
              (+ sum (card-value (first hand)))))
        ))

  (add-aces hand (count-cards hand 0))
  )


; (best-total '(AD 8S)) ; 19 in this hand the ace counts as 11
; (best-total '(AD 8S 5H)) ; 14 here it must count as 1 to avoid busting
; (best-total '(AD AS 9H)) ; 21 here one counts as 11 and the other as 1
; (best-total '(10S 9H)) ; 19, no aces
; (best-total '(10S 10H 5D)) ; 25, bust case
; (best-total '(AD AC 9H)) ; 21, mixed aces
; (best-total '(AD AC 9H 2D)) ; 13, forced adjustment
; (best-total '(AD 10S)) ; 21, ace as 11 works exactly


; 2. Define a strategy procedure stop-at-17 that’s identical to the dealer’s, i.e., takes a
; card if and only if the total so far is less than 17.

(define (stop-at-17 hand _dealer-card)
  (< (best-total hand) 17))

; traces:
; >(stop-at-17 '("7C" "2S" "9S") "10H")
; <#f
; total=18; returns false
; >(stop-at-17 '("7H" "JH") "5S")
; <#f
; total=17; returns false
; >(stop-at-17 '("5S" "9D" "2S") "5D")
; <#t
; total=16; return true (hit)
; >(stop-at-17 '("8C" "4H") "KD")
; <#t
; >(stop-at-17 '("5C" "6C") "AC")
; <#t
; with total < 17 both results in false


; 3. Write a procedure play-n such that
; (play-n strategy n)
; plays n games with a given strategy and returns the number of games that the customer
; won minus the number that s/he lost. Use this to exercise your strategy from problem 2,
; as well as strategies from the problems below. To make sure your strategies do what you
; won minus the number that s/he lost

(define (play-n strategy n)
  (if (= n 0)
      0
      (+ (twenty-one strategy) (play-n strategy (- n 1)))
      ))


; traces:
; with following code:
; (trace twenty-one)
; (play-n stop-at-17 3)
; we've got following results:
; >(twenty-one #<procedure:stop-at-17>)
; <1
; >(twenty-one #<procedure:stop-at-17>)
; <1
; >(twenty-one #<procedure:stop-at-17>)
; <1
; 3
; so, we see that twenty-one was called 3 times. 3 times customer won, so return value is 3

; now run 5 times:
; >(twenty-one #<procedure:stop-at-17>)
; <1
; >(twenty-one #<procedure:stop-at-17>)
; <-1
; >(twenty-one #<procedure:stop-at-17>)
; <-1
; >(twenty-one #<procedure:stop-at-17>)
; <-1
; >(twenty-one #<procedure:stop-at-17>)
; <0
; -2
; 1 - 1 - 1 - 1 + 0 = -2; correct result



; 4. Define a strategy named dealer-sensitive that “hits” (takes a card) if (and only if)
; the dealer has an ace, 7, 8, 9, 10, or picture card showing, and the customer has less than
; 17, or the dealer has a 2, 3, 4, 5, or 6 showing, and the customer has less than 12. (The
; idea is that in the second case, the dealer is much more likely to “bust” (go over 21), since
; there are more 10-pointers than anything else.)

(define (dealer-sensitive hand dealer-card)
  (cond ((and
           (< (best-total hand) 17)
           (or (card-ace? dealer-card) (>= (card-value dealer-card) 7))) #t)
        ((and
           (< (best-total hand) 12)
           (< (card-value dealer-card) 7)) #t)
        (else #f)
        ))

; traces:
; >(dealer-sensitive '("3H" "QC" "AH") "10C")
; <#t
; customer=14; dealer=10; -> hit
; >(dealer-sensitive '("3H" "QC" "AH" "5S") "10C")
; <#f
; customer=18; dealer=10; -> stand
; >(dealer-sensitive '("3D" "3C") "9H")
; <#t
; customer=6; dealer=9; -> hit



; 5. Generalize part 2 above by defining a function stop-at. (stop-at n) should return a
; strategy that keeps hitting until a hand’s total is n or more. For example, (stop-at 17)
; is equivalent to the strategy in part 2.

(define (stop-at n)
  (lambda (hand _dealer-card) (< (best-total hand) n)))



; 6. On Valentine’s Day, your local casino has a special deal: If you win a round of 21 with
; a heart in your hand, they pay double. You decide that if you have a heart in your hand,
; you should play more aggressively than usual. Write a valentine strategy that stops at
; 17 unless you have a heart in your hand, in which case it stops at 19.

(define (has-hearts? hand)
  (cond ((empty? hand) #f)
        ((equal? (card-suit (first hand)) "H") #t)
        (else (has-hearts? (bf hand)))
        ))

(define (valentine hand dealer-card)
  ((if (has-hearts? hand) (stop-at 19) (stop-at 17)) hand dealer-card))

; >(valentine '("3C" "8C" "7D") "4C")
; <#f
; customer=18; no hearts -> stand
; >(valentine '("10H" "AC") "5C")
; <#f
; customer=21; hearts, but >= 19 -> stand
; >(valentine '("JD" "6D" "AH") "4H")
; <#t
; customer=17; hearts with 17 -> hit
; >(valentine '("2S" "7D" "3C" "6H") "8D")
; <#t
; customer=18; hearts with 18 -> hit
