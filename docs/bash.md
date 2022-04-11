








# Optimize OS

### linux kernel:
- Xanmod


### File systems

BTRFS
  - Recomendado por andres torrubia...
  - ...No por prestaciones, lo ha elegido por funcionalidad
  - Copias autoamáticas (equvalente a la Time Machine de apple)
  - Con [snapper](https://wiki.archlinux.org/title/snapper) que es un sofware que va por encima, tienes facilmente recuperable como estaba tu ordenador hace 1 hora, hace 1 dia, ... te salva la vida cuando borras datos por accidente
  - sucesor natural del sistema de archivos EXT4
  - menos velocidad de lectura y escritura que EXT4
ZFS
  - Recomendado por profe ASORC carrera informatica
  - Sistema por defecto de freeBSD
  - Puedes meter y quitar Discos ampliando o reduciendo el espacio (y el logical volume y ZFS se adapta)
  - ASi que va bien para tener hot-swapable disks
  - Es sinónimo de escalabilidad
  - Desventaja: consumo alto de memoria RAM
EXT4
  - Mas comun en linux.
  - Tambien es rapido (mas que btrfs)
XFS
  - Tambien es rapido

copy-on-write (COW) mechanism: when you modify a file, the file system won’t overwrite the existing data on the drive. Instead, the newer data is written elsewhere. Once the write operation is over, the file system simply points to the newer data blocks.
  - Ventaja: asegurar la integridad de los archivos en caso de corte eléctrico. 
  - Desventaja: una alta fragmentación, 

journaling (mejora la integridad del sistema de archivos), por lo que no deberías tener pérdida de datos en caso de corte de alimentación



          Asegurar integridad        How to               Scalable for
          en caso de corte corr      RAID?                hot-swap disks
------------------------------------------------------------------------
EXT4       journaling              need to format             no
BTRFS      copy-on-write
ZFS       copy-on-write                                    pool of vdevs



vdevs == Virtual DEVice. A pool is made up of vdevs. A vdev is made up of physical devices.
Let's say you have 12 physical disks. You might have a pool consisting of 6 mirrors. Each two disk mirror is a vdev. So your pool has 6 vdevs.


> ### Optimizacion trick 1: Desactivar el atributo atime
>  El atributo atime (access time) es recopilado y actualizado cada vez que el usuario lee o modifica un determinado archivo. En total, se recogen 3 atributos:
>
> - Access: la última vez que el archivo fue leído
> - Modify: la última vez que el archivo fue modificado (su contenido)
> - Change: la última vez que los meta-datos del archivo fueron modificados (permisos, nombre, propietario, etc)
>
> Mediante `noatime` desactivamos esta funcionalidad y ganamos algo de velocidad al leer y escribira archivos.

https://markmcb.com/2020/01/07/five-years-of-btrfs/
https://carfax.org.uk/btrfs-usage/
https://www.linuxjournal.com/content/hot-swappable-filesystems-smooth-btrfs
https://www.salvagedata.com/btrfs-zfs-xfs-ext4-how-are-they-different/


### I/O schedulers




> - https://wiki.archlinux.org/title/improving_performance
> - https://wiki.ubuntu.com/Kernel/Reference/IOSchedulers
> - https://community.clearlinux.org/t/arch-linux-outperforms-clear-linux/5462
> - https://clearlinux.org/




# Find duplicates

- **OPTION A)** Comparing filenames
  - `ls | sort | uniq -d`
- **OPTION B)** Comparing line by line (text files)
  - `diff`
- **OPTION C)** Comparing Byte by byte (binary files)
- **OPTION D)** Comparing Checksums, hashes, fingerprints
  - md5sum
  - sha1sum, 
  - Some filesytems already computes th checksums
    - ZFS: Performs automatic file integrity checking using checksums



> - https://unix.stackexchange.com/questions/28895/open-source-duplicate-image-finder-for-linux










