#lang sicp

; Exercise 2.65

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

(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1
                      (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list
                              (right-branch tree)
                              result-list)))))
  (copy-to-list tree '()))

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
(define set2
  (adjoin-set 11
              (adjoin-set 1
                          (adjoin-set 4
                                      (adjoin-set 9
                                                  (adjoin-set 3
                                                              (adjoin-set 5 '())))))))

(define set3 (adjoin-set
               3
               (adjoin-set
                 11
                 (adjoin-set
                   1
                   (adjoin-set
                     9
                     (adjoin-set
                       7
                       (adjoin-set
                         8
                         (adjoin-set
                           2 '()))))))))

(define (union tree1 tree2)
  (cond ((null? tree1) tree2)
        (else
          (union
            (right-branch tree1)
            (union
              (left-branch tree1)
              (adjoin-set (entry tree1) tree2))))
        ))

(define (intersect tree1 tree2)
  (cond ((null? tree1) '())
        ((element-of-set? (entry tree1) tree2)
         (make-tree
           (entry tree1)
           (intersect (left-branch tree1) tree2)
           (intersect (right-branch tree1) tree2)))
        (else
          (union
            (intersect (right-branch tree1) tree2)
            (intersect (left-branch tree1) tree2))
          )
        ))

(tree->list-1 (union set1 set2)) ; (1 3 4 5 7 9 11 14)
(tree->list-1 (intersect set1 set2)) ; (1 3 5 9 11)
