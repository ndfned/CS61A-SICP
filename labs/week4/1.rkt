#lang sicp

; SICP Exercise 2.2:
(define (make-point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))

(define (make-segment p1 p2) (cons p1 p2))
(define (start-segment s) (car s))
(define (end-segment s) (cdr s))
(define (midpoint-segment s)
  (let ((x1 (x-point (start-segment s)))
        (x2 (x-point (end-segment s)))
        (y1 (y-point (start-segment s)))
        (y2 (y-point (end-segment s))))
    (make-point (/ (+ x1 x2) 2) (/ (+ y1 y2) 2))
    ))

(define p1 (make-point 1 2))
(define p2 (make-point 5 6))

(x-point p1) ; => 1
(y-point p1) ; => 2

(define s (make-segment p1 p2))

(start-segment s) ; => p1
(end-segment s) ; => p2

(midpoint-segment s) ; => (make-point 3 4)

(midpoint-segment
  (make-segment (make-point 0 0)
                (make-point 2 8)))
; => (make-point 1 4)
