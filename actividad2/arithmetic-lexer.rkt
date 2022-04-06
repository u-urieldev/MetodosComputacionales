#lang racket

#|
Alvaro Garcia
Uriel Aguilar

2022-03-18

Simple implementation of a Deterministic Finite Automaton
Identify all the token types in an arithmetical expresion string

Part of this code Gilberto Echeverria.
|#

(require racket/trace)

; Structure that describes a Deterministic Finite Automaton
(struct dfa-str (initial-state accept-states transitions))

(define (operator? char)
  "Function for identify an operator"  
  (member char '(#\+ #\- #\* #\/ #\^ #\=)))


(define (sign? char)
    "Function for identify a sign"
  (member char '(#\+ #\-)))


(define (delta-arithmetic-1 state character)
    "Transition to identify basic arithmetic operations "
    (case state
      ['start (cond
        [(eq? character #\() (values #f 'par_open)]
        [(sign? character) (values #f 'n_sign)]
        [(char-numeric? character) (values #f 'int)]
        [(char-alphabetic? character) (values #f 'var)] ;Cambio para que no empiece con _
        [(char-whitespace? character) (values 'start 'empty)]
        [else (values #f 'fail)]
      )]

      ['par_open (cond
        [(eq? character #\() (values #f 'par_open)]
        [(eq? character #\)) (values 'par_open 'par_closed)]
        [(sign? character) (values 'par_open 'n_sign)] ; Cambio de #f por par_open
        [(char-numeric? character) (values ''par_open 'int)]
        [(char-alphabetic? character) (values 'par_open 'var)] ;Cambio para que no empiece con _
        [(char-whitespace? character) (values ''par_open 'empty)]
        [else (values #f 'fail)]
      )]
      
      ['par_closed (cond
        ;;; [(eq? character #\() (values #f 'par_closed)]
        [(eq? character #\)) (values 'par_open 'par_closed)]
        [(operator? character) (values 'par_closed 'op)]
        [(char-whitespace? character) (values 'par_closed 'empty)]
        [else (values #f 'fail)]
      )]

      ['n_sing (cond ; Arreglar esto
        [(char-numeric? character) (values #f 'int)]
        [else (values #f 'fail)]
      )] 

      ['int (cond
        [(eq? character #\)) (values 'int 'par_closed)]
        [(char-numeric? character) (values #f 'int)]
        [(eq? character #\.) (values #f 'real)]
        [(or (eq? character #\e) (eq? character #\E)) (values #f 'real-exp)]
        [(operator? character) (values 'int 'op)]
        [(char-whitespace? character) (values 'int 'empty)]
        [else (values #f 'fail)]
      )]

      ['real (cond
        [(eq? character #\)) (values 'real 'par_closed)]
        [(char-numeric? character) (values #f 'real)]
        [(or (eq? character #\e) (eq? character #\E)) (values #f 'real-exp)]
        [(operator? character) (values 'real 'op)]
        [(char-whitespace? character) (values 'real 'empty)]
        [else (values #f 'fail)]
      )]

      ['real-exp (cond
        [(char-numeric? character) (values #f 'real)]
        [else (values #f 'fail)]
      )]

      ['var (cond
        [(eq? character #\)) (values 'var 'par_closed)]
        [(char-numeric? character) (values #f 'var)]
        [(or (char-alphabetic? character) (eq? character #\_)) (values #f 'var)]
        [(operator? character) (values 'var 'op)]
        [(char-whitespace? character) (values 'start 'empty)]
        [else (values #f 'fail)]
      )]

      ['op (cond
        [(eq? character #\() (values 'op 'par_open)]
        [(sign? character) (values 'op 'n_sign)]
        [(char-numeric? character) (values 'op 'int)]
        [(char-alphabetic? character) (values 'op 'var)] ;Modifica
        [(char-whitespace? character) (values 'op 'empty)]
        [else (values #f 'fail)]
      )]

      ['empty (cond
        [(eq? character #\() (values #f 'par_open)]
        [(eq? character #\)) (values #f 'par_closed)]
        [(char-numeric? character) (values #f 'int)]
        [(or (char-alphabetic? character) (eq? character #\_)) (values #f 'var)]
        [(operator? character) (values #f 'op)]
        [(char-whitespace? character) (values #f 'empty)]
        [else (values #f 'fail)]
      )]

      ['fail (values #f 'fail)]
    )
)


(define (automaton-2 dfa input-string)
  "Evaluate a string to validate or not according to a DFA."
  "Return a list of the tokens found"

  (trace-let loop
    ([state (dfa-str-initial-state dfa)]    ; Current state
     [chars (string->list input-string)]    ; List of characters
     [result null])
     ;añadir aquí la lista para el token completo
    ; List of tokens found
    (if (empty? chars)
      ; Check that the final state is in the accept states list
      ;(member state (dfa-str-accept-states dfa))
      (if (member state (dfa-str-accept-states dfa))
        (reverse (cons state result)) #f)
      ; Recursive loop with the new state and the rest of the list
      (let-values
        ; Get the new token found and state by applying the transition function
        ([(token state) ((dfa-str-transitions dfa) state (car chars))])
        (loop
          state
          (cdr chars)
          ; Update the list of tokens found
          ;añadir aquí el char a la lista
          ;si el token es verdadero añadir aquí el token completo
          (if token (cons token result) result))))))
;

(define (arithmetic-lexer input-string) 
    (automaton-2 (dfa-str 'start '(int var real par_closed) delta-arithmetic-1) "2.5E8+a")
)

(arithmetic-lexer "3+3")

; 1--5