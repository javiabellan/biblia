# The Shell


```bash
############## Programas
which echo  # En que path está el programa echo
man echo    # Muestra el manual de un programa
tldr echo   # Muestra el manual de ejemplos de un programa
lsb_release -a # Ver mi sistema operativo

############## Sitios
/sys        # Los ficheros representan los propios devices del ordenador
  # se puede cambiar el brillo de la pantalla, los leds, etc
  cat /sys/class/thermal/thermal_zone*/temp # Ver temperatura CPU
```



## Print: `echo`, `printf`

- `echo`
  - `echo Value is $myvarible`: Print some variable badly
  - `echo 'Value is $myvarible'`: Print some variable correctly (with newlines)
  - `echo "Value is $myvarible"`: Print some variable correctly (with newlines)
  - `echo $PATH`: Sitios donde la shell busca programas
  - `echo -n "no new line"`: do not output the newline
  - `echo -e "[33m ERROR"`: interpret backslash escapes (useful for displaying colors)
enable interpretation of backslash escapes
- `printf`
  - `printf "dfadf"` Sitios donde la shell busca programas


## Navigate
- `pwd`: **p**rint **w**orking **d**irectory
- `cd` **c**hange **d**irectory
  - `cd`: go to home
  - `cd ~`: go to home
  - `cd /`: go to root
  - `cd -`: go to previous dir
- `ls`: **l**i**s**t directories
  - `ls -a`: show hidden too
  - `ls -l`: show long (more info: permissions, size, date)
  - `ls -lh: Human readable size
  - `ls -S: Sort files by size 
  - `ls *.png`: only png files
  - `ls *.??g`: only png and jpg files

> - `lsd`: Better ls
> - `tree`
> - `broot`
> - `nnn`
> - `ranger`


## See files

- **`cat`**: con**cat**enate and print files.
- **`less`**: Interactive file viwer. Load the file dynamically (faster)
  - `less -N` Add line number
- **`more`**:
- **`head`**: shows the beginning of a file (defaults to first 10 lines).
   - `head -n5`: only 5 lines
- **`tail`**: shows the ending of a file (defaults to last 10 lines).
   - `tail -n5`: only 5 lines
- **`hexdump`**: Para ver ficheros binarios
- **`xxd`**: make a hexdump or do the reverse.
- `hexeditor`:
- `xdg-open  myFile.txt`: Open a file with default program


> - `bat`: Better cat
> - `mdcat`: cat for markdown


## Rename, Move and copy files

- `mv OLD NEW`: Move or rename files or directories
  - `for file in *; do; mv "$file ${file// /_}"; done;`: Replace spaces with underscores
- `cp FROM TO`: Copy a file
- `rm PATH`: Remove a file
  - `rm -r PATH`: Remove a directory recusively
  - `rmdir PATH`: Remove an empty directory
- `touch NEW_FILE`: Create a file
- `mkdir PATH`: Make a directory
  - `mkdir My\ photos`: Make a directory with spaces
  - `mkdir "My photos"`: Make a directory with spaces
- `ln FROM TO`: Create link (acceso directo)
  - `ln src_file dest_file`: Hard link
  - `ln -s src_file dest_file`: Symbolic link
  - `ln -s -f src_file dest_file`: Symbolyc link


## Compare files and Find duplicates

- **OPTION A)** Comparing filenames
  - `ls | sort | uniq -d`
- **OPTION B)** Comparing line by line (text files)
  - `diff {file1} {file2}`: See differencs between files
  - `sdiff {file1} {file2}`: side-by-side merge of file differences
  - `cmp {file1} {file2}`: See differencs between files
  - `comm`: select or reject lines **comm**on to two files
- **OPTION C)** Comparing Byte by byte (binary files)
- **OPTION D)** Comparing Checksums, hashes, fingerprints
  - md5sum
  - sha1sum, 
  - Some filesytems already computes th checksums
    - ZFS: Performs automatic file integrity checking using checksums

> - https://unix.stackexchange.com/questions/28895/open-source-duplicate-image-finder-for-linux



## Type of files and magic numbers

The first bytes of a file determine the type of file

- `file *`: see the types of every file in the current directory

Magic numbers:

- `89 50 4e 47 0d 0a 1a 0a` magic number of PNG file



## Users and Privileges (when `ls -l`)

```
 -------> Permission of owner
 |  ----> Permission of users of same group
 |  |  -> Permission of other users 
 |  |  |
/ \/ \/ \
rwxrwxrwx  ownerUser userGroup 13B file
```

- Manage users
  - `whoami`: See the current user i am
  - `su otherUser`: Change to other user
  - `exit: Change to prevous user
- Manage files
  - `chmod +x file`: Add execution permission to the owner
  - `chmod o-r file`: Remove read permission to other users.
  - `chmod o+rw file`: Add read and write permission to other users.
  - `chmod g+w file`: Add write permission to group users.
  - `chmod g+r,o-w file`: Modifiy several users permission at the same time
  - `chmod 640 file`:  Modifiy several users permission at the same time
  - `chgrp userGroup file`: Change the user group
  - `lsattr file` List special atributers of file
  - `chattr +i file` Change special atributes of file (add i atribute)
  - `chattr -i file` Change special atributes of file (remove i atribute)



### Search

- `find`: search on many paths
  - `find /etc`
  - `find {where} -name {what} -type {what type}`
  - `find . -name src -type d` Find all directories named src
  - `find . -path '*/test/*.py' -type f` Find all python files that have a folder named test in their path
  - `find . -mtime -1` Find all files modified in the last day
  - `find . -size +500k -size -10M -name '*.tar.gz'` Find all zip files with size in range 500k to 10M
  - `find . -name '*.tmp' -exec rm {} \;` Delete all files with .tmp extension
  - `find . -name '*.png' -exec convert {} {}.jpg \;` Find all PNG files and convert them to JPG
- [`fd`](https://github.com/sharkdp/fd): a simple, fast, and user-friendly alternative to `find`.
- `updatedb` and `locate`: indexed search.
  - `updatedb` compiles some sort of indexed database for quickly searching. Usually updated daily via `cron`
  - `locate` uses the database for quickly searching.

#### See current date
- `date`
- `cal`


## Hard drives

1. See available drives
   - Option 1: `lsblk`
   - Option 2: `fdisk -l`
   - Option 3: `ls /dev/sd??`
2. Mount
   1. `sudo mkdir /hdd`
   2. `sudo mount -t auto /dev/sda1 /hdd`
3. Umount
   - `umount /hdd`




## Disk usage
- `du`: **d**isk **u**sage
  - `du FILE`: Disk usage of a file
  - `du -sh */ | sort -rh`
- `ncdu FILE`: Interactive version of Disk usage
- `dust`
- `duf`
- `df /`








## Deep remove files

- `scrub`: Real delete files in disk
- `shred`: Real delete files in disk

```bash
deep_rm () {
  scrub -p dod $1
  shred -zun 10 -v $1
}
```

## See content

- **`sort`**: Sorting
  - `sort -r`: Reverse order
  - `sort -n`: Numerically
  - `sort -rn`: Numerically reversed
  - `sort --field-separator=',' --key=2,1,3 {file}`: Sort a CSV file by 2nd, 1st and 3rd columns.
  - `sort -R`: Randomly (each time is different). Similar to **`shuf`**
- **`uniq`** See **uniq**ues. **need to `sort` first**.
  - `uniq -c`: Count uniques
- **`wc`:** count lines, words and chars
  - `wc -l`: count only lines
  - `wc -w`: count only words
  - `wc -c`: count only chars
- **`column`**: Display in **column**s
  - `| column -t`: Pretty print TSV file
  - `column iris.csv -t -s ,`
  - `column file.csv -s "," -t | less -#2 -N -S`: CSV viewer