# Parallel

https://www.baeldung.com/linux/processing-commands-in-parallel


cat photos.txt | sed 's/,/  /' > photosTAB.txt

####### Option 1 (sequential with for loop)
cat ../photosTAB.txt | while read id url; do wget -O "$id" "$url"; done

####### Option 2 (sequential with for loop)
wget --input-file=<(tail ../photosTAB.txt | cut -d "," -f 2)

####### Option 3 (parallel with xargs)
echo $URL_LIST | xargs -n 1 -P 8 wget -q

####### Option 4 (parallel with gnu parallel)
cat ../photosTAB.txt | parallel --jobs 100 --colsep '\t' wget -O {1} {2}




# Special variables

- `$0`: Name of the script
- `$1` to `$9`: Arguments to the script. `"$10"` and so on for the rest.
- `$@`: All the arguments
- `$#`: Number of arguments
- `$$`: Process identification number (PID) for the current script
- `$?`: Return code of the previous command
- `!!`: Entire last command, including arguments. A common pattern is to execute a command only for it to fail due to missing permissions; you can quickly re-execute the command with sudo by doing `sudo !!`
- `$_`: Last argument from the last command. If you are in an interactive shell, you can also quickly get this value by typing Esc followed by . or Alt+.



# Arrays


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



# Associative Arrays (Dictionaries)

- `fullNames=( ["lhunath"]="Maarten Billemont" ["greycat"]="Greg Wooledge" )`


# Control Operators (`&&` and `||`)

```bash
someCommand && echo "Previos comand worked (exit estatus==0)"
someCommand || echo "Previos comand failed (exit estatus!=0)"
```


```bash
[ a = a ]; echo $?  # 0 (True)
[ a = b ]; echo $?  # 1 (False)

true;      echo $?  # 0 (True)
false;     echo $?  # 1 (False)
```







# If

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




# Arrays


http://mywiki.wooledge.org/BashGuide/Arrays
http://mywiki.wooledge.org/BashFAQ/005



# Associative arrays (dictionaries)


http://mywiki.wooledge.org/BashGuide/Arrays#Associative_Arrays
http://mywiki.wooledge.org/BashFAQ/006




# Parameter expansion

http://mywiki.wooledge.org/BashGuide/Parameters#Parameter_Expansion

- Simple usage
  - $PARAMETER
  - ${PARAMETER}
- Indirection
  - ${!PARAMETER}
- Case modification
  - ${PARAMETER^}
  - ${PARAMETER^^}
  - ${PARAMETER,}
  - ${PARAMETER,,}
  - ${PARAMETER~}
  - ${PARAMETER~~}
- Variable name expansion
  - ${!PREFIX*}
  - ${!PREFIX@}

- Substring removal
  - ${PARAMETER#PATTERN}
  - ${PARAMETER##PATTERN}
  - ${PARAMETER%PATTERN}
  - ${PARAMETER%%PATTERN}
- Search and replace
  - ${PARAMETER/PATTERN/STRING}
  - ${PARAMETER//PATTERN/STRING}
  - ${PARAMETER/PATTERN}
  - ${PARAMETER//PATTERN}

- String or array length
  - ${#PARAMETER}
- Substring expansion
  - ${PARAMETER:OFFSET}
  - ${PARAMETER:OFFSET:LENGTH}


- Use a default value
  - ${PARAMETER:-WORD}
  - ${PARAMETER-WORD}
- Assign a default value
  - ${PARAMETER:=WORD}
  - ${PARAMETER=WORD}
- Use an alternate value
  - ${PARAMETER:+WORD}
  - ${PARAMETER+WORD}


- Display error if null or unset
  - ${PARAMETER:?WORD}
  - ${PARAMETER?WORD}



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



# [Regular expressions](http://mywiki.wooledge.org/RegularExpression)

$ rm /etc/some_file.conf || echo "I couldn't remove the file"



