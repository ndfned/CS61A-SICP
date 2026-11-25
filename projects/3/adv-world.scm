;;;  Data for adventure game.  This file is adv-world.scm

(load "obj.scm")
(load "adv.scm")
(load "tables.scm")

; (load "adv-world.scm")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; setting up the world
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define Soda (instantiate place 'Soda))
(define BH-Office (instantiate place 'BH-Office))
(define MJC-Office (instantiate locked-place 'MJC-Office))
(define art-gallery (instantiate place 'art-gallery))
(define Pimentel (instantiate place 'Pimentel))
(define 61A-Lab (instantiate place '61A-Lab))
(define Sproul-Plaza (instantiate place 'Sproul-Plaza))
(define Telegraph-Ave (instantiate place 'Telegraph-Ave))
(define Noahs (instantiate place 'Noahs))
(define Intermezzo (instantiate place 'Intermezzo))
(define s-h (instantiate place 'sproul-hall))


(can-go Soda 'up art-gallery)
(can-go art-gallery 'down Soda)
(can-go art-gallery 'west BH-Office)
(can-go BH-Office 'east art-gallery)
(can-go art-gallery 'east MJC-Office)
(can-go MJC-Office 'west art-gallery)
(can-go Soda 'south Pimentel)
(can-go Pimentel 'north Soda)
(can-go Pimentel 'south 61A-Lab)
(can-go 61A-Lab 'north Pimentel)
(can-go 61A-Lab 'west s-h)
(can-go s-h 'east 61A-Lab)
(can-go Sproul-Plaza 'east s-h)
(can-go s-h 'west Sproul-Plaza)
(can-go Sproul-Plaza 'north Pimentel)
(can-go Sproul-Plaza 'south Telegraph-Ave)
(can-go Telegraph-Ave 'north Sproul-Plaza)
(can-go Telegraph-Ave 'south Noahs)
(can-go Noahs 'north Telegraph-Ave)
(can-go Noahs 'south Intermezzo)
(can-go Intermezzo 'north Noahs)

;; Some people.
; MOVED above the add-entry-procedure stuff, to avoid the "The computers
; seem to be down" message that would occur when hacker enters 61a-lab
; -- Ryan Stejskal

(define Brian (instantiate person 'Brian BH-Office))
(ask Brian 'put 'strength 30)
(define hacker (instantiate person 'hacker 61A-Lab))
(ask hacker 'put 'strength 30)
(define nasty (instantiate thief 'nasty Sproul-Plaza))

; (define s-h-exit-count 0)
; (define (sproul-hall-exit)
;   (begin
;     (set! s-h-exit-count (+ 1 s-h-exit-count))
;     (if (<= s-h-exit-count 3)
;         (error "You can check out any time you'd like, but you can never leave")
;         ))
;   )

(define (bh-office-exit)
  (print "What's your favorite programming language?")
  (print "scheme")
  (print "Good answer, but my favorite is Logo!")
  ; comment lines below for now so they dont stop program run
  ; (let ((answer (read)))
  ;   (if (eq? answer 'scheme)
  ; (print "Good answer, but my favorite is Logo!")
  ; (begin (newline) (bh-office-exit))))
  )


(ask s-h 'add-entry-procedure
     (lambda () (print "Miles and miles of students are waiting in line...")))
; (ask s-h 'add-exit-procedure sproul-hall-exit) ; comment for now (annoying)
(ask BH-Office 'add-exit-procedure bh-office-exit)
(ask Noahs 'add-entry-procedure
     (lambda () (print "Would you like lox with it?")))
(ask Noahs 'add-exit-procedure
     (lambda () (print "How about a cinnamon raisin bagel for dessert?")))
(ask Telegraph-Ave 'add-entry-procedure
     (lambda () (print "There are tie-dyed shirts as far as you can see...")))
(ask 61A-Lab 'add-entry-procedure
     (lambda () (print "The computers seem to be down")))
(ask 61A-Lab 'add-exit-procedure
     (lambda () (print "The workstations come back to life just in time.")))

;; Some things.

(define bagel (instantiate thing 'bagel))
(ask Noahs 'appear bagel)

(define coffee (instantiate thing 'coffee))
(ask Intermezzo 'appear coffee)


;; my code starts here

(define (name obj) (ask obj 'name))
(define (inventory obj)
  (if (person? obj)
      (map name (ask obj 'possessions))
      (map name (ask obj 'things))))
(define (inventory1 person) (car (ask person 'possessions)))
(define (whereis person)
  (ask (ask person 'place) 'name))
(define (owner thing)
  (let ((possessor (ask thing 'possessor)))
    (if (person? possessor)
        (ask possessor 'name)
        'no-one)
    ))

; Create a new person to represent yourself.  Put yourself in a new place
; called Dormitory (or wherever you live) and connect it to campus so that you
; can get there from here.  Create a place called Kirin, north of Soda.
; (It's actually on Solano Avenue.)  Put a thing called Potstickers there.
(define Dormitory (instantiate place 'Dormitory))
(define Kirin (instantiate place 'Kirin))

(can-go Soda 'north Kirin)
(can-go Kirin 'south Soda)

(define Potstickers (instantiate thing 'Potstickers))
(ask Kirin 'appear Potstickers)

(define Me (instantiate person 'Me Dormitory))
(ask Me 'put 'strength 30)
(can-go Pimentel 'east Dormitory)
(can-go Dormitory 'west Pimentel)

(define Garage (instantiate garage 'Garage#1))
(can-go Pimentel 'up Garage)
(can-go Garage 'down Pimentel)

; give the necessary commands to move your character to Kirin,
; take the Potstickers
; (ask Me 'go 'west)
; (ask Me 'go 'north)
; (ask Me 'go 'north)
; (ask Me 'take Potstickers)

; then move yourself to where Brian is, put down the
; Potstickers, and have Brian take them
; (ask Me 'go 'south)
; (ask Me 'go 'up)
; (ask Me 'go 'west)
; (ask Brian 'take Potstickers)

; then go back to the lab and get back to work
; (ask Me 'go 'east)
; (ask Me 'go 'down)
; (ask Me 'go 'south)
; (ask Me 'go 'south)


; A4a
; (define singer (instantiate person 'rick Sproul-Plaza))
; (ask singer 'set-talk "My funny valentine, sweet comic valentine")
; (define preacher (instantiate person 'preacher Sproul-Plaza))
; (ask preacher 'set-talk "Praise the Lord")
; (define street-person (instantiate person 'harry Telegraph-Ave))
; (ask street-person 'set-talk "Brother, can you spare a buck")


; A5 Garage implementation
; (define car1 (instantiate thing 'car))
; (ask Garage 'appear car1)
; (ask Me 'go 'west)
; (ask Me 'go 'up)
; (ask Me 'take car1)
; (ask Garage 'park car1)
; (ask Garage 'unpark (inventory1 Me))

; B3
; (define Guy1 (instantiate person 'Guy1 Noahs))
; (define another-bagel (instantiate thing 'another-bagel))
; (ask Noahs 'appear another-bagel)
; (ask Guy1 'take-all)

; B4a
; (ask Brian 'put 'strength 100)
; (ask Brian 'strength) ; 100

; B5
; (define Hotspot (instantiate hotspot 'asd))
; (define laptop1 (instantiate laptop Hotspot))
; (define Guy1 (instantiate person 'Guy1 Noahs))
; (ask Hotspot 'appear laptop1)
; (ask laptop1 'connect 'asd)
; (ask laptop1 'surf "http://www.cs.berkeley.edu")

; A6a
(define jail (instantiate jail))
(define thief1 (instantiate thief 'thief1 Soda))
(ask thief1 'go-directly-to jail)

; A7a
; (define guy1 (instantiate person 'Guy1 Noahs))
; (ask guy1 'money) ; 100
; (ask guy1 'get-money 50) ; 150
; (ask guy1 'pay-money 125) ; 25
; (ask guy1 'pay-money 75) ; #f

; (load "adv-world.scm")
