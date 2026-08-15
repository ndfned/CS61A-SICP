(load "obj.scm")

(define-class (miss-manners obj)
  (method (please action arg)
    (ask obj action arg))
)
