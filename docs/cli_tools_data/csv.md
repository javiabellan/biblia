# Text data


## `sort`
Sorting
- `sort -r`: Reverse order
- `sort -n`: Numerically
- `sort -rn`: Numerically reversed
- `sort -R`: Randomly (each time is different). Similar to **`shuf`**
- `sort --field-separator=',' --key=2,1,3 {file}`: Sort a CSV file by 2nd, 1st and 3rd columns.


## `uniq`
See **uniq**ues. **need to `sort` first**.
- `sort | uniq`: Display uniques
- `sort | uniq -c`: Count uniques
- `sort | uniq -d`: Display duplicates
- `sort | uniq -u`: Show non repeated lines

## `wc`
Count lines, words and chars
- `wc -l`: count only lines
- `wc -w`: count only words
- `wc -c`: count only chars/bytes (useful for getting size of stdin)


## `column`
Display in **column**s
- `| column -t`: Pretty print TSV file
- `column iris.csv -t -s ,`
- `column file.csv -s "," -t | less -#2 -N -S`: CSV viewer


## `cut`
Selecting fields (columns) (default is to delimit by tab).
- `cut -d',' -f1`: Delimiter="," Field (col)=1st
- `cut -d, -f 2`: Delimit by coma (CSV). Select 2nd field.
- `cut -d, -f 2,3`: Delimit by coma (CSV). Select 2nd and 3rd fields.
- `cut -d, -f-4,6-`: Delimit by coma (CSV). Select all except 5th field.
- `cut -c 5-`: skip the first 4 characters of each line (start on the 5th char).


## `paste`
Join 2 (or more) files line by line
- `pase file_a file_b`
- `pase <(cut -d, -f1,2,3 some.csv) other_file`


## `split`
Split a file into pieces (less useful)


## `nl`
Prepend line numbers


## `tr`
Translate (replace) patterns.
- `tr '\t' ,` Replace tabs with commas (TSV to CSV)
- `tr '[:upper:]' '[:lower:]'` **tr**anslate from upper to lower characters
- `tr -d " "` **D**elete some pattern
- `tr -s " "` **S**queeze multiple occurrences (convert a consecutive repeated character into a single one)


## `grep`
Print lines matching a pattern


## `egrep`
San handle extended regular expressions (EREs)


## `sed`

- **S**tream **ed**itor for filtering, transforming and replace text (and much more).
- Useful for search and replace.
- Convinient for free-form text data.



- `sed '' file` View content of file
- `sed 's/old_word/new_word/' file` Substituting Text
- `sed 's/old_word/new_word/i' file` Substituting Text (case insensitive)


## `awk`

- Pattern scanning and text processing language
- Convinient for tabular data (table with columns)
- Default input field separator is the blank/space: ` `
- Default output field separator is the blank/space: ` `
- Default record separator is the new_line: `\n`

Syntax:
```bash
awk FLAG_OPTIONS 'PATTERN {ACTION}
                  PATTERN {ACTION}
                  PATTERN {ACTION}' INPUT_FILE(S)
```

### AWK FLAG OPTIONS

- `awk -F "|" '........'`: Set `|` as the input field separator


### AWK VARIABLES

- `$1`: Field 1
- `$2`: Field 2
- `$3`: Field 3
- `$0`: The entire line
- `NR`: Number of the current record/line

### AWK PATTERNS

- Keywords
  - `awk 'BEGIN {...}'`: Do this before iterating the file
- Logical operators: 
  - `awk '$3 > 1000 || $4 < 300 {...}'`
  - `awk 'NR<3 {...}'`
  - `awk toupper($3 == "TEXAS")'`
  - `awk toupper($3 != "TEXAS")'`
- Regular expresions:
  - `awk '/D6.jpg/ {...}'`
  - `awk '! /D6.jpg/ {...}'`
  - `awk '$4 ~ /D6.jpg/ {...}'`: Field match a regex
  - `awk '$4 !~ /D6.jpg/ {...}'`: Field do not match a regex
  - `awk '/(TEXAS|Texas).*[Oo]il.*extraction/ {...}'`: Complex regex
- Regular expresions with logical operators:
  - `awk '( /TEXAS/ || /Texas/ ) && /*[Oo]il.*extraction/ {...}'`


### AWK ACTIONS

- `awk '{print $0}'`: Print the entire line.
- `awk '{print $1}'`: Print fisrt column.
- `awk '{print "First column " $1 " second column " $2}'`
- `awk 'BEGIN {FS="\t";OFS="\t"} ...`: Set the tab as the input and output separators
- `awk 'BEGIN {FS=OFS="\t"} ...`: Same of above


### AWK REFERENCE

- https://stackoverflow.com/tags/awk/info
- https://ferd.ca/awk-in-20-minutes.html
- https://www.youtube.com/watch?v=WaNIi0ZJMu0



## [Q](http://harelba.github.io/q)
SQL over CSVs
