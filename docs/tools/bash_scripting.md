# Bash scripting



## Shells

| Terminal        | Promt | Hashbang/Shebang | Configuration file |
|-----------------|:------|------------------|--------------------|
| `sh`            |  `$`  | `#!/bin/sh`      |                    |
| `bash`          |  `$`  | `#!/bin/bash`    | `.bashrc`          |
| `zsh`           |  `$`  | `#!/bin/zsh`     |                    |
| `csh` or `tcsh` |  `%`  | `#!/bin/csh`     |                    |


[Shebang line](https://en.wikipedia.org/wiki/Shebang_(Unix): First line, This is going to be the interpreter:
- `#!/bin/sh`:  Bourne shell script
- `#!/bin/bash`:  Bash shell script `./myScript.sh`
- `#!/usr/bin/env bash`: Bash shell script
- `#!/usr/bin/python`:  Python script `./myScript.py`
- `#!/usr/bin/env python`:  Python script (more portable because looks for python comand)  `./myScript.py`



## ZSH

Change to zsh: `sudo chsh -s /usr/bin/zsh javi`
curl -L http://install.ohmyz.sh | sh

### Plugins

- powerlevel10k
- zsh-sudo   -> con esc esc  te pone sudo al principio
- zsh-syntax-highlining
- zsh-suggestions
- fzf -> con ctrl + T busca



## File descriptors (fd)

Every command (every porcess in fact) has its own file despcriptor table. By default (assuming your terminal is /dev/tty0):

| File descriptor | Meaning    | Initial value |
|-----------------|------------|---------------|
| 0               | **stdin**  | `/dev/tty0`   |
| 1               | **stdout** | `/dev/tty0`   |
| 2               | **stderr** | `/dev/tty0`   |



## Style output

Use ~~ncurses~~ scape charaacters !!!

### Colours

```bash
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"


# Example of usage
echo -e "\n\n${yellowColour}[*]${endColour}${grayColour} Exiting...\n${endColour}"
```



## IO Redirection

IO Redirection modifies the file descriptors table of a command.

### Redirect from/to file: `<` `>`

```bash
command <   file    # Redirect stdin to the command.    FD0 = file
command >   file    # Redirect stdout to file.          FD1 = file
command 1>  file    # Redirect stdout to file.          FD1 = file
command 2>  file    # Redirect stderr to file.          FD2 = file
command &>  file    # Redirect stdout & stderr to file  FD1 = FD2 = file
command >   /dev/null   # When we dont care about the output of a command
echo hello >  hello.txt # Crea (o sobrescribe) un fichero con la salida del programa anterior
```

### Redirect output of several comandas

```bash
{
   command1
   command2 
} > /some/file

{ command1;  command2;  } >/some/file

{ command1 & command2 & } >/some/file
```


### Inplace modify the same file: `sponge`

```bash
some_command_which_modifies /some/file | sponge /some/file

head /some/file | sponge /some/file
```


### Append to file: `>>`

```bash
command >>  file    # Redirect and append stdout to a file.
command 1>> file    # Redirect and append stdout to file
command 2>> file    # Redirect and append stderr to file
echo hello >> hello.txt # Añade (append) a un fichero la salida del programa anterior
```

### `<<`

- `<<` is known as here-document structure


### Read from variable: `<<<`

- `<<<` is known as here-string structure


## Pipelines

### Regular Pipes `|`

- Assign the stdout (FD1) of the first command to the pipe.
- Assign the stdin (FD0) of the second command to the pipe.


```bash
ls -l | tail -n2        # Pipe: Imprime solo los ultimos 2 ficheros
ls -l | tail -n2 >  hello.txt # Pipe and file writting
ls | xargs rm  # | xargs is when the inputs is IN THE ARGUMENTS
rm $(ls)       # same of above
```

### Named Pipes: `mkfifo`




## CRON

```
┌───────────── minute (0 - 59)
│ ┌───────────── hour (0 - 23)
│ │ ┌───────────── day of the month (1 - 31)
│ │ │ ┌───────────── month (1 - 12)
│ │ │ │ ┌───────────── day of the week (0=Sun - 6=Sat)
│ │ │ │ │                                   
* * * * *
```

| minute | hour  | day of the month | month | day of the week       |
|--------|-------|------------------|-------|-----------------------|
| 0..59  | 0..23 | 1..31            | 1..12 | 0..6 (Sun,Mon,..,Sat) |

- `*` means “every” 
- `,` value list separator
- `-` Range of values.
- `/` step values. Eg. `/5 * * * *` means every 5 minutes. 

### Examples:

- `* * * * *`: Every minute
- `*/5 * * * *`: Every 5 minutes
  - `*/5 8-16 * * 1-5`: Every 5 minutes from 8:00 to 16:00, from Mon to Fri.
- `0 * * * *`: Every hour (at minute 0)
- `0 0 * * *`: Every day (at 00:00)
- `0 0 * * 0`: Every week (at 00:00 on Sunday)
- `0 0 1 * *`: Mothly (at 00:00 on day 1)
- `0 0 1 1 *`: Yearly (at 00:00 on day 1 of January)

Check [crontab guru](https://crontab.guru) to come up with the cron syntax for your schedule.









## Example Bash script
```bash
############## Variables
myVar=someValue
echo $myVar
myVar = someValue      # No funciona con espacios
echo "Value is $myVar" # Imprime: Value is someValue
echo 'Value is $myVar' # Imprime: Value is $myVar


############## Functions
#!/bin/bash
mcd () {
    mkdir -p "$1"
    cd "$1"
}

# $0: The name of the script
# $1: The 1st argument
# $9: The 9th argument


########## command substitution
myDir=$(pwd) # The output of a command in a varaible
echo "we are in $(pwd)"
for file in $(ls)
```





## Variables

variables in funcions has **global scope** by defualt, (unless you define with `local`)


## Special variables

- `$0`: Name of the script
- `$1` to `$9`: Arguments to the script. `"$10"` and so on for the rest.
- `$@`: All the arguments
- `$#`: Number of arguments
- `$$`: Process identification number (PID) for the current script
- `$?`: Return code of the previous command
- `!!`: Entire last command, including arguments. A common pattern is to execute a command only for it to fail due to missing permissions; you can quickly re-execute the command with sudo by doing `sudo !!`
- `$_`: Last argument from the last command. If you are in an interactive shell, you can also quickly get this value by typing Esc followed by . or Alt+.



## Arrays

An array is a numbered list of strings: It maps integers to strings.

- Creating Arrays
  - `names=("Bob" "Peter" "$USER" "Big Bad John")` Simple way
  - `names=([0]="Bob" [1]="Peter" [20]="$USER" [21]="Big Bad John")` Explicit indexes (sparse array)
  - `names[0]="Bob"`
  - `files=(~/*.jpg)` Result of a glob
  - `photos=(~/"My Photos"/*.jpg)` Result of a glob
  - `files=$(ls)`  BAD, BAD, BAD!
  - `files=($(ls))` STILL BAD!
  - `files=(*)` GOOD: filenames in the current directory

> - http://mywiki.wooledge.org/BashGuide/Arrays
> - http://mywiki.wooledge.org/BashFAQ/005


## Associative Arrays (Dictionaries)

- `fullNames=( ["lhunath"]="Maarten Billemont" ["greycat"]="Greg Wooledge" )`

> - http://mywiki.wooledge.org/BashGuide/Arrays#Associative_Arrays
> - http://mywiki.wooledge.org/BashFAQ/006


## Control Operators (`&&` and `||`)

```bash
someCommand && echo "Previos comand worked (exit estatus==0)"
someCommand || echo "Previos comand failed (exit estatus!=0)"
```



```bash
rm /etc/some_file.conf || echo "I couldn't remove the file"
```



```bash
[ a = a ]; echo $?  # 0 (True)
[ a = b ]; echo $?  # 1 (False)

true;      echo $?  # 0 (True)
false;     echo $?  # 1 (False)
```







## If

```bash
if [[ $filename = *.jpg ]]; then
	echo "$filename is a jpeg"
fi
```

# 6. Choices (case and select)

Each choice in a case statement consists of a pattern (or a list of patterns)

```bash
case $LANG in
    en*) echo 'Hello!' ;;
    fr*) echo 'Salut!' ;;
    de*) echo 'Guten Tag!' ;;
    nl*) echo 'Hallo!' ;;
    it*) echo 'Ciao!' ;;
    es*) echo 'Hola!' ;;
    C|POSIX) echo 'hello world' ;;
    *)   echo 'I do not speak your language.' ;;
esac
```


# Loops

There are 4 different loops expressions:

1. `for` *variable* `in` *words*: Repeat the loop for each word, setting variable to each word in turn.
   - `for i in 1 2 3 4`
   - `for i in {1..4}`
   - `for file in *.mp3`
   - `for file in *.jpg *.jpeg`
2. `for ((` *expr*`;` *expr*`;` *expr* `))`: C style for loop
   - `for (( i=1; i < 5; i++ ))`
3. `while` *command*: Repeat so long as command is executed successfully (exit code is 0).
   - `while (( i < 5 ))`
   - `while true`: Infinite loop
   - `while sleep 300` Infinite loop every 5 minutes
   - `while read -p "Input something:" input_variable` Wait for user input
4. `until` *command*: Repeat so long as command is executed unsuccessfully (exit code is not 0).
   - Not very used because is the same as `while ! command`

```bash
loop_expresion
do
	commads
done
```



# While loop

```bash
while /bin/true
do
  # Code goes here
done

while true; do
  # Code goes here
done
```

# Functions

Functions can only return an integer in range of 0 - 255.



# Parameter expansion

http://mywiki.wooledge.org/BashGuide/Parameters#Parameter_Expansion

- Simple usage
  - $VARIABLE
  - ${VARIABLE}
- Indirection
  - ${!VARIABLE}
- Case modification
  - ${VARIABLE^}
  - ${VARIABLE^^}
  - ${VARIABLE,}
  - ${VARIABLE,,}
  - ${VARIABLE~}
  - ${VARIABLE~~}
- Variable name expansion
  - ${!PREFIX*}
  - ${!PREFIX@}

- Substring removal
  - ${VARIABLE#PATTERN}
  - ${VARIABLE##PATTERN}
  - ${VARIABLE%PATTERN}
  - ${VARIABLE%%PATTERN}
- Search and replace
  - ${VARIABLE/PATTERN/STRING}
  - ${VARIABLE//PATTERN/STRING}
    - `for file in *; do; mv "$file ${file// /_}"; done;`: Replace spaces with underscores
  - ${VARIABLE/PATTERN}
  - ${VARIABLE//PATTERN}

- String or array length
  - ${#VARIABLE}
- Substring expansion
  - ${VARIABLE:OFFSET}
  - ${VARIABLE:OFFSET:LENGTH}


- Use a default value
  - ${VARIABLE:-WORD}
  - ${VARIABLE-WORD}
- Assign a default value
  - ${VARIABLE:=WORD}
  - ${VARIABLE=WORD}
- Use an alternate value
  - ${VARIABLE:+WORD}
  - ${VARIABLE+WORD}


- Display error if null or unset
  - ${VARIABLE:?WORD}
  - ${VARIABLE?WORD}



```bash
file="$HOME/.secrets/007"

echo "File location: $file"    # /home/lhunath/.secrets/007
echo "Filename: ${file##*/}"   # 007
echo "Directory: ${file%/*}"   # /home/lhunath/.secrets
echo
echo "Non-secret file: ${file/secrets/not_secret}" # /home/lhunath/.not_secret/007
echo
echo "Other file location: ${other:-There is no other file}" # There is no other file
echo "Using file if there is no other file: ${other:=$file}" # /home/lhunath/.secrets/007
echo "Other filename: ${other##*/}"                          # 007
echo "Other file location length: ${#other}"                 # 26


# Note: You cannot use multiple Param Exps together
file=$HOME/image.jpg
file=${file##*/}
echo "${file%.*}" # image


version=1.5.9
echo "MAJOR: ${version%%.*}" # MAJOR: 1
echo "MINOR: ${version#*.}." # MINOR: 5.9.
echo "Dash: ${version/./-}"     # Dash: 1-5.9
echo "Dashes: ${version//./-}." # Dashes: 1-5-9.


parameter     result
-----------   ------------------------------
$name         polish.ostrich.racing.champion
${name#*.}           ostrich.racing.champion
${name##*.}                         champion
${name%%.*}   polish
${name%.*}    polish.ostrich.racing


```


# [Brace expansions](http://mywiki.wooledge.org/BraceExpansion)

Brace expansions can only be used to **generate lists** of words.

You can not use with variables because brace expansion happens before parameter expansion.
`for i in {1..$n}` Won't work!

- `{a,b,c}`: a b c
- `{foo,bar}`: foo bar
- `{1..15}`: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
- `{9..1}`: 9 8 7 6 5 4 3 2 1
- `{A..g}`: A B C D E F G H I J K L M N O P Q R S T U V W X Y Z [ \ ] ^ _ ´ a b c d e f g
- `{e..a}`: e d c b a
- `{a..c} {x..z}`: a b c x y z
- `{1..3} {a..c}` 1 2 3 a b c
- `{1..3}{a..c}`: 1a 1b 1c 2a 2b 2c 3a 3b 3c
- `{0,1}{0..9}`: 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19

> - https://www.gnu.org/software/bash/manual/html_node/Brace-Expansion.html
> - [Pattern Matching](https://www.gnu.org/software/bash/manual/html_node/Pattern-Matching.html)



# [Globs](http://mywiki.wooledge.org/glob) (filename expansion)

You can use it with `ls`, `mkdir`, `echo`, `for i in {}`

- Globs
  - `*`: Matches any string, including the null string. But no the `/` chararcater
    - `*/bin` might match `foo/bin` but it cannot match `/usr/local/bin`. 
  - `?`: Matches any single character. But no the `/` chararcater
  - `[...]`: Matches any one of the enclosed characters.
- Extended Globs (off by default, activate with `shopt -s extglob`)
  - `?(pattern-list)`: Matches zero or one occurrence of the given patterns.
  - `*(pattern-list)`: Matches zero or more occurrences of the given patterns.
  - `+(pattern-list)`: Matches one or more occurrences of the given patterns.
  - `@(pattern-list)`: Matches one of the given patterns.
  - `!(pattern-list)`: Matches anything except one of the given patterns.
    - `!(*jpg|*bmp)`: anything that does not match the `*jpg` or the `*bmp` pattern

> ### Globs with brace expansion
>
> Because Brace expansion happens **before** Filename expansion, `ls *{.jpg,.png}` will become `ls *.jpg *.png` and then execute the comand.



