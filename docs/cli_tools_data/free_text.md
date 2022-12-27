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
| Any letter even with `´¨~`| `[a-zA-Zà-üA-ZÀ-Ü]` | `[a-zA-Zà-üA-ZÀ-Ü]` | `[a-zA-Zà-üA-ZÀ-Ü]` |
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


### Pseudo look-around in `sed`

```bash
# Remove something behind
sed 's/pattern2remove\(pattern2keep\)/\1/g' file.txt
sed -E 's/pattern2remove(pattern2keep)/\1/g' file.txt

# Remove something ahead
sed 's/\(pattern2keep\)pattern2remove/\1/g' file.txt
sed -E 's/(pattern2keep)pattern2remove/\1/g' file.txt
```


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


## ASCII



| 0-31     | 32-63  | 64-95  | 96-127    | 128-159 | 160-191 | 192-223 | 224.255 |
|:--------:|:------:|:------:|:---------:|:-------:|:-------:|:-------:|:-------:|
|  0  `\0` | 32 ` ` | 64 `@` |  96       | 128 `` | 160     | 192 `À` | 224 `à` |
|  1 `SOH` | 33 `!` | 65 `A` |  97   `a` | 129 `` | 161 `¡` | 193 `Á` | 225 `á` |
|  2 `STX` | 34 `"` | 66 `B` |  98   `b` | 130 `` | 162 `¢` | 194 `Â` | 226 `â` |
|  3 `ETX` | 35 `#` | 67 `C` |  99   `c` | 131 `` | 163 `£` | 195 `Ã` | 227 `ã` |
|  4 `EOT` | 36 `$` | 68 `D` | 100   `d` | 132 `` | 164 `¤` | 196 `Ä` | 228 `ä` |
|  5 `ENQ` | 37 `%` | 69 `E` | 101   `e` | 133 `` | 165 `¥` | 197 `Å` | 229 `å` |
|  6 `ACK` | 38 `&` | 70 `F` | 102   `f` | 134 `` | 166 `¦` | 198 `Æ` | 230 `æ` |
|  7 `BEL` | 39 `'` | 71 `G` | 103   `g` | 135 `` | 167 `§` | 199 `Ç` | 231 `ç` |
|  8 `BS`  | 40 `(` | 72 `H` | 104   `h` | 136 `` | 168 `¨` | 200 `È` | 232 `è` |
|  9 `\t`  | 41 `)` | 73 `I` | 105   `i` | 137 `` | 169 `©` | 201 `É` | 233 `é` |
| 10 `\n`  | 42 `*` | 74 `J` | 106   `j` | 138 `` | 170 `ª` | 202 `Ê` | 234 `ê` |
| 11 `\v`  | 43 `+` | 75 `K` | 107   `k` | 139 `` | 171 `«` | 203 `Ë` | 235 `ë` |
| 12 `FF`  | 44 `,` | 76 `L` | 108   `l` | 140 `` | 172 `¬` | 204 `Ì` | 236 `ì` |
| 13 `\r`  | 45 `-` | 77 `M` | 109   `m` | 141 `` | 173 `¡` | 205 `Í` | 237 `í` |
| 14 `SO`  | 46 `.` | 78 `N` | 110   `n` | 142 `` | 174 `®` | 206 `Î` | 238 `î` |
| 15 `SI`  | 47 `/` | 79 `O` | 111   `o` | 143 `` | 175 `¯` | 207 `Ï` | 239 `ï` |
| 16 `DLE` | 48 `0` | 80 `P` | 112   `p` | 144 `` | 176 `°` | 208 `Ð` | 240 `ð` |
| 17 `DC1` | 49 `1` | 81 `Q` | 113   `q` | 145 `` | 177 `±` | 209 `Ñ` | 241 `ñ` |
| 18 `DC2` | 50 `2` | 82 `R` | 114   `r` | 146 `` | 178 `²` | 210 `Ò` | 242 `ò` |
| 19 `DC3` | 51 `3` | 83 `S` | 115   `s` | 147 `` | 179 `³` | 211 `Ó` | 243 `ó` |
| 20 `DC4` | 52 `4` | 84 `T` | 116   `t` | 148 `` | 180 `´` | 212 `Ô` | 244 `ô` |
| 21 `NAK` | 53 `5` | 85 `U` | 117   `u` | 149 `` | 181 `µ` | 213 `Õ` | 245 `õ` |
| 22 `SYN` | 54 `6` | 86 `V` | 118   `v` | 150 `` | 182 `¶` | 214 `Ö` | 246 `ö` |
| 23 `ETB` | 55 `7` | 87 `W` | 119   `w` | 151 `` | 183 `·` | 215 `×` | 247 `÷` |
| 24 `CAN` | 56 `8` | 88 `X` | 120   `x` | 152 `` | 184 `¸` | 216 `Ø` | 248 `ø` |
| 25 `EM`  | 57 `9` | 89 `Y` | 121   `y` | 153 `` | 185 `¹` | 217 `Ù` | 249 `ù` |
| 26 `SUB` | 58 `:` | 90 `Z` | 122   `z` | 154 `` | 186 `º` | 218 `Ú` | 250 `ú` |
| 27 `ESC` | 59 `;` | 91 `[` | 123   `{` | 155 `` | 187 `»` | 219 `Û` | 251 `û` |
| 28 `FS`  | 60 `<` | 92 `\` | 124  `\|` | 156 `` | 188 `¼` | 220 `Ü` | 252 `ü` |
| 29 `GS`  | 61 `=` | 93 `]` | 125   `}` | 157 `` | 189 `½` | 221 `Ý` | 253 `ý` |
| 30 `RS`  | 62 `>` | 94 `^` | 126   `~` | 158 `` | 190 `¾` | 222 `Þ` | 254 `þ` |
| 31 `US`  | 63 `?` | 95 `_` | 127 `DEL` | 159 `` | 191 `¿` | 223 `ß` | 255 `ÿ` |




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
