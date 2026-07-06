#lang sicp

; SICP Exercise 2.37:

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      '()
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(dot-product '(1 2 3) '(4 5 6))
;; => 32

(define (matrix-*-vector m v)
  (map (lambda (row) (dot-product row v)) m))

(define m
  '((1 2 3)
    (4 5 6)
    (7 8 9)))

(define v '(1 2 3))

(matrix-*-vector m v)
;; => (14 32 50)


(define (transpose mat)
  (accumulate-n cons '() mat))

(define m2
  '((1 2 3)
    (4 5 6)))

(transpose m2)
;; => ((1 4)
;;     (2 5)
;;     (3 6))


(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (row) (matrix-*-vector cols row)) m)))

(define m3
  '((1 2 3)
    (4 5 6)))

(define n3
  '((7 8)
    (9 10)
    (11 12)))

(matrix-*-matrix m3 n3)
;; => ((58 64)
;;     (139 154))

(define m4
  '((1 2 3)
    (4 5 6)))

(define n4
  '((7 8 9)
    (10 11 12)
    (13 14 15)))

(matrix-*-matrix m4 n4)
; '((66 72 78)
;   (156 171 186))
