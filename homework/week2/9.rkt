#lang planet dyoo/simply-scheme:2

; create a higher-order procedure called every that applies an arbitrary
; procedure, given as an argument, to each word of an argument sentence

(define (square x) (* x x))

(define (every fn sent)
  (if (empty? sent)
      '()
      (se (fn (first sent)) (every fn (bf sent)))
  ))

(every square '(1 2 3 4))
; (1 4 9 16)
