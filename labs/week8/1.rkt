#lang sicp

(define (make-account init-amount)
  (let ((balance init-amount)
        (transactions '()))
    (define (withdraw amount)
      (set! balance (- balance amount))
      (set! transactions (cons (cons 'withdraw amount) transactions))
      balance)
    (define (deposit amount)
      (set! balance (+ balance amount))
      (set! transactions (cons (cons 'deposit amount) transactions))
      balance)
    (define (dispatch msg)
      (cond
        ((eq? msg 'withdraw) withdraw)
        ((eq? msg 'deposit) deposit)
        ((eq? msg 'balance) balance)
        ((eq? msg 'init-balance) init-amount)
        ((eq? msg 'transactions) (reverse transactions))))
    dispatch))

(define acc (make-account 100))

(acc 'balance) ; 100
((acc 'withdraw) 30) ; 70
(acc 'init-balance) ; 100
((acc 'deposit) 10) ; 80
(acc 'transactions) ; ((withdraw 30) (deposit 10))
