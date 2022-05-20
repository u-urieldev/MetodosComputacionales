# Regex Patterns for JSON

Agregamos el lookahead negativo <code>(?!.*")</code> para matchear
lo que este afuera de las comillas.

* **Keys:** 
    > <p> "(\s*[^" [])*"(?=\s*:)|(?!) </p>

* **Puntuation:**
    > <p> \{|\}|:|\[|\]|,(?!.*") </p>

* **Numbers:** 
    > <p> -?\d+\.?\d*([eE]?[-\+]?\d+)?(?!.*") </p>

* **Boolean:**
    > <p> (true|false)(?!.*") </p>

* **Null:**
    > <p> null(?!.*") </p>

* **String: (por decidir)**
    > <p> "(\s*\w+[^"])*"(?!\s*:)|(?!) </p>
    > <p> -> "(\s*[^" [])*"(?!\s*:)|(?!) </p> 
    > <p> --> [^>]"(\w+\s*[^"])*"|(?!) </p>
    > <p> ---->[^>]"(\s*[^"])*"|(?!) </p>
