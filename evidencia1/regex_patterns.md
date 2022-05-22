# Regex Patterns for JSON

We add the negative lookahead <code>(?!.*")</code> to match 
expresions out of quotes.

* **Keys:** 
    > <p> "(\s*[^" [])*"(?=\s*:)|(?!) </p>

* **Puntuation:**
    > <p> (:|,|\[|\]|\{|\})(?![^<]*>|[^<>]*<\/) </p>

* **Numbers:** 
    > <p> -?\d+\.?\d*([eE]?[-\+]?\d+)?(?!.*") </p>

* **Reserved Words:**
    > <p> (true|false|null)(?!.*") </p>

* **String:**
    > <p>  (:|,|\[|\]|\{|\})(?![^<]*>|[^<>]*<\/) </p>
