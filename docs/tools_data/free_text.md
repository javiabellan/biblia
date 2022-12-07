# Regular Expressions


| | Basic REs<br>`grep`<br>`sed` | Extended REs<br>`grep -E`, `egrep`<br>`sed -E`, `awk` | Pearl/Python REs<br>`grep -P`<br>Python's `re` |
|---------------------------|:-----------:|:-----------:|:---------------:|
| **CHARACTERS**            |             |             |                 |
| Any char (except newline) | `.`         | `.`         | `.`             |
| a,b,c characters          | `[abc]`     | `[abc]`     | `[abc]`         |
| Any chars except a,b,c    | `[^abc]`    | `[^abc]`    | `[^abc]`        |
| Any digit                 | `[0-9]`     | `[0-9]`     | `[0-9]` `\d`    |
| Any chars except digits   | `[^0-9]`    | `[^0-9]`    | `[^0-9]` `\D`   |
| Any letter                | `[a-zA-Z]`  | `[a-zA-Z]`  | `[a-zA-Z]`      |
| Any letter, digit or "_"  | `\w`        | `\w`        | `\w`            |
| Not letter, digit or "_"  |             |             | `\W`            |
| Whitespace char           | `\s`        | `\s`        |                 |
| Whitespace char & newline |             |             | `\s`            |
|                           |             |             |                 |
| **QUANTIFIERS**           |             |             |                 |
| 0 or More                 | `*`         | `*`         | `*`             |
| 1 or More                 | `\+`        | `+`         | `+`             |
| 0 or 1                    | `\?`        | `?`         | `?`             |
| Exact Number              | `\{3\}`     | `{3}`       | `{3}`           |
| Range min max             | `\{3,4\}`   | `{3,4}`     | `{3,4}`         |
| 2 or More                 | `\{2,}\`    | `{2,}`      | `{2,}`          |
| 3 or Less                 | `\{,3}\`    | `{,3}`      | `{,3}`          |
|                           |             |             |                 |
| **LIMITS**                |             |             |                 |
| Beginning of line         | `^`         | `^`         | `^`             |
| End of line               | `$`         | `$`         | `$`             |
| Word boundary             | `\b`        | `\b`        | `\b`            |
| Not word boundary         | `\B`        | `\B`        | `\B`            |
|                           |             |             |                 |
| **ALTERNATION**           |             |             |                 |
| a or b                    | `\(a|b\)`   | `(a|b)`     | `(a|b)`         |
| a or b                    | `[ab]`      | `[ab]`      | `[ab]`          |
|                           |             |             |                 |
| **GROUPING**              |             |             |                 |
| Capturing a group         | `\(...\)`   | `(...)`     | `(...)`         |
| Backreference a group     | `\1`        | `\1`        | `\1`            |
|                           |             |             |                 |
| **LOOK-AROUND**           |             |             |                 |
| Positive look-behind      |             |             | `(?<=prefijo)mi_patron` |
| Negative look-behind      |             |             | `(?<!prefijo)mi_patron` |
| Positive look-ahead       |             |             | `mi_patron(?=sufijo)`   |
| Positive look-ahead       |             |             | `mi_patron(?!sufijo)`   |


> ### Pseudo look-around in `sed`
> 
> ```bash
> # Remove something behind
> sed 's/pattern2remove\(pattern2keep\)/\1/g' file.txt
> sed -E 's/pattern2remove(pattern2keep)/\1/g' file.txt
> 
> # Remove something ahead
> sed 's/\(pattern2keep\)pattern2remove/\1/g' file.txt
> sed -E 's/(pattern2keep)pattern2remove/\1/g' file.txt
> ```


### Flags

- `/.../g`: Global. Several matches per line can occur
- `/.../i`: Case insensitive



## Examples

- `.+`     Selececcionar cada linea
- `\b[A-Z]+\b`   palabras solo en mayyscula (cada palabra es un match)
- `([A-Z]+[ \t]+)+` frases solo en mayyscula (cada frase es un match)
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
- [Char ranges](https://blog.robertelder.org/character-ranges-class-negation-regular-expressions)
- https://www.youtube.com/playlist?list=PLp31D6HATKfdc5PSJTx7rIvlTLCSM5nDi
- https://www.youtube.com/watch?v=w61mxJcUV-o
- https://remram44.github.io/regex-cheatsheet/regex.html
- https://linuxize.com/post/regular-expressions-in-grep
- http://mywiki.wooledge.org/RegularExpression
- **`grep`**: print lines matching a pattern
- **`egrep`**: can handle extended regular expressions (EREs)
