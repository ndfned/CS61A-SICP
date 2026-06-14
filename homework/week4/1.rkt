#lang sicp

; SICP Exercises 2.7, 2.8, 2.10, 2.12:

(define (make-interval a b) (cons a b))
(define (lower-bound i) (car i))
(define (upper-bound i) (cdr i))


(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

;; Test 1
(add-interval
  (make-interval 1 3)
  (make-interval 4 5))
;; => [5, 8]

; x1 - y2, x2 - y1
(define (sub-interval x y)
  (make-interval
    (- (lower-bound x) (upper-bound y))
    (- (upper-bound x) (lower-bound y))
    ))

;; Test 1
(sub-interval
  (make-interval 1 3)
  (make-interval 4 5))
;; => [-4, -1]

;; Test 2
(sub-interval
  (make-interval -2 4)
  (make-interval 3 7))
;; => [-9, 1]


(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (mul-interval
    x
    (make-interval (/ 1.0 (upper-bound y))
                   (/ 1.0 (lower-bound y)))))

(div-interval
  (make-interval 4 8)
  (make-interval 1 2))
;; => [2, 8]

(div-interval
  (make-interval 1 2)
  (make-interval -1 1))
;; [-2, 2] (should be an error)

(define (spans-zero? i)
  (and (<= (lower-bound i) 0)
       (>= (upper-bound i) 0)))
(define (div-interval-corrected x y)
  (if (spans-zero? y)
      (error "y spans zero")
      (div-interval x y)
      ))

(div-interval-corrected
  (make-interval 4 8)
  (make-interval 1 2))
;; => [2, 8]

; (div-interval-corrected
;  (make-interval 1 2)
;  (make-interval -1 1))
;; [-2, 2] (should be an error)

(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))
(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))
(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

(define (make-center-percent center tolerance)
  (let ((w (* center (/ tolerance 100))))
    (make-interval (- center w) (+ center w))))
(define (percent i)
  (let ((w (/ (- (upper-bound i) (lower-bound i)) 2)))
    (* (/ w (center i)) 100)))

;; Test 1
(define i1 (make-center-percent 100 10))
(lower-bound i1) ; => 90
(upper-bound i1) ; => 110
(percent i1) ; => 10

;; Test 2
(define i2 (make-center-percent 50 20))
(lower-bound i2) ; => 40
(upper-bound i2) ; => 60
(percent i2) ; => 20
