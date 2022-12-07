# Regular Expressions

### Coincidencias Basicas
- `.`        Cualquier Caracter, excepto nueva linea
- `\d`       Cualquier Digitos (0-9)
- `\D`       No es un Digito (0-9)
- `\w`       Caracter de Palabra (a-z, A-Z, 0-9, _)
- `\W`       No es un Caracter de Palabra.
- `\s`       Espacios de cualquier tipo. (espacio, tab, nueva linea)
- `\S`       No es un Espacio, Tab o nueva linea.

### Caracteres especiales
- `\.`  .
- `\*`  *
- `\(`  (
- `\)`  )

### Limites
- `\b`       Limite de Palabra
- `\B`       No es un Limite de Palabra
- `^`        Inicio de una cadena de texto
- `$`        Final de una cadena de texto

### Cuantificadores
- `*`        0 o Más
- `+`        1 o Más
- `?`        0 o Uno
- `{3}`      Numero Exacto
- `{3,4}`    Rango de Numeros (Minimo, Maximo)
- `{2,}`     2 o Más

### Grupos
- `( )`      Grupo
- `|`        Uno u otro
- `\1`       Referencias (duplicar) el grupo 1 

### Conjuntos de Caracteres
- `[]`       Caracteres dentro de los brackets
  - `[abc]`  Caracteres `a` ó `b` ó `c`
  - `[a-z]`  Cualquir caracteres de la `a` a la `z`
  - `[a-z-]`  Cualquir caracteres de la `a` a la `z` o tambien `-`
  - `[a-z0-9]`  Cualquir caracteres de la `a` a la `z` y numeros
- `[^ ]`     Caracteres que NO ESTAN dentro de los brackets

> `(a|b|c)` es lo mismo que `[abc]`


### Look around

`(?<=prefijo)mi_patron`  Lookbehind          Asserts that what immediately PRECEDES the current position in the string is prefijo
`mi_patron(?=sufijo)`    Lookahead           Asserts that what immediately FOLLOWS the current position in the string is sufijo
`(?<!prefijo)mi_patron`  Negative Lookbehind Asserts that what immediately PRECEDES the current position in the string is NOT prefijo
`mi_patron(?!sufijo)`    Negative Lookahead  Asserts that what immediately FOLLOWS the current position in the string is NOT sufijo




## Examples

- `.+`     Selececcionar cada linea
- `\.(png|jpg|gif)$`




## Pseudo-regex in terminal
- `*`: Matches zero or more.
- `{a,b,c}`: [**Brace Expansion**](https://www.gnu.org/software/bash/manual/html_node/Brace-Expansion.html). Examples:
  - `ls some_dir/{subdir_A,subdir_B}`
  - `mkdir {old,new,dist,bugs}`
- [**Pattern Matching**](https://www.gnu.org/software/bash/manual/html_node/Pattern-Matching.html)
  - `?(pattern-list)`: Matches zero or one occurrence of the given patterns.
  - `*(pattern-list)`: Matches zero or more occurrences of the given patterns.
  - `+(pattern-list)`: Matches one or more occurrences of the given patterns.
  - `@(pattern-list)`: Matches one of the given patterns.
  - `!(pattern-list)`: Matches anything except one of the given patterns.




## Reference

- https://regexr.com/
- https://regex101.com/
- `man re_format`
- https://remram44.github.io/regex-cheatsheet/regex.html
- https://linuxize.com/post/regular-expressions-in-grep
- http://mywiki.wooledge.org/RegularExpression
- **`grep`**: print lines matching a pattern
- **`egrep`**: can handle extended regular expressions (EREs)