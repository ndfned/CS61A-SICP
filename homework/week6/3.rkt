#lang sicp

; SICP Exercise 2.79:

(define (attach-tag type-tag contents)
  (cons type-tag contents))
(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (error "Bad tagged datum: TYPE-TAG" datum)))
(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      (error "Bad tagged datum: CONTENTS" datum)))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (error
            "No method for these types: APPLY-GENERIC"
            (list op type-tags))))))

(define (equ? a b) (apply-generic 'equ? a b))

(define (install-scheme-number-package)
  (put 'equ? '(scheme-number scheme-number)
       (lambda (a b) (= a b)))
  'done)

(define (install-rational-package)
  (put 'equ? '(rational rational)
       (lambda (a b) (and (= (numer a) (numer b)) (= (denom a) (denom b)))))
  'done)

(define (install-complex-package)
  (put 'equ? '(complex complex)
       (lambda (a b) (and (= (real-part a) (real-part b)) (= (imag-part a) (imag-part b)))))
  'done)
