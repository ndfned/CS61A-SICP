#lang sicp

; SICP Exercise 2.3:

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

(define (make-rect p1 width height)
  (cons p1 (cons width height)))
(define (width rect)
  (car (cdr rect)))
(define (height rect)
  (cdr (cdr rect)))

(define r1 (make-rect (make-point 4 0) 3 2))
(width r1) ; => 3
(height r1) ; => 2

(define (perimeter rect)
  (* 2 (+ (width rect) (height rect))))
(define (area rect)
  (* (width rect) (height rect)))

(perimeter r1) ; => 10
(area r1) ; => 6