- **`cut`**: Selecting fields (columns) (default is to delimit by tab).
  - `cut -d',' -f1`: Delimiter="," Field (col)=1st
  - `cut -d, -f 2`: Delimit by coma (CSV). Select 2nd field.
  - `cut -d, -f 2,3`: Delimit by coma (CSV). Select 2nd and 3rd fields.
  - `cut -d, -f-4,6-`: Delimit by coma (CSV). Select all except 5th field.
  - `cut -c 5-`: skip the first 4 characters of each line (start on the 5th char).
- **`paste`**: join 2 (or more) files line by line
- **`split`**: split a file into pieces (less useful)
- **`nl`**: prepend line numbers
- **`tr`** Translate (replace) patterns.
  - `tr '\t' ,` Replace tabs with commas (TSV to CSV)
  - `tr '[:upper:]' '[:lower:]'` **tr**anslate from upper to lower characters
  - `tr -d " "` **D**elete some pattern
  - `tr -s " "` **S**queeze multiple occurrences (convert a consecutive repeated character into a single one)
- **`grep`**: print lines matching a pattern
- **`egrep`**: can handle extended regular expressions (EREs)
- **`sed`**: stream editor for filtering and transforming text. replace (and much more). useful for search and replace - one liners
- **`awk`**: pattern scanning and text processing language, useful for tab-delimited data - one liners (default is to delimit by spaces)
  - `awk '{print "First column " $1 " second column " $2}'`
  - `awk -F "|" '{print $1}'` Use awk as the `cut` command to get a specific column by saying the separator
  - https://stackoverflow.com/tags/awk/info
  - https://ferd.ca/awk-in-20-minutes.html




# Alias

```bash
# ZSH pluggins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme


# General
alias l='lsd'
alias ls='lsd'
alias ll='lsd -l'
alias la='lsd -a'
alias lla='lsd -la'
alias lt='lsd --tree'

# Disk usage of current dir
alias du='du -sh -- * | sort -h -r'


# Jupyter notebook
alias jn="jupyter notebook"

# Pacman
alias i="sudo pacman -S"        # install a package
alias s="pacman -Ss"            # search for a package
alias u="sudo pacman -Syu"      # update the packages
alias r="sudo pacman -Rns"      # remove a package

alias install="sudo pacman -S"  # install a package
alias search="pacman -Ss"       # search for a package
alias update="sudo pacman -Syu" # update the packages
alias remove="sudo pacman -Rns" # remove a package

# Others
alias title="figlet" # r: remove a package

# Git
function commit() {
    git add .
    msg=$@ # Every argument
    git commit -m "$msg"
    git push
}

# Data wraling
alias uniq="sort | uniq" # uniq reqires previous sorting
alias lc="wc --lines" # lines count
alias wc="wc --words" # words count
alias cc="wc --chars" # chars count
```



---

# Set NTP time

```bash
sudo pacman -S ntp
sudo timedatectl set-ntp true
```

# HDBaseT
Protocolo para dejar el ordenador lejos (hasta 100 metros de distancia) y conetar todo (video, USB) por un cable Ethernet (categoría 5E para distancias cortas o categoria 6 o 7 para distancias largas).



# Generate data
- `touch` Create a new file or changes the Last Modified time of an existing file.
- echo "bla bla bla" > file.txt
- seq
  - seq 10
  - seq 3 9
- primes 1 100

# Plotting

- `gnuplot`
  - `gnuplot -e "set terminal jpeg; plot [-5:5] sin(x)" | display`
  - `gnuplot -e "set terminal jpeg; plot [-5:5] sin(x)" > sin.jpg`
  - `primes 1 100 | gnuplot -p -e 'plot "/dev/stdin"'`
- `feedgnuplot`
  - https://github.com/dkogan/feedgnuplot/blob/master/guide/guide.org 


