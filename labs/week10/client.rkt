
#lang racket

(require racket/tcp
         "common.rkt")

(provide im-enroll im im-exit)

(define logging #t)
(define socket-to-server #f)
(define port-to-server #f)
(define port-from-server #f)
(define clients #f)
(define whoiam 'anonymous)

(define write-lock (make-semaphore 1))

(define (log msg . args)
  (when logging (apply printf msg args)))

(define (send-safe req)
  (call-with-semaphore
    write-lock
    (lambda ()
      (and port-to-server
           (send-request req port-to-server)))))

(define (im-enroll server-address port [username 'anonymous])
  (set! whoiam username)
  (when socket-to-server
    (error "Already logged in!"))

  (define-values (in out)
    (tcp-connect server-address port))

  (set! port-from-server in)
  (set! port-to-server out)
  (set! socket-to-server #t)

  (log "Sending hello...~%")

  (unless (send-safe (make-request whoiam 'server 'hello '()))
    (close-connection)
    (error "Could not send hello"))

  (define req (get-request in))

  (cond
    [(not req)
     (close-connection)
     (error "Server disconnected")]

    [(eq? (request-action req) 'sorry)
     (close-connection)
     (error "Username already in use")]

    [(eq? (request-action req) 'welcome)
     (unless (send-safe
               (make-request whoiam 'server 'thanks '()))
       (close-connection)
       (error "Could not send thanks"))
     (log "Logged in as ~a~%" whoiam)
     (thread client-reader)
     'okay]

    [else
     (close-connection)
     (error "Unexpected server response: ~a" req)]))

(define (client-reader)
  (let loop ()
    (define req (get-request port-from-server))
    (when req
      (case (request-action req)
        [(receive-msg)
         (received-msg (request-src req)
                       (request-data req))]
        [(client-list)
         (update-client-list (request-data req))]
        [(goodbye)
         (close-connection)]
        [else
         (printf "Unknown action: ~a~%"
                 (request-action req))])
      (unless (eq? (request-action req) 'goodbye)
        (loop))))
  (when socket-to-server
    (close-connection)))

(define (received-msg from-whom msg)
  (printf "~%Message from ~a:~%    ~a~%~%"
          from-whom msg))

(define (update-client-list client-list)
  (set! clients client-list)
  (printf "~%New client-list: ~a~%~%" clients))

(define (im who message)
  (unless socket-to-server
    (error "Not connected"))
  (unless (send-safe
            (make-request whoiam who 'send-msg message))
    (close-connection)))

(define (close-connection)
  (when port-from-server
    (with-handlers ([exn:fail? void])
      (close-input-port port-from-server)))
  (when port-to-server
    (with-handlers ([exn:fail? void])
      (close-output-port port-to-server)))

  (set! port-from-server #f)
  (set! port-to-server #f)
  (set! socket-to-server #f)
  (set! clients #f)

  (printf "Connection closed.~%"))

(define (im-exit)
  (unless socket-to-server
    (error "Already logged out!"))
  (send-safe (make-request whoiam 'server 'logout '()))
  (close-connection))
