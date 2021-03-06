# The Shell


```bash
############## Programas
which echo  # En que path está el programa echo
man echo    # Muestra el manual de un programa
tldr echo   # Muestra el manual de ejemplos de un programa
lsb_release -a # Ver mi sistema operativo

############## Sitios
/dev        # devices
/proc       # Porcesos 
/sys        # Los ficheros representan los propios devices del ordenador
  # se puede cambiar el brillo de la pantalla, los leds, etc
  cat /sys/class/thermal/thermal_zone*/temp # Ver temperatura CPU
```


## Your system is alive!

- `lsof`: lists open files (belonging to active processes).
	- `lsof -iTCP -sTCP:LISTEN` to list all processes that are listening on a TCP port for network requests.
- `inotify`: monitoring filesystem events
- `inotifywait`: wait for changes to files using inotify
- `iostat`: Report Central Processing Unit (CPU) statistics and input/output statistics for devices, partitions and network filesystems (NFS).
- `socat`:
	- `socat TCP-LISTEN:9000,fork,reuseaddr,bind=localhost TCP:$HOSTNAME:9000`: If the connection is refused by the server, will use socat to forward traffic from localhost:9000 to $HOSTNAME:9000 and back.


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


## 👁️ See files

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



## 📦 Compression


| Format | Compress    | Preview               | Decompress |
|-------------|-----------------------|--------------
|             | `7z l compressedFile` | `7z x compressedFile` | 
| `| base64`  |                       | `base64 -d`
| `zip file`  |             |
        | `tar -cvf compr.tar /dir/  `tar file`  |             | `tar -xf`   |             |
| `.gz` | `gunzip`    |             |
        | `bzip2`     |             |


| Format  | Extension       | Tool 
|---------|-----------------|
| ZIP     |                 |
| TAR     | `.tar.gz` o `.tgz` |
| GNU zip | `.gz` o `.gzip` |
| p7zip   | `.7z`           |
| BZIP2   | `.bz2`          | `bzip2 FILE(S)` | `bzip2 –d test.txt`

XZ
GZIP 
TAR
WIM

.tar.bz2 o .tbz2
.tar.xz o .xz o .txz
.gz o .gzip o .bzip2
.tar.lzma o .tlz:




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

fdupes: https://atareao.es/software/utilidades/eliminar-duplicados


> - https://unix.stackexchange.com/questions/28895/open-source-duplicate-image-finder-for-linux



## Type of files and magic numbers

The first bytes of a file determine the type of file

- `file *`: see the types of every file in the current directory

Magic numbers:

- `89 50 4e 47 0d 0a 1a 0a` magic number of PNG file



## Users and Privileges (when `ls -l`)

```
 ┌───────> Permission of owner
 │  ┌────> Permission of users of same group
 │  │  ┌─> Permission of other users 
 │  │  │
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



### 🔎 Search

- `find`: Search on many paths
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

#### 📅 See current date
- `date`
- `cal`


## 💽 Hard drives

1. See available drives
   - Option 1: `lsblk`
   - Option 2: `fdisk -l`
   - Option 3: `ls /dev/sd??`
2. Mount
   1. `sudo mkdir /hdd`
   2. `sudo mount -t auto /dev/sda1 /hdd`
3. Umount
   - `umount /hdd`




## 💽 Disk usage
- `du`: **d**isk **u**sage
  - `du FILE`: Disk usage of a file
  - `du -sh */ | sort -rh`
- `ncdu FILE`: Interactive version of Disk usage
- `dust`
- `duf`
- `df /`


## 🗑️ Deep remove files

- `scrub`: Real delete files in disk
- `shred`: Real delete files in disk

```bash
deep_rm () {
  scrub -p dod $1
  shred -zun 10 -v $1
}
```



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


