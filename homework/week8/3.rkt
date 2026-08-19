#lang sicp

; SICP Exercise 3.7:

(define (make-account balance password)
  (define error-count 0)
  (define (call-the-cops) "Calling cops...")
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
          balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch pswrd m)
    (if (eq? pswrd password)
        (begin
          (set! error-count 0)
          (cond ((eq? m 'withdraw) withdraw)
                ((eq? m 'deposit) deposit)
                (else (error "Unknown request: MAKE-ACCOUNT"
                             m)))
          )
        (begin
          (set! error-count (+ 1 error-count))
          (lambda (n) (if (> error-count 3) (call-the-cops) "Incorrect password")))
        ))
  dispatch)


(define (make-joint acc acc-password new-password)
  (define error-count 0)
  (define (call-the-cops) "Calling cops...")
  (define (dispatch pswrd m)
    (if (eq? pswrd new-password)
        (begin
          (set! error-count 0)
          (acc acc-password m))
        (begin
          (set! error-count (+ 1 error-count))
          (lambda (_n) (if (> error-count 3) (call-the-cops) "Incorrect password")))
        ))
  dispatch)

(define peter-acc (make-account 100 'open-sesame))
(define paul-acc
  (make-joint peter-acc 'open-sesame 'rosebud))

((paul-acc 'rosebud 'withdraw) 30) ; 70
((peter-acc 'open-sesame 'deposit) 10) ; 80
