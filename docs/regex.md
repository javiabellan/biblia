# Regular Expressions

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


> #### Reference
> - `man re_format`
> - https://remram44.github.io/regex-cheatsheet/regex.html
> - https://linuxize.com/post/regular-expressions-in-grep/
> - **`grep`**: print lines matching a pattern
> - **`egrep`**: can handle extended regular expressions (EREs)