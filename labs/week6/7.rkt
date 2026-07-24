#lang sicp

; Exercise 2.65 (part 2: give O(n) implementation of union and intersect)

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

(define (list->tree elements)
  (car (partial-tree elements (length elements))))
(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result
                (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result
                    (partial-tree
                      (cdr non-left-elts)
                      right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts
                      (cdr right-result)))
                (cons (make-tree this-entry
                                 left-tree
                                 right-tree)
                      remaining-elts))))))))

(define (union-set set1 set2)
  (define (union-list set1 set2)
    (if (or (null? set1) (null? set2))
        (if (null? set1) set2 set1)
        (let ((x1 (car set1)) (x2 (car set2)))
          (cond ((= x1 x2)
                 (cons x1 (union-list (cdr set1)
                                      (cdr set2))))
                ((< x1 x2)
                 (cons x1 (union-list (cdr set1) set2)))
                ((< x2 x1)
                 (cons x2 (union-list set1 (cdr set2)))
                 )))))

  (list->tree
    (union-list
      (tree->list-2 set1)
      (tree->list-2 set2))))

(define (intersect-set set1 set2)
  (define (intersect-list set1 set2)
    (if (or (null? set1) (null? set2))
        '()
        (let ((x1 (car set1)) (x2 (car set2)))
          (cond ((= x1 x2)
                 (cons x1 (intersect-list (cdr set1)
                                            (cdr set2))))
                ((< x1 x2)
                 (intersect-list (cdr set1) set2))
                ((< x2 x1)
                 (intersect-list set1 (cdr set2)))))))

  (list->tree
    (intersect-list
      (tree->list-2 set1)
      (tree->list-2 set2))))

(tree->list-1 (union-set set1 set2)) ; (1 3 4 5 7 9 11 14)
(tree->list-1 (intersect-set set1 set2)) ; (1 3 5 9 11)
