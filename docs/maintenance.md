# [System maintenance](https://wiki.archlinux.org/index.php/System_maintenance)

## Check for errors
```
sudo systemctl --failed        # Check if any systemd services have entered in a failed state.
sudo journalctl -p 3 -xb       # Look for errors in the log files located at /var/log
```

## Backup
...

## Upgrading the system
1. [Check news](https://www.archlinux.org/)

```
pacman -Syu                     #  Update packages and system
```
If the system has packages from the AUR, carefully upgrade all of them.

##  [Clean the filesystem](https://wiki.archlinux.org/index.php/System_maintenance#Clean_the_filesystem)


### [Disk usage display](https://wiki.archlinux.org/index.php/List_of_applications#Disk_usage_display)

Find largest files and directories.

```
sudo pacman -S ncdu              # Intall ncdu
```
Filelight is a GUI program
Baobab is other GUI program (gnome)


### [Disk cleaning programs](https://wiki.archlinux.org/index.php/List_of_applications#Disk_cleaning)

Find and remove:

* duplicates
* empty files
* empty directories
* broken symlinks.

```
sudo pacman -S rmlint            # Intall rmlint
```

BleachBit is a GUI program


### [Package cache](https://wiki.archlinux.org/index.php/Pacman#Cleaning_the_package_cache)

Remove unwanted `.pkg` files from `/var/cache/pacman/pkg/` to free up disk space. 

```
ls /var/cache/pacman/pkg/ | less # Ver paquetes (diponibles?)
du -sh /var/cache/pacman/pkg/    # Ver tamaño carpeta
sudo pacman -Sc                  # Remove old and unused pkgs
sudo pacman -Scc                 # Remove files from cache
paccache                         # ???
```

### [Unused packges (orphans)](https://wiki.archlinux.org/index.php/Pacman/Tips_and_tricks#Removing_unused_packages_.28orphans.29)
```
sudo pacman -Qtdq                # List orphans
sudo pacman -Rns $(pacman -Qtdq) # Remove orphans and their configuration files
```

### Clean cache in your /home.
```
du -sh ~/.cache/                 # Ver tamaño carpeta
rm -rf ~/.cache/*                # Remove 
```

### Old config files
* `~/.config/`: where apps stores their configuration
* `~/.cache/`: cache of some programs may grow in size
* `~/.local/share/`: old files may be lying there

### Broken symlinks
```
find -xtype l -print             # List all the broken symlinks
```
