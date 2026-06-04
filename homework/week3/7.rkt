#lang planet dyoo/simply-scheme:2

; Write a procedure number-of-partitions that computes the number of partitions of its
; nonnegative integer argument

;  Now write it to generate an iterative process; every recursive call must
; be a tail call.

(define (samount stack) (first (first stack)))
(define (skinds stack) (last (first stack)))
(define (new-stack stack item1 item2)
  (cons item1 (cons item2 stack)))
(define (item1 stack)
  (list (samount stack) (- (skinds stack) 1)))
(define (item2 stack)
  (list (- (samount stack) (skinds stack)) (skinds stack)))

(define (iter stack count)
  (cond ((empty? stack) count)
        ((= (samount stack) 0) (iter (bf stack) (+ count 1)))
        ((< (samount stack) 0) (iter (bf stack) count))
        ((= (skinds stack) 0) (iter (bf stack) count))
        (else (iter (new-stack (bf stack) (item1 stack) (item2 stack)) count))
        )
  )
(define (cc n kinds)

  (iter (list (list n kinds)) 0))


(define (number-of-partitions n) (cc n n))

(number-of-partitions 5) ; 7
(number-of-partitions 10) ; 42
(number-of-partitions 13) ; 101
(number-of-partitions 17) ; 297
