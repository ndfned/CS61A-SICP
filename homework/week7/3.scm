(load "obj.scm")

(define-class (deck cards)
  (method (empty?) (null? cards))
  (method (deal)
    (if (ask self 'empty?)
      '()
      (let ((top-card (car cards)))
        (set! cards (cdr cards))
        top-card)))
)

(define cards '(AH 2H 3H))
(define d1 (instantiate deck cards))

(ask d1 'empty?) ; false
(ask d1 'deal) ; AH
(ask d1 'deal) ; 2H
(ask d1 'deal) ; 3H
(ask d1 'deal) ; ()
(ask d1 'empty?) ; true
