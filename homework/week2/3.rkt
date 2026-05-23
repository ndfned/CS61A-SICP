#lang planet dyoo/simply-scheme:2

; SICP Exercise 1.33:


(define (inc x) (+ x 1))
(define (identity x) x)

(define (accumulate combiner null-value term start next end)
  (if (> start end)
      null-value
      (combiner (term start) (accumulate combiner null-value term (next start) next end))
  ))


(define (accumulate-iter combiner null-value term start next end)
  (define (iter counter acc)
    (if (> counter end)
        acc
        (iter (next counter) (combiner (term counter) acc))
    ))

  (iter start null-value))


(define (product term start next end) (accumulate (lambda (x y) (* x y)) 1 term start next end))
(define (factorial n) (product identity 1 inc n))

(factorial 5)
(factorial 3)

(define (filtered-accumulate combiner null-value term start next end pred)
  (if (> start end)
      null-value
      (if (pred start)
          (combiner (term start) (filtered-accumulate combiner null-value term (next start) next end pred))
          (filtered-accumulate combiner null-value term (next start) next end pred)
      )
  ))

(define (prime? n)
  (member n '(2 3 5 7 11 13 17 19 23 29 31 37)))
(define (square x) (* x x))

(define (sum-of-squares-of-primes a b)
  (filtered-accumulate (lambda (x y) (+ x y)) 0 square a inc b prime?))

(sum-of-squares-of-primes 1 10)   ; Expected: 87
(sum-of-squares-of-primes 10 20)  ; Expected: 940



(define (gcd a b)
  (if (= b 0) a (gcd b (modulo a b))))

(define (product-of-rel-primes n)
  (filtered-accumulate (lambda (x y) (* x y)) 1 identity 1 inc n (lambda (x) (= 1 (gcd x n)))))
(product-of-rel-primes 6)   ; 5
(product-of-rel-primes 8)   ; 105
(product-of-rel-primes 10)  ; 189
(product-of-rel-primes 1)   ; 1
