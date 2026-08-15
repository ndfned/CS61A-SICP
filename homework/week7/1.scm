(load "obj.scm")

(define-class (random-generator max)
  (instance-vars (calls-count 0))
  (method (number)
    (set! calls-count (1+ calls-count))
    (random max))
  (method (count) calls-count))

(define r10 (instantiate random-generator 10))
(ask r10 'number)
(ask r10 'number)
(ask r10 'number)
(ask r10 'count) ; 3
(ask r10 'count) ; 3
