#lang planet dyoo/simply-scheme:2

; SICP Exercise 1.12:

(define (edge? row col)
  (cond ((= col 0) #t)
        ((= col row) #t)
        (else #f)
        )
  )

(define (pascal row col)
  (if (edge? row col)
      1
      (+ (pascal (- row 1) (- col 1)) (pascal (- row 1) col))
      )
  )


(pascal 0 0) ; 1
(pascal 1 0) ; 1
(pascal 1 1) ; 1
(pascal 2 0) ; 1
(pascal 2 1) ; 2
(pascal 2 2) ; 1
(pascal 3 0) ; 1
(pascal 3 1) ; 3
(pascal 3 2) ; 3
(pascal 3 3) ; 1
(pascal 4 0) ; 1
(pascal 4 1) ; 4
(pascal 4 2) ; 6
(pascal 4 3) ; 4
(pascal 4 4) ; 1
(pascal 5 0) ; 1
(pascal 5 1) ; 5
(pascal 5 2) ; 10
(pascal 5 3) ; 10
(pascal 5 4) ; 5
(pascal 5 5) ; 1
