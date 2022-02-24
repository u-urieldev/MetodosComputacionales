; First examples of functions in racket

; Uriel Aguilar 2022-02-22

; Determinar the languaje to use the interpreter
#lang racket

; Determine the area of a tringle
(define (triangle-area base height)
    (/ (* base height) 2.0 ))

;def triangle-area(base, height):
;   return (base * height) /2

; Call the function
(triangle-area 7 3)

