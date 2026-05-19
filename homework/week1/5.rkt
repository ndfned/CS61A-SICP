#lang planet dyoo/simply-scheme:2

; Write a procedure ends-e that takes a sentence as its argument and returns a sentence
; containing only those words of the argument whose last letter is E:
; > (ends-e ’(please put the salami above the blue elephant))
; (please the above the blue)


(define (ends-e sent)
  (if (empty? sent)
      '()
      (if (equal? 'e (last (first sent)))
          (se (first sent) (ends-e (bf sent)))
          (ends-e (bf sent))
          )
      ))

(ends-e '(please put the salami above the blue elephant))
; (please the above the blue)
