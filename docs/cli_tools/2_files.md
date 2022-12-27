# Files



## Types of files

- file
- directory
- executable
- symbolic link
- socket
- FIFO
- whiteout (not in Linux, only in UNIX) Linux. it's a type of file that stops further lookup for a file but reports that it doesn't exist.





## 👁️ See files

### See `head` or `tail` of file

- **`head`**: shows the beginning of a file (defaults to first 10 lines).
   - `head -n5`: only 5 lines
- **`tail`**: shows the ending of a file (defaults to last 10 lines).
   - `tail -n5`: only 5 lines


### See entire content of text file

- **`cat`**: con**cat**enate and print files.
- **`less`**: Interactive file viwer. Load the file dynamically (faster)
  - `less -N` Add line number
- **`more`**:

> - `bat`: Better cat
> - `mdcat`: cat for markdown

### See entire content of binary files

- **`hexdump`**: Para ver ficheros binarios
- **`xxd`**: make a hexdump or do the reverse.
- `hexeditor`:
- `strings my_file`: See parts of text data in a binary file 


### See info `file` `stat`

- file my_file
- stat my_file





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


> ## 🗑️ Deep remove files
> 
> - `scrub`: Real delete files in disk
> - `shred`: Real delete files in disk
> 
> ```bash
> deep_rm () {
>   scrub -p dod $1
>   shred -zun 10 -v $1
> }
> ```


## Compare files and Find duplicates


cmp
diff

comm 
comm -12 <(sort words.txt | uniq) <(sort countries.txt | uniq)
comm -23 <(ls march) <(ls april)




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













---




