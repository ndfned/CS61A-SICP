#lang sicp

; SICP Exercise 3.4:

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

(define acc (make-account 100 'secret-password))

((acc 'secret-password 'withdraw) 40)
; 60
((acc 'some-other-password 'deposit) 50)
; "Incorrect password"
((acc 'some-other-password 'deposit) 50)
; "Incorrect password"
((acc 'some-other-password 'deposit) 50)
; "Incorrect password"
((acc 'some-other-password 'deposit) 50)
; "Calling cops..."
