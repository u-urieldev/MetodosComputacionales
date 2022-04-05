#lang racket

#|
Alvaro Garcia
Uriel Aguilar

2022-03-18

Simple implementation of a Deterministic Finite Automaton
Identify all the token types in an arithmetical expresion string

Part of this code Gilberto Echeverria.
|#

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


(define (arithmetic-lexer input_string) 
    (automaton-2 (dfa-str 'start '(int var float real par_closed) delta-arithmetic-1) input-string)
)