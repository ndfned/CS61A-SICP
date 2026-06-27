#lang sicp

; SICP Exercise 2.6:

(define zero (lambda (f) (lambda (x) x)))
(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

(define one (lambda (f) (lambda (x) (f x))))
(define two (lambda (f) (lambda (x) (f (f x)))))
(define three (lambda (f) (lambda (x) (f (f (f x))))))

(define add (lambda (n1 n2) (lambda (f) (lambda (x) ((n2 f) ((n1 f) x))))))
(define four (add three one))
(define five (add three two))

(define mul (lambda (n1 n2) (lambda (f) (lambda (x) ((n1 (n2 f)) x)))))

(define six (mul three two))
(define fifteen (mul five three))

(define exp (lambda (n1 n2) (n2 n1)))

(define (inc x) (+ x 1))

((two inc) 0)   ; => 2
((one inc) 0)   ; => 1
((zero inc) 0)  ; => 0
((three inc) 0)  ; => 3
((five inc) 0)  ; => 5
((six inc) 0)  ; => 6
((fifteen inc) 0)  ; => 15
(((exp three two) inc) 0)  ; => 9
(((exp four four) inc) 0)  ; => 256
