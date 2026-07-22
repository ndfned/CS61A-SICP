#lang sicp

; Exercise 2.66

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

(define (entry-key entry) (car entry))
(define (entry-name entry) (cadr entry))

(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((= (entry-key x) (entry-key (entry set))) #t)
        ((< (entry-key x) (entry-key (entry set)))
         (element-of-set? x (left-branch set)))
        ((> (entry-key x) (entry-key (entry set)))
         (element-of-set? x (right-branch set)))))

(define (adjoin-set x set)
  (cond ((null? set) (make-tree x '() '()))
        ((= (entry-key x) (entry-key (entry set))) set)
        ((< (entry-key x) (entry-key (entry set)))
         (make-tree (entry set)
                    (adjoin-set x (left-branch set))
                    (right-branch set)))
        ((> (entry-key x) (entry-key (entry set)))
         (make-tree (entry set) (left-branch set)
                    (adjoin-set x (right-branch set))))))

(define set1 (adjoin-set
               (list 14 'Denis)
               (adjoin-set
                 (list 5 'V)
                 (adjoin-set
                   (list 1 'Kevin)
                   (adjoin-set
                     (list 7 'Lidia)
                     (adjoin-set
                       (list 9 'Peter)
                       (adjoin-set
                         (list 3 'Natan)
                         (adjoin-set
                           (list 7 'Eric) '()))))))))


(define (lookup given-key set-of-records)
  (cond ((null? set-of-records) false)
        ((= given-key (entry-key (entry set-of-records)))
         (entry set-of-records))
        ((> given-key (entry-key (entry set-of-records)))
         (lookup given-key (right-branch set-of-records)))
        ((< given-key (entry-key (entry set-of-records)))
         (lookup given-key (left-branch set-of-records)))
        ))

(entry-name (lookup 1 set1)) ; Kevin
(lookup 17 set1) ; false
