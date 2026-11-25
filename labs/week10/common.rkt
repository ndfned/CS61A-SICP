
#lang racket

(provide make-request
         request-src request-dst
         request-action request-data
         send-request get-request)

(define (make-request src dst action data)
  (list src dst action data))

(define (request-src req) (list-ref req 0))
(define (request-dst req) (list-ref req 1))
(define (request-action req) (list-ref req 2))
(define (request-data req) (list-ref req 3))

(define (send-request req out)
  (with-handlers ([exn:fail? (lambda (_) #f)])
    (write req out)
    (flush-output out)
    'okay))

(define (get-request in)
  (with-handlers ([exn:fail? (lambda (_) #f)])
    (define req (read in))
    (if (eof-object? req) #f req)))
