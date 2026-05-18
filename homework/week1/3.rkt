#lang planet dyoo/simply-scheme:2

; Write a procedure switch that takes a sentence as its argument and returns a sentence
; in which every instance of the words I or me is replaced by you, while every instance of
; you is replaced by me except at the beginning of the sentence, where it’s replaced by I.
; (Don’t worry about capitalization of letters.) Example:
; > (switch ’(You told me that I should wake you up))
; (i told you that you should wake me up)


; I/me -> you
; You -> me, if first word -> I

(define (replace wd is-first is-last)
  (let ((new-word (cond ((or (equal? wd 'I) (equal? wd 'me)) 'you)
                        ((and is-first (or (equal? wd 'You) (equal? wd 'you))) 'i)
                        ((or (equal? wd 'You) (equal? wd 'you)) 'me)
                        (else wd))))
    (if is-last new-word (word new-word " "))))

(define (switch sentence)
  (define (build sentence)
    (cond ((empty? sentence) "")
          ((equal? (count sentence) 1) (replace (first sentence) #f #t))
          (else (word (replace (first sentence) #f #f) (build (bf sentence))))))

  (let ((first-word (replace (first sentence) #t #f)))
    (word first-word (build (bf sentence)))))

(switch '(You told me that I should wake you up)) ; (i told you that you should wake me up)
