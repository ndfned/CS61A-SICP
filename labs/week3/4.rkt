#lang planet dyoo/simply-scheme:2

; Many Scheme procedures require a certain type of argument. For example, the arithmetic procedures
; only work if given numeric arguments. If given a non-number, an error results.
; Suppose we want to write safe versions of procedures, that can check if the argument is okay, and either
; call the underlying procedure or return #f for a bad argument instead of giving an error. (We’ll restrict our
; attention to procedures that take a single argument.)

; Write type-check. Its arguments are a function, a type-checking predicate that returns #t if and only if
; the datum is a legal argument to the function, and the datum.

(define (type-check fn pred x)
  (if (pred x)
      (fn x)
      #f
  ))

(type-check sqrt number? 'hello) ; #f
(type-check sqrt number? 4) ; 2
