#lang planet dyoo/simply-scheme:2

(define (plural wd)
  (if (and (equal? (last wd) 'y) (consonant? (last (bl wd))))
      (word (bl wd) 'ies)
      (word wd 's)))

(define (vowel? letter)
  (member? letter '(a e i o u)))

(define (consonant? letter)
  (not (vowel? letter)))


(plural 'word) ; words
(plural 'fly) ; flies
(plural 'boy) ; boys
