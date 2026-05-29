#lang planet dyoo/simply-scheme:2

; SICP Exercise 1.11:

(define (f n)
  (define (iter a b c count)
    (if (= count 0)
        a
        (iter (+ a (* 2 b) (* 3 c)) a b (- count 1))
    ))
  
  (if ( < n 3)
      n
      (iter 2 1 0 (- n 2))
  ))

(f 0) ; 0
(f 1) ; 1
(f 2) ; 2
(f 3) ; 4
(f 4) ; 11 (4 + 4 + 3)
(f 5) ; 25 (11 + 8 + 6)
(f 6) ; 59 (25 + 22 + 12)
(f 7) ; 142
(f 8) ; 335
(f 9) ; 796
(f 10) ; 1892
