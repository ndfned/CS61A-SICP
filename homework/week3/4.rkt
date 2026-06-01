#lang planet dyoo/simply-scheme:2

; SICP Exercise 1.16:

; (define (exp b n)
;   (if (= n 0)
;       1
;       (* b (exp b (- n 1)))
;   ))

; (exp 3 3) ; 27
; (exp 2 4) ; 16
; (exp 9 3) ; 729


; (define (exp2 b n)
;   (define (iter counter acc)
;     (if (= counter 0)
;         acc
;         (iter (- counter 1) (* acc b))
;     ))

;   (iter n 1))

; (exp2 2 0) ; 1
; (exp2 2 1) ; 2
; (exp2 3 3) ; 27
; (exp2 2 4) ; 16
; (exp2 9 3) ; 729

(define (square x) (* x x))

; (define (fast-exp b n)
;   (cond ((= n 0) 1)
;         ((even? n) (square (fast-exp b (/ n 2))))
;         (else (* b (fast-exp b (- n 1))))
;   ))

; (fast-exp 2 0) ; 1
; (fast-exp 2 1) ; 2
; (fast-exp 3 3) ; 27
; (fast-exp 2 4) ; 16
; (fast-exp 9 3) ; 729

(define (fast-exp1 b n)
  (define (iter b n acc)
    (cond ((= n 1) (* acc b))
          ((even? n) (iter (square b) (/ n 2) acc))
          (else (iter b (- n 1) (* acc b)))
    ))

  (iter b n 1))

(define (fast-exp2 b n)
  (define (iter n acc base)
    (cond ((= n 0) acc)
          ((even? n)
           (iter (/ n 2) acc (* base base)))
          (else
           (iter (- n 1) (* acc base) base))))
  (iter n 1 b))


(fast-exp2 2 0) ; 1
(fast-exp2 2 1) ; 2
(fast-exp2 3 3) ; 27
(fast-exp2 2 4) ; 16
(fast-exp2 9 3) ; 729
