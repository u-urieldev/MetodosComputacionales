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
;Función para vaciar lista

(provide arithmetic-lexer)

(define (empty-list lista)
  (if (not(empty? lista)) (begin 
          (remove first lista)
          (empty-list (rest lista)))
           lista))
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
        [(char-alphabetic? character) (values #f 'var)]
        [(char-whitespace? character) (values #f 'empty)]
        [else (values #f 'fail)]
      )]

      ['par_open (cond
        [(eq? character #\() (values #f 'par_open)]
        [(eq? character #\)) (values 'par_open 'par_close)]
        [(sign? character) (values 'par_open 'n_sign)] ; Cambio de #f por par_open
        [(char-numeric? character) (values 'par_open 'int)]
        [(char-alphabetic? character) (values 'par_open 'var)] ;Cambio para que no empiece con _
        [(char-whitespace? character) (values 'par_open 'empty)]
        [else (values #f 'fail)]
      )]
      
      ['par_close (cond
        [(eq? character #\() (values #f 'par_close)]
        [(eq? character #\)) (values 'par_open 'par_close)]
        [(operator? character) (values 'par_close 'op)]
        [(char-whitespace? character) (values 'par_close 'empty)]
        [else (values #f 'fail)]
      )]

      ['n_sign (cond 
        [(char-numeric? character) (values #f 'int)]
        [else (values #f 'fail)]
      )] 

      ['int (cond
        
        [(eq? character #\)) (values 'int 'par_close)]
        [(char-numeric? character) (values #f 'int)]
        [(eq? character #\.) (values #f 'float)]
        [(or (eq? character #\e) (eq? character #\E)) (values #f 'exp)]
        [(operator? character) (values 'int 'op)]
        [(char-whitespace? character) (values 'int 'empty)]
        [else (values #f 'fail)]
      )]

      ['float (cond
        [(eq? character #\)) (values 'float 'par_close)]
        [(char-numeric? character) (values #f 'float)]
        [(or (eq? character #\e) (eq? character #\E)) (values #f 'exp)]
        [(operator? character) (values 'float 'op)]
        [(char-whitespace? character) (values 'float 'empty)]
        [else (values #f 'fail)]
      )]

      
      
      ['exp (cond
        [(sign? character) (values #f 'exp)]
        [(char-numeric? character) (values #f 'exp)]
        [(eq? character #\)) (values 'exp 'par_close)]
        [(operator? character) (values 'exp 'op)]
        [(char-whitespace? character) (values 'exp 'empty)]
        [else (values #f 'fail)]
      )]

      ['var (cond
        [(eq? character #\)) (values 'var 'par_close)]
        [(char-numeric? character) (values #f 'var)]
        [(or (char-alphabetic? character) (eq? character #\_)) (values #f 'var)]
        [(operator? character) (values 'var 'op)]
        [(char-whitespace? character) (values 'var 'empty)]
        [else (values #f 'fail)]
      )]

      ['op (cond
        [(eq? character #\() (values 'op 'par_open)]
        [(sign? character) (values 'op 'n_sign)]
        [(char-numeric? character) (values 'op 'int)]
        [(char-alphabetic? character) (values 'op 'var)] ;Modifica
        [(char-whitespace? character) (values 'op 'empty-after-op)]
        [else (values #f 'fail)]
      )]

      ['empty-after-op (cond
        [(eq? character #\() (values #f 'par_open)]
        [(eq? character #\)) (values #f 'par_close)]
        [(char-numeric? character) (values #f 'int)]
        [(or (char-alphabetic? character) (eq? character #\_)) (values #f 'var)]
        [(sign? character) (values #f 'int)]
        [(char-whitespace? character) (values #f 'empty-after-op)]
        [else (values #f 'fail)]
      )]
      ['empty (cond
        [(eq? character #\() (values #f 'par_open)]
        [(eq? character #\)) (values #f 'par_close)]
        [(char-numeric? character) (values #f 'int)]
        [(or (char-alphabetic? character) (eq? character #\_)) (values #f 'var)]
        [(operator? character) (values #f 'op)]
        [(char-whitespace? character) (values #f 'empty)]
        [else (values #f 'fail)]
      )]

      ['fail (values #f 'fail)]
    )
)



; Structure that describes a Deterministic Finite Automaton


(define (automaton-2 dfa input-string)
  " Evaluate a string to validate or not according to a DFA.
  Return a list of the tokens found"
  ;trace-
  (trace-let loop
    ([state (dfa-str-initial-state dfa)]    ; Current state
     [chars (string->list input-string)]
     [token-list null]; List of characters
     [result null]
 
     )
    
    ; List of tokens found
    (if (empty? chars)
      ; Check that the final state is in the accept states list
      ;(member state (dfa-str-accept-states dfa))xx
      (if (member state (dfa-str-accept-states dfa))
        (reverse (cons (list(list->string (reverse token-list)) state) result)) #f)
      ; Recursive loop with the new state and the rest of the list
      (let-values
        ; Get the new token found and state by applying the transition function
        ([(token state) ((dfa-str-transitions dfa) state (car chars))])
       
        (loop
          state
          (cdr chars)
          ; Update the list of tokens found                                                       
          (if  token (if (char-whitespace?(car chars))(empty-list token-list) (cons (car chars)(empty-list token-list))) (cons (car chars) token-list))
           (if token (cons (list (list->string (reverse token-list)) token) result)result) )))))


(define (arithmetic-lexer input-string) 
    (automaton-2 (dfa-str 'start '(int var float par_close exp) delta-arithmetic-1) input-string)
)



;(arithmetic-lexer (dfa-str 'start '(int var float par_close) delta-arithmetic-1) "2")


;falta sign a float y que marque exponenetes