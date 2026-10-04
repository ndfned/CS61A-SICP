#lang sicp

; Write vector-append, which takes two vectors as arguments and returns a new vector
; containing the elements of both arguments, analogous to append for lists

(define (vector-append vect1 vect2)
  (define (populate! target-vect source-vect n shift)
    (if (< n 0)
        target-vect
        (begin
          (vector-set! target-vect (+ n shift) (vector-ref source-vect n))
          (populate! target-vect source-vect (- n 1) shift))
        )
    )
  (let ((new-vect (make-vector (+ (vector-length vect1) (vector-length vect2)))))
    (begin
      (populate! new-vect vect1 (- (vector-length vect1) 1) 0)
      (populate! new-vect vect2 (- (vector-length vect2) 1) (vector-length vect1)))
    )
  )

(vector-append (vector 1 2 3) (vector 6 7 8 9)) ; #(1 2 3 6 7 8 9)
(vector-append (vector 1 2) (vector 1 2 3 4 6 7 8 9)) ; #(1 2 3 6 7 8 9)
(vector-append #() #()) ; #()
