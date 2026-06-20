#lang sicp

; SICP Exercise 2.3b:

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

(define (make-rect AB AC)
  (cons AB AC))
(define (width rect)
  (let ((AB (car rect)))
        (abs (- (x-point (end-segment AB)) (x-point (start-segment AB))))
  ))
(define (height rect)
  (let ((AC (cdr rect)))
        (abs (- (y-point (end-segment AC)) (y-point (start-segment AC))))
  ))

(define r1 (make-rect 
  (make-segment (make-point 1 0) (make-point 4 0))
  (make-segment (make-point 1 0) (make-point 1 -2))))
(width r1) ; => 3
(height r1) ; => 2

(define (perimeter rect)
  (* 2 (+ (width rect) (height rect))))
(define (area rect)
  (* (width rect) (height rect)))

(perimeter r1) ; => 10
(area r1) ; => 6
