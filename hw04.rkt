;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname hw04) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Elias Afzalzada
;HW04

(require 2htdp/image)
(require 2htdp/universe)

;Part 1:

; [Design recipe step 1]
; Data definition: A team is:
;  - a non-empty string called "name" (representing their team name)
;  - a real number called "offense" (representing their Offense stat)
;  - a real number called "defense" (representing their Defense stat)
; make-team : non-empty string real real -> team
(define-struct team (name offense defense))

; [Design recipe step 2]
; Examples of the data
;(make-team "Radford Highlanders" 80 60)
;(make-team "Virginia Tech" 70 80)
;(make-team "James Madison University" 70 70)

; [Design recipe step 3]
; Template for any team function
;(define (func-for-team team)
;  (... (team-name a-team)
;   ... (team-offense a-team)
;   ... (team-defense a-team)))

;Part 2:
;team>? : team team -> boolean
;Takes in two teams and determines if the first team is "greater" than the second team
;greater team is the one with a higher offense and defense against the second team
(define (team>? t1 t2)
  (and (> (team-offense t1) (team-defense t2))
       (> (team-defense t1) (team-offense t2))))
  
;Tests for team>? function
(check-expect (team>? (make-team "Virginia Tech" 12 41) (make-team "James Madison University" 50 50)) #false)
(check-expect (team>? (make-team "James Madison University" 70 70) (make-team "Radford Highlanders" 70 70)) #false)
(check-expect (team>? (make-team "Radford Highlanders" 85 60) (make-team "James Madison University" 80 70)) #false)
(check-expect (team>? (make-team "Virginia Tech" 70 75) (make-team "James Madison University" 70 70)) #false)
(check-expect (team>? (make-team "James Madison University" 80 80) (make-team "Virginia Tech" 79 79)) #true)
(check-expect (team>? (make-team "Radford Highlanders" 1321 1145) (make-team "James Madison University" 999 999)) #true)

;Part 5:
; [Design recipe step 1]
; Data definition: A ball is:
; - a real number x (representing the ball's current x coordinate)
; - a real number y (representing the ball's current y coordinate)
; - a real number xDir (representing the x heading direction of the ball -1 means left +1 means right)
; - a real number yDir (representing the y heading direction of the ball -1 means down +1 means up)
; make-ball : real real real real -> ball
(define-struct ball(x y xDir yDir))

; [Design recipe step 2]
; Examples of the data
;(make-ball 50 50 1 -1) 
;(make-ball 34 -12 -1 1)
;(make-ball -10 -24 1 1)

; [Design recipe step 3]
; Template for any ball function
;(define (func-for-ball ball)
;  (... (ball-x a-ball)
;   ... (ball-y a-ball)
;   ... (ball-xDir a-ball)
;   ... (ball-yDir a-ball)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; [Design recipe step 1]
; Data definition: A paddle is:
; - a real number x (representing the paddle current x coordinate)
; - a real number xDir (representing the x heading direction of the ball -1 means left +1 means right)
; make-paddle : real real -> paddle
(define-struct paddle(x xDir))

; [Design recipe step 2]
; Examples of the data
;(make-paddle 0 1) 
;(make-paddle 20 -1)
;(make-paddle -10 1)

; [Design recipe step 3]
; Template for any paddle function
;(define (func-for-paddle paddle)
;  (... (paddle-x a-paddle)
;   ... (paddle-xDir a-paddle)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; [Design recipe step 1]
; Data definition: A brick is:
; - a real number x (representing the brick's x coordinate)
; - a real number y (representing the brick's y coordinate)
; make-brick : real real -> brick
(define-struct brick(x y))

; [Design recipe step 2]
; Examples of the data
;(make-birck 10 10) 
;(make-brick 11 11)
;(make-brick 50 0)

; [Design recipe step 3]
; Template for any brick function
;(define (func-for-brick brick)
;  (... (brick-x a-brick)
;   ... (brick-y a-brick)))


;Part 6:
;move-ball : ball -> ball
;Takes in a ball and returns a new ball moved in a tick
(define (move-ball a-ball)
  (make-ball (+ (ball-x a-ball) (ball-xDir a-ball))
             (+ (ball-y a-ball) (ball-yDir a-ball))
             (ball-xDir a-ball)
             (ball-yDir a-ball)))

;Tests for move-ball function
(check-expect(move-ball (make-ball 50 50 1 1)) (make-ball 51 51 1 1))
(check-expect(move-ball (make-ball -12 21 1 1)) (make-ball -11 22 1 1))
(check-expect(move-ball (make-ball 13 -28 1 1)) (make-ball 14 -27 1 1))
(check-expect(move-ball (make-ball 81 90 -1 1)) (make-ball 80 91 -1 1))
(check-expect(move-ball (make-ball -62 39 1 -1)) (make-ball -61 38 1 -1))
(check-expect(move-ball (make-ball 10 -29 -1 -1)) (make-ball 9 -30 -1 -1))
(check-expect(move-ball (make-ball -1034 -2341 -1 -1)) (make-ball -1035 -2342 -1 -1))

;Part 7:
;bounce-side : ball -> ball
;Changes the direction the ball is moving on its x-axis (-1 for left or +1 for right)
(define (bounce-side a-ball)
  (cond [(= (ball-xDir a-ball) 1) (make-ball (ball-x a-ball) (ball-y a-ball) -1 (ball-yDir a-ball))]
        [(= (ball-xDir a-ball) -1) (make-ball (ball-x a-ball) (ball-y a-ball) 1 (ball-yDir a-ball))]))

;Test for bounce-side function
(check-expect(bounce-side (make-ball 50 50 1 1)) (make-ball 50 50 -1 1))
(check-expect(bounce-side (make-ball -96 23 -1 1)) (make-ball -96 23 1 1))
(check-expect(bounce-side (make-ball 24 -47 1 1)) (make-ball 24 -47 -1 1))
(check-expect(bounce-side (make-ball -84 -91 -1 1)) (make-ball -84 -91 1 1))

;bounce-top : ball -> ball
;Changes the direction the ball is moving on its y-axis (-1 for down or +1 for up)
(define (bounce-top a-ball)
  (cond [(= (ball-yDir a-ball) 1) (make-ball (ball-x a-ball) (ball-y a-ball) (ball-xDir a-ball) -1)]
        [(= (ball-yDir a-ball) -1) (make-ball (ball-x a-ball) (ball-y a-ball) (ball-xDir a-ball) 1)]))

;Test for bounce-top function
(check-expect(bounce-top (make-ball 50 50 1 1)) (make-ball 50 50 1 -1))
(check-expect(bounce-top (make-ball -96 23 1 -1)) (make-ball -96 23 1 1))
(check-expect(bounce-top (make-ball 24 -47 1 1)) (make-ball 24 -47 1 -1))
(check-expect(bounce-top (make-ball -84 -91 1 -1)) (make-ball -84 -91 1 1))

;Part 8:
;paddle-handle-key : paddle -> paddle
;Updates a paddle's direction in response to a keypress
(define (paddle-handle-key a-paddle key)
  (cond [(key=? key "right") (make-paddle (+ (paddle-x a-paddle) (paddle-xDir a-paddle)) (paddle-xDir a-paddle))]
        [(key=? key "left") (make-paddle (+ (paddle-x a-paddle) (paddle-xDir a-paddle)) (paddle-xDir a-paddle))]))

;Tests for the update paddle function
(check-expect(paddle-handle-key (make-paddle 0 1) "right") (make-paddle 1 1))
(check-expect(paddle-handle-key (make-paddle 0 -1) "left") (make-paddle -1 -1))
(check-expect(paddle-handle-key (make-paddle -54 1) "right") (make-paddle -53 1))
(check-expect(paddle-handle-key (make-paddle 21 -1) "left") (make-paddle 20 -1))


