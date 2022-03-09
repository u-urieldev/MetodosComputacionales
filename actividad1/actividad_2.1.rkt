#|
  Alvaro Garcia A01781511
  Uriel Aguilar A01781698

  09/March/2022
  Activity 2: Functional Programming
|#

#lang racket




"Tests of exercices 1 to 11 deactivated"

#|1 The fahrenheit-to-celsius function takes as an input a temperature f in degrees Fahrenheit
and converts it to its equivalent in degrees Celsius using the following formula: C = 5(F-32)/9 |#
"Ejercicio 1"
(define (fahrenheit-to-celsius FahrenheitDegrees)
    (/ (* 5 (- FahrenheitDegrees 32)) 9.0))

;;; (fahrenheit-to-celsius 32)


#|2 The function sign receives as input an integer value n. It returns -1 if n is negative,
 1 if n is positive greater than zero, or 0 if n is zero.|#
"Ejercicio 2"

(define (sign number)
    (if (positive? number) 1 (if(negative? number)-1 0)))

;;; (sign 0)


#|3 The roots function returns the root that solves a quadratic equation from its three coefficients, a, b and c, received as input.
c, which are received as input. |#
"Ejercicio 3"

(define (roots a b c)
    (/ (+(* -1.0 b) (sqrt(- (expt b 2) (* 4.0 a c)))) (* 2.0 a)))

;;; (roots 2 4 2)


#|4 The bmi function receives two inputs: weight and height. It must return a symbol representing the description of the corresponding BMI
of the corresponding BMI calculated from its inputs..|#
"Ejercicio 6"
(define (bmi_aux bmi_index)
  (cond [(< bmi_index 20) "underweight"] 
        [(and (>= bmi_index 20) (< bmi_index 25)) "normal"] 
        [(and (>= bmi_index 25) (< bmi_index 30)) "obese1"] 
        [(and (>= bmi_index 30) (< bmi_index 40)) "obese2"] 
        [else "obese3"]
  )
)

(define (bmi weight height)
  (bmi_aux (/ weight (expt height 2)))
)

;;; (bmi 120 1.6)


#|5 The factorial function takes a positive integer n as its input and returns the corresponding factorial, which is mathematically defined as follows
corresponding factorial, which is mathematically defined as follows|#
"Ejercicio 5"
(define (factorial n)
    (if(equal? n 0)1 (* n (factorial (- n 1)))))

;;; (factorial 40)


#|7 The pow function takes two inputs as input: a number a and a positive integer b. It returns the result
of calculating a raised to the power b.|#
"Ejercicio 7"

(define (pow a b)
  (expt a b))

;;; (pow 5 0)


#|8 The fib function takes a positive integer n as input and returns the corresponding element of the Fibonacci sequence, which is defined mathematically as 
corresponding element of the Fibonacci sequence, which is mathematically defined as:
|#
(define (fib n)
  (if (<= n 1) 1 (+ (fib (- n 1)) (fib (- n 2))) ))

;;; (fib 8)


#| 9 The function enlist places each top-level element of the list that it receives as input into a list.
input..|#
"Ejercicio 9"

#| Prueba
(define (enlist b)
        (if (empty? b) b (begin(list(first b))  (enlist(rest b)))))|#

(define (enlist b)
     (map list b ))


;;; (enlist '())
;;; (enlist '(a b c))
;;; (enlist '((1 2 3) 4 (5) 7 8))


#|11 The add-list function returns the sum of the numbers contained in the list it receives as input, or 0 if it is empty.
is empty|#
"Exercise 11"
(define (add-list lista)
  (apply + lista))

;;; (add-list '())
;;; (add-list '(2 4 1 3))
;;; (add-list '(1 2 3 4 5 6 7 8 9 10))


#|13 The list-of-symbols? function takes a list lst as input. It returns true if all elements (possibly zero) contained in lst are symbols, or false otherwise.
(possibly zero) contained in lst are symbols, otherwise false.|#
"Ejercicio 11"

(define (list-of-symbols lista)
  (if (empty? lista) #true
      (if (symbol?(first lista))
          (list-of-symbols (rest lista))
          #false) ))

;;; (list-of-symbols '())
;;; (list-of-symbols '(a b c d e))
;;; (list-of-symbols '(a b c d 42 e))


#|15  The dot-product function takes two inputs: the lists a and b. It returns the result of performing the dot product
dot product of a by b. The dot-product is an algebraic operation that takes two sequences of numbers of equal length and returns a single number that is obtained by multiplying the elements in
equal length and returns a single number that is obtained by multiplying the elements in the same position and then adding those
then adding those products together. Its formula is

 |#
"Exercise 15 dot product"

(define (dot-product lista1 lista2)
  (let loop
    ([lista1 lista1] [lista2 lista2] [result 0])
    (if (empty? lista1)
        result
        (loop (rest lista1)(rest lista2)(+ result (* (first lista1) (first lista2)))))))


(dot-product '() '())
(dot-product '(1 2 3) '(4 5 6))
(dot-product '(1.3 3.4 5.7 9.5 10.4) '(-4.5 3.0 1.5 0.9 0.0))

#|16  The function average receives a list of lst numbers as input. It returns the arithmetic mean of the elements contained in lst, or
elements contained in lst, or 0 if lst is empty. The arithmetic mean (_x) is defined as: |#
"Exercise 16: Average"

(define (average lst)
  ;We use the funcion previosly define in exercice 11
  (/ (add-list lst) (length lst))
)

(average '(1 2 3))
(average '(1 1 1))
(average '(4 2 9))

#|17 The standard-deviation function receives a list of lst numbers as input. It returns the standard deviation of the
standard deviation of the population of elements contained in lst, or 0 if lst is empty. The population standard deviation
population standard deviation () is defined as:|#
"Exercise 17: Standar Deviation"


(define (mean lst)
  (let loop
    ([lista lst][n (length lst)][sum 0])
     (if (empty? lista) (if (eq? sum 0) 0 (/ sum n))
       (loop (rest lista) (+ n 0) (+ (first lista) sum) ))))

(define (standard-deviation lst)
  (let loop
    ([lista lst][mean (mean lst)][result 0])
    (if (empty? lista) (if (eq? result 0)0 (sqrt (/ result (length lst))))
        (loop (rest lista)(+ mean 0)(+ result (expt (- (first lista) mean) 2))))))


(standard-deviation '())
(standard-deviation '(4 8 15 16 23 42))
(standard-deviation '(110 105 90 100 95))
(standard-deviation '(9 2 5 4 12 7 8 11 9 3 7 4 12 5 4 10 9 6 9 4))


#|20 The binary function receives an integer n as input (n ≥ 0). If n is equal to zero, it returns an empty list.
If n is greater than zero, it returns a list with a sequence of ones and zeros equivalent to the binary representation of n.
binary representation of n.
|#
"Exercise 20: Binary to decimal"

(define (bin_aux n lst)
  (cond [(zero? n ) (reverse lst)]
        [(bin_aux (quotient n 2) (append lst (list (remainder n 2))))]
  )
)

(define (binary n)
  (bin_aux n '())
)

(binary 0)
(binary 30)
(binary 45123)
