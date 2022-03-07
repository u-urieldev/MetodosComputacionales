#lang racket


#|Función 11 adaptada de: https://stackoverflow.com/questions/41512010/sum-items-in-list-racket|#

#|1 La funcion fahrenheit-to-celsius toma como entrada una temperatura f en grados Fahrenheit
y la convierte a su equivalente en grados Celsius usando la siguiente formula: C = 5(F-32)/9 |#
"Ejercicio 1"
(define (fahrenheit-to-celsius gradosFahrenheit)
    (/ (* 5 (- gradosFahrenheit 32)) 9.0))
(fahrenheit-to-celsius 32)



#|2 La funcion sign recibe como entrada un valor entero n. Devuelve -1 si n es negativo,
 1 si n es positivo mayor que cero, o 0 si n es cero.|#
"Ejercicio 2"

(define (sign numero)
    (if (positive? numero) 1 (if(negative? numero)-1 0)))

(sign 0)


#|3 La funcion roots devuelve la raiz que resuelve una ecuacion cuadratica a partir de sus tres coeficiente, a, b y
c, que se reciben como entrada. |#
"Ejercicio 3"

(define (roots a b c)
    (/ (+(* -1.0 b) (sqrt(- (expt b 2) (* 4.0 a c)))) (* 2.0 a)))

(roots 2 4 2)

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
(bmi 120 1.6)

#|5 La funcion factorial toma un entero positivo n como su entrada y devuelve el factorial
correspondiente, que matematicamente se define asi:|#
"Ejercicio 5"
(define (factorial n)
    (if(equal? n 0)1 (* n (factorial (- n 1)))))

(factorial 40)


#|7 La funcion pow toma dos entradas como entrada: un numero a y un entero positivo b. Devuelve el resultado
de calcular a elevado a la potencia b.|#
"Ejercicio 7"

(define (pow a b)
  (expt a b))

(pow 5 0)

#|8 La funcion fib toma un entero positivo n como entrada y devuelve el elemento 
correspondiente de la secuencia de Fibonacci, que se define matematicamente como:
|#
(define (fib n)
  (if (<= n 1) 1 (+ (fib (- n 1)) (fib (- n 2))) ))
(fib 8)

#|9La funcion enlist coloca dento de una lista a cada elemento de nivel superior de la lista que recibe como
entrada..|#
"Ejercicio 9"

#| Prueba
(define (enlist b)
        (if (empty? b) b (begin(list(first b))  (enlist(rest b)))))|#

(define (enlist b)
     (map list b ))


(enlist '())
(enlist '(a b c))
(enlist '((1 2 3) 4 (5) 7 8))

#|11 La funcion add-list devuelve la suma de los numeros contenidos en la lista que recibe como entrada, o 0 si
esta vacıa..|#
"Ejercicio 11"
(define (add-list lista)
  (apply + lista))

(add-list '())
(add-list '(2 4 1 3))
(add-list '(1 2 3 4 5 6 7 8 9 10))

#|13 La funcion de list-of-symbols? toma una lista lst como entrada. Devuelve verdadero si todos los elementos
(posiblemente cero) contenidos en lst son sımbolos, o falso en caso contrario.|#
"Ejercicio 11"

(define (list-of-symbols)
  
)



