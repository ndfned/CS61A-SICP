
#lang racket

(require racket/tcp
         "common.rkt")

(provide start-server stop-server)

(struct client (in out lock) #:transparent)

(define logging #t)
(define clients (make-hash))
(define clients-lock (make-semaphore 1))
(define server-socket #f)
(define server-thread #f)

(define (log msg . args)
  (when logging (apply printf msg args)))

(define (get-client name)
  (call-with-semaphore
    clients-lock
    (lambda () (hash-ref clients name #f))))

(define (get-clients-list)
  (call-with-semaphore
    clients-lock
    (lambda () (hash-keys clients))))

(define (send-to-client c req)
  (call-with-semaphore
    (client-lock c)
    (lambda ()
      (send-request req (client-out c)))))

(define (send-to name req)
  (define c (get-client name))
  (and c (send-to-client c req)))

(define (server-broadcast action data)
  (define names (get-clients-list))
  (for ([name names])
    (send-to name
             (make-request 'server name action data))))

(define (remove-client! name)
  (define c
    (call-with-semaphore
      clients-lock
      (lambda ()
        (define found (hash-ref clients name #f))
        (when found
          (hash-remove! clients name))
        found)))

  (when c
    (log "Removing client ~a~%" name)
    (with-handlers ([exn:fail? void])
      (close-input-port (client-in c)))
    (with-handlers ([exn:fail? void])
      (close-output-port (client-out c)))
    (server-broadcast 'client-list
                      (get-clients-list))))

(define (register-client name c)
  (define registered?
    (call-with-semaphore
      clients-lock
      (lambda ()
        (if (hash-has-key? clients name)
            #f
            (begin
              (hash-set! clients name c)
              #t)))))

  (when registered?
    (log "~a registered~%" name)
    (server-broadcast 'client-list
                      (get-clients-list)))

  registered?)

(define (handle-client in out)
  (define c (client in out (make-semaphore 1)))

  (define name #f)
  (define registered? #f)

  (define (reply action data)
    (send-to-client
      c
      (make-request 'server name action data)))

  (define (client-loop)
    (let loop ()
      (define req (get-request in))

      (when req
        (log "Received: ~s~%" req)

        (case (request-action req)
          [(send-msg)
           (define destination (request-dst req))
           (define target (get-client destination))

           (if target
               (unless
                 (send-to-client
                   target
                   (make-request name destination
                                 'receive-msg
                                 (request-data req)))
                 (remove-client! destination))
               (reply 'receive-msg
                      (format "User not found: ~a"
                              destination)))

           (loop)]

          [(logout)
           (remove-client! name)]

          [else
           (reply 'receive-msg
                  (format "Unrecognized action: ~a"
                          (request-action req)))
           (loop)]))))

  (with-handlers ([exn:fail?
                   (lambda (e)
                     (log "Connection error: ~a~%"
                          (exn-message e)))])

    ;; First handshake message
    (define req (get-request in))

    (cond
      [(or (not req)
           (not (list? req))
           (not (= (length req) 4))
           (not (eq? (request-action req) 'hello)))
       (log "Invalid handshake~%")]

      [else
       (set! name (request-src req))

       (cond
         [(get-client name)
          (reply 'sorry '())]

         [else
          (reply 'welcome '())

          (define response (get-request in))

          (when (and response
                     (eq? (request-action response) 'thanks)
                     (register-client name c))
            (set! registered? #t)
            (client-loop))])]))

  (when registered?
    (remove-client! name)))


(define (start-server port)
  (when server-socket
    (error "Server already running"))

  (set! server-socket
        (tcp-listen port 64 #t))

  (printf "Server listening on port ~a~%" port)

  (set! server-thread
        (thread
          (lambda ()
            (let loop ()
              (when server-socket
                (with-handlers
                  ([exn:fail?
                    (lambda (e)
                      (when server-socket
                        (log "Accept error: ~a~%"
                             (exn-message e))))])

                  (define-values (in out)
                    (tcp-accept server-socket))

                  (thread
                    (lambda ()
                      (handle-client in out)))

                  (loop)))))))

  'okay)


(define (stop-server)
  (when server-socket
    (printf "Shutting down server...~%")

    (server-broadcast 'receive-msg
                      "Server shutting down...")

    (server-broadcast 'goodbye '())

    (define names (get-clients-list))

    (for-each remove-client! names)

    (tcp-close server-socket)
    (set! server-socket #f)
    (set! server-thread #f)

    (printf "Server stopped.~%")))
