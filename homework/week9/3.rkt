#lang sicp

; Write vector-filter, which takes a predicate function and a vector as arguments,
; and returns a new vector containing only those elements of the argument vector for which
; the predicate returns true. The new vector should be exactly big enough for the chosen
; elements.

(define (vector-filter pred vect)
  (define (trim vect size)
    (define (loop newvect n)
      (if (< n 0)
          newvect
          (begin
            (vector-set! newvect n (vector-ref vect n))
            (loop newvect (- n 1)))))
    (loop (make-vector size) (- size 1)))

  (define (loop newvect from to cur)
    (if (>= from to)
        cur
        (if (pred (vector-ref vect from))
            (begin
              (vector-set! newvect cur (vector-ref vect from))
              (loop newvect (+ from 1) to (+ cur 1))
              )
            (begin
              (loop newvect (+ from 1) to cur)
              ))

        ))

  (let ((newvect (make-vector (vector-length vect) '())))
    (begin
      (let ((actual-size (loop newvect 0 (- (vector-length vect) 1) 0)))
        (trim newvect actual-size))
      )))

(vector-filter even? (vector 6 7 8 9)) ; #(6 8)
(vector-filter even? #()) ; #()
