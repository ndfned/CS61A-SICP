(load "obj.scm")

(define-class (coke-machine capacity price)
  (instance-vars
    (bottles-count 0)
    (money-count 0))
  (method (fill amount)
    (set! bottles-count
      (if (> (+ amount bottles-count) capacity)
        capacity
        (+ amount bottles-count))))
  (method (deposit amount)
    (set! money-count (+ money-count amount)))
  (method (coke)
    (cond ((< bottles-count 1) "Machine is empty")
          ((< money-count price) "Not enough money")
          (else
            (set! money-count (- money-count price))
            (let ((change money-count))
              (set! money-count 0)
              (set! bottles-count (- bottles-count 1))
              change))
    ))
)

(define my-machine (instantiate coke-machine 80 70))

(ask my-machine 'fill 60)
(ask my-machine 'deposit 25)
(ask my-machine 'coke) ; NOT ENOUGH MONEY
(ask my-machine 'deposit 25) ;; Now there's 50 cents in there.
(ask my-machine 'deposit 25) ;; Now there's 75 cents.
(ask my-machine 'coke) ; 5
