#lang planet dyoo/simply-scheme:2

; 3. ===========================
(define (pigl wd)
  (if (pl-done? wd)
    (word wd 'ay)
    (pigl (word (bf wd) (first wd)))))

(define (pl-done? wd)
  (vowel? (first wd)))

(define (vowel? letter)
  (member? letter '(a e i o u)))

(pigl 'scheme) ; Try out your program.
(trace pigl) ; This is a debugging aid. Watch what happens
(pigl 'scheme) ; when you run a traced procedure.
(exit)


