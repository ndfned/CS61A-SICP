#lang planet dyoo/simply-scheme:2

; Now write substitute2 that takes a list, a list of old words, and a list of new words; the
; last two lists should be the same length. It should return a copy of the first argument, but
; with each word that occurs in the second argument replaced by the corresponding word of
; the third argument

(define (substitute2 items old new)
  (define (find-replacement item old new)
    (cond ((equal? item (car old)) (car new))
          (else (find-replacement item (cdr old) (cdr new)))
          ))

  (cond ((null? items) '())
        ((list? (car items)) (cons (substitute2 (car items) old new) (substitute2 (cdr items) old new)))
        ((member? (car items) old) (cons (find-replacement (car items) old new) (substitute2 (cdr items) old new)))
        (else (cons (car items) (substitute2 (cdr items) old new)))
        ))

(substitute2 '((4 calling birds) (3 french hens) (2 turtle doves))
             '(1 2 3 4) '(one two three four))
; ((four calling birds) (three french hens) (two turtle doves))
