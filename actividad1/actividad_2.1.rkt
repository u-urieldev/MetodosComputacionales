#|
  Alvaro Garcia A01781511
  Uriel Aguilar A01781698

  Actividad 2: Programacion Funcional
|#

#lang racket

#|Función 11 adaptada de: https://stackoverflow.com/questions/41512010/sum-items-in-list-racket|#


"Tests of exercices 1 to 11 deactivated"

#|1 La funcion fahrenheit-to-celsius toma como entrada una temperatura f en grados Fahrenheit
y la convierte a su equivalente en grados Celsius usando la siguiente formula: C = 5(F-32)/9 |#
"Ejercicio 1"
(define (fahrenheit-to-celsius gradosFahrenheit)
    (/ (* 5 (- gradosFahrenheit 32)) 9.0))

;;; (fahrenheit-to-celsius 32)


#|2 La funcion sign recibe como entrada un valor entero n. Devuelve -1 si n es negativo,
 1 si n es positivo mayor que cero, o 0 si n es cero.|#
"Ejercicio 2"

(define (sign numero)
    (if (positive? numero) 1 (if(negative? numero)-1 0)))

;;; (sign 0)


#|3 La funcion roots devuelve la raiz que resuelve una ecuacion cuadratica a partir de sus tres coeficiente, a, b y
c, que se reciben como entrada. |#
"Ejercicio 3"

(define (roots a b c)
    (/ (+(* -1.0 b) (sqrt(- (expt b 2) (* 4.0 a c)))) (* 2.0 a)))

;;; (roots 2 4 2)


#|4 La funcion bmi recibe dos entrada: weight y height. Debe devolver un simbolo que represente la descripcion
del BMI correspondiente calculado a partir de sus entradas.|#
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


#|5 La funcion factorial toma un entero positivo n como su entrada y devuelve el factorial
correspondiente, que matematicamente se define asi:|#
"Ejercicio 5"
(define (factorial n)
    (if(equal? n 0)1 (* n (factorial (- n 1)))))

;;; (factorial 40)


#|7 La funcion pow toma dos entradas como entrada: un numero a y un entero positivo b. Devuelve el resultado
de calcular a elevado a la potencia b.|#
"Ejercicio 7"

(define (pow a b)
  (expt a b))

;;; (pow 5 0)


#|8 La funcion fib toma un entero positivo n como entrada y devuelve el elemento 
correspondiente de la secuencia de Fibonacci, que se define matematicamente como:
|#
(define (fib n)
  (if (<= n 1) 1 (+ (fib (- n 1)) (fib (- n 2))) ))

;;; (fib 8)


#|9La funcion enlist coloca dento de una lista a cada elemento de nivel superior de la lista que recibe como
entrada..|#
"Ejercicio 9"

#| Prueba
(define (enlist b)
        (if (empty? b) b (begin(list(first b))  (enlist(rest b)))))|#

(define (enlist b)
     (map list b ))


;;; (enlist '())
;;; (enlist '(a b c))
;;; (enlist '((1 2 3) 4 (5) 7 8))


#|11 La funcion add-list devuelve la suma de los numeros contenidos en la lista que recibe como entrada, o 0 si
esta vacia|#
"Ejercicio 11"
(define (add-list lista)
  (apply + lista))

;;; (add-list '())
;;; (add-list '(2 4 1 3))
;;; (add-list '(1 2 3 4 5 6 7 8 9 10))


#|13 La funcion de list-of-symbols? toma una lista lst como entrada. Devuelve verdadero si todos los elementos
(posiblemente cero) contenidos en lst son sımbolos, o falso en caso contrario.|#
"Ejercicio 11"

(define (list-of-symbols lista)
  (if (empty? lista) #true
      (if (symbol?(first lista))
          (list-of-symbols (rest lista))
          #false) ))

;;; (list-of-symbols '())
;;; (list-of-symbols '(a b c d e))
;;; (list-of-symbols '(a b c d 42 e))


#|15  La funciion dot-product toma dos entradas: las listas a y b. Devuelve el resultado de realizar el producto
punto de a por b. El producto punto es una operacion algebraica que toma dos secuencias de numeros de
igual longitud y devuelve un solo numero que se obtiene multiplicando los elementos en la misma posicion y
luego sumando esos productos. Su formula es |#
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

#|16  La funcion average recibe una lista de numeros lst como entrada. Devuelve la media aritmetica de los
elementos contenidos en lst, o 0 si lst esta vaca. La media aritmetica (_x) se define como: |#
"Exercise 16: Average"

(define (average lst)
  ;We use the funcion previosly define in exercice 11
  (/ (add-list lst) (length lst))
)

(average '(1 2 3))
(average '(1 1 1))
(average '(4 2 9))

#|17 La funcion standard-deviation recibe una lista de numeros lst como entrada. Devuelve la desviacion
estandar de la poblacion de los elementos contenidos en lst, o 0 si lst esta vacia. La desviacion estandar de
la poblacion () se define como:|#
"Exercise 17: Standar Deviation"

;mean
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


#|20 La funcion binary recibe un entero n como entrada (n ≥ 0). Si n es igual a cero, devuelve una lista vacia.
Si n es mayor que cero, devuelve una lista con una secuencia de unos y ceros equivalente a la representacion
binaria de n.
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