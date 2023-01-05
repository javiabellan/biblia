# Directories


```bash
############## Programas
which echo  # En que path está el programa echo
man echo    # Muestra el manual de un programa
tldr echo   # Muestra el manual de ejemplos de un programa
lsb_release -a # Ver mi sistema operativo
```


## 🚶🏻‍♂️ Navigate

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
> - `lsd --tree` Better tree
> - `broot`
> - `nnn`
> - `ranger`



## 🔎 Search: `find`

- `find ..... 2>/dev/null` Do not show STDERR (denied acces)
- `find {where} -name {what} -type {what type}`
- `find /etc`

### Filter by type/name/path
- `find . -type f` Find only files
- `find . -type d` Find only directories
- `find . -name '*.tar.gz'`
- `find . -name src -type d` Find all directories named src
- `find . -path '*/test/*.py' -type f` Find all python files that have a folder named test in their path

### Filter by modification time
- `find . -mtime -1` Find all files modified in the last day

### Filter by permission
- `find -readable -writabe -executable`
- `find -readable -writabe ! -executable`

### Filter by size
- `find . -size 500c` Exact 500 bytes
- `find . -size +500k -size -10M` Find all zip files with size in range 500k to 10M

### Find, then do some action
- `find . -name '*.tmp' -exec rm {} \;` Delete all files with .tmp extension
- `find . -name '*.png' -exec convert {} {}.jpg \;` Find all PNG files and convert them to JPG

> - [`fd`](https://github.com/sharkdp/fd): a simple, fast, and user-friendly alternative to `find`.



## 🔎 indexed search: `updatedb` + `locate`

1. `$ sudo updatedb` compiles some sort of indexed database for quickly searching. Usually updated daily via `cron` or systemD timers.
2. `$ locate some_file` uses the database for quickly searching. (Actually is `plocate`)

With the existing systemD timer 
- `/lib/systemd/system/plocate-updatedb.service`
- `/lib/systemd/system/plocate-updatedb.timer`

```bash
sudo pacman -S locate # This installs plocate
sudo systemctl enable plocate-updatedb.timer
sudo systemctl start plocate-updatedb.timer
```


## 💽 Disk usage

- `du`: **d**isk **u**sage
  - `du FILE`: Disk usage of a file
  - `du -sh */ | sort -rh`
  - `du -sh -- * | sort -h -r` Disk usage of current dir
- `ncdu FILE`: Interactive version of Disk usage
- `dust`
- `duf`
- `df /`


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



## 📍 Special dirs

- `/dev` devices
  - `/dev/sd??` Hard drive
  - `/dev/tcp/127.0.0.1/30000` TCP connection on 127.0.0.1:3000
- `/proc` Procesos 
- `/sys` System hardware (brightness, leds, sensors,...)
  - `/sys/class/thermal/thermal_zone*/temp` CPU temperature
