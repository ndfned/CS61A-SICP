#lang sicp

; Write bubble-sort!, which takes a vector of numbers and rearranges them to be in
; increasing order

(define (swap! vect i1 i2)
  (let ((temp (vector-ref vect i2)))
    (begin
      (vector-set! vect i2 (vector-ref vect i1))
      (vector-set! vect i1 temp))
    ))

(define (sort! vect i1 i2 last)
  (if (< i1 last)
      (let ((el1 (vector-ref vect i1))
            (el2 (vector-ref vect i2)))
        (begin
          (if (> el1 el2)
              (swap! vect i1 i2))
          (sort! vect (+ 1 i1) (+ 1 i2) last))
        ))
  )

(define (bubble-sort! vect)
  (define (loop i1 last)
    (if (< i1 last)
        (begin
          (sort! vect 0 1 last)
          (loop (+ 1 i1) last))
        ))
  (loop 0 (- (vector-length vect) 1)))

(define vect (vector 3 1 4 2 8 0))
(bubble-sort! vect) ; #(0 1 2 3 4 8)
vect
