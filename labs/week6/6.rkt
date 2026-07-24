#lang sicp

; random tree manipulation procedures

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((= x (entry set)) #t)
        ((< x (entry set))
         (element-of-set? x (left-branch set)))
        ((> x (entry set))
         (element-of-set? x (right-branch set)))))

(define (adjoin-set x set)
  (cond ((null? set) (make-tree x '() '()))
        ((= x (entry set)) set)
        ((< x (entry set))
         (make-tree (entry set)
                    (adjoin-set x (left-branch set))
                    (right-branch set)))
        ((> x (entry set))
         (make-tree (entry set) (left-branch set)
                    (adjoin-set x (right-branch set))))))

(define set1 (adjoin-set
               14
               (adjoin-set
                 5
                 (adjoin-set
                   1
                   (adjoin-set
                     11
                     (adjoin-set
                       9
                       (adjoin-set
                         3
                         (adjoin-set
                           7 '()))))))))

(define (count-leaves tree)
  (cond ((null? tree) 0)
        (else (+ 1
                 (count-leaves (left-branch tree))
                 (count-leaves (right-branch tree))))
        ))
(count-leaves set1) ; 7

(define (count-leaves-iter tree)
  (define (iter tree acc)
    (cond ((null? tree) acc)
          (else (iter (right-branch tree)
                      (iter (left-branch tree) (+ 1 acc))))
          ))
  (iter tree 0))
(count-leaves-iter set1) ; 7

(define (btree-member? x tree)
  (cond ((null? tree) false)
        ((= (entry tree) x) true)
        (else (or
                (btree-member? x (left-branch tree))
                (btree-member? x (right-branch tree))))
        ))
(btree-member? 9 set1) ; true
(btree-member? 1 set1) ; true
(btree-member? 13 set1) ; false

(define (btree-member-iter? x tree)
  (cond ((null? tree) false)
        ((= (entry tree) x) true)
        ((btree-member-iter? x (left-branch tree)) true)
        ((btree-member-iter? x (right-branch tree)) true)
        (else false)))
(btree-member-iter? 9 set1) ; true
(btree-member-iter? 1 set1) ; true
(btree-member-iter? 13 set1) ; false

(define (bst-member? x tree)
  (cond ((null? tree) false)
        ((= x (entry tree)) true)
        ((< x (entry tree)) (bst-member? x (left-branch tree)))
        ((> x (entry tree)) (bst-member? x (right-branch tree)))
        ))
(bst-member? 9 set1) ; true
(bst-member? 1 set1) ; true
(bst-member? 13 set1) ; false

(define (find-min-bst tree)
  (define (find v tree)
    (cond ((null? tree) v)
          ((< (entry tree) v) (find (entry tree) (left-branch tree)))
          ((>= (entry tree) v) (find v (left-branch tree)))
          ))
  (find (entry tree) tree))
(find-min-bst set1) ; 1

(define (find-min-btree tree)
  (define (find v tree)
    (cond ((null? tree) v)
          ((< (entry tree) v)
           (min
             (find (entry tree) (left-branch tree))
             (find (entry tree) (right-branch tree))))
          ((>= (entry tree) v)
           (min
             (find v (left-branch tree))
             (find v (right-branch tree))))
          ))
  (find (entry tree) tree))
(find-min-btree set1) ; 1


(define (scale-tree f tree)
  (cond ((null? tree) '())
        (else (make-tree
                (f (entry tree))
                (scale-tree f (left-branch tree))
                (scale-tree f (right-branch tree))))
        ))
; (scale-tree (lambda (x) (* x x)) set1)

(define (mirror-tree tree)
  (cond ((null? tree) '())
        (else (make-tree
                (entry tree)
                (mirror-tree (right-branch tree))
                (mirror-tree (left-branch tree))))
        ))
; set1
; (mirror-tree set1)

(define (tree->list-iter tree)
  (define (iter tree acc)
    (cond ((null? tree) acc)
          (else (iter (left-branch tree)
                      (cons (entry tree)
                            (iter (right-branch tree) acc))
                      ))
          ))
  (iter tree '()))
(tree->list-iter set1) ; (1 3 5 7 9 11 14)

