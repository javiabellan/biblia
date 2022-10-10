# Install [Manjaro](https://manjaro.org/download)

Entra en la Bios (tecla ?) y detecta tu sistema
| Bios (or Legacy)        | UEFI                       |
|-------------------------|----------------------------|
| MRB (Master Boot Rcord) | GPT (GUID Partition Table) |
| Antiguo                 | Nuevo                      |

- [ ] Enable UEFI
- [ ] Disable Secure Boot
- [ ] Disable Fast Boot


1. Inserta USB de Manjaro con el PC apagado
2. Elije partición de arraque al encender (tecla F12)
   - Y elije arrancar desde USB en modo UEFI
3. Selecciona el **Driver**:
   - **free**: Si no tienes GPU
   - **nonfree**: Si tienes GPU Nvidia (o AMD)
4. Particiones

|                           | Size   | Type | File system | Mount point | Flags     |
|---------------------------|--------|------|-------------|-------------|-----------|
| Partición de arranque     | 100 MB | GPT  | fat32       | /boot/efi   | boot, esp |
| Partición SWAP (opcional) | 16 GB  | GPT  | linuxswap   |             | swap      |
| Partición para Manjaro    | Resto  | GPT  | ext4        | /           | root      |




## iso image to USB

1. `sudo fdisk -l` buscar localización del USB (sdb, sdc, etc.).
2. `sudo dd bs=4M if=/path/to/downloaded/iso of=/dev/sdx status=progress oflag=sync` Copiar (reemplazar sdx por la correcta ubicación).



```bash
# HARDWARE
# Processor     x86_64
# Min RAM:      512 MB RAM
# Min Space:    800 MB

# SOFTWARE
# User:         root
# Shell:        zsh
# Editors:      nano vi vim


################################################
########      ON WORKING COMPUTER       ########
################################################

# 1. Download iso

# 2. Identify USB pen
lsblk
fdisk -l

# 3. Copy iso to pendrive
dd if=Downloads/archlinux.iso of=/dev/sdb status="progress" # very careful with correct "of"
dd bs=4M if=/path/to/antergos-x86_64.iso of=/dev/sdX status=progress && sync

################################################
########        PRE-INTALLATION         ########
################################################

########################################## Keyboard and font

ls /usr/share/kbd/keymaps/**/*.map.gz  # OPTIONAL List available keyboards
loadkeys es                            # Set spanish keyboard

ls /usr/share/kbd/consolefonts/        # OPTIONAL See fonts
setfont                                # OPTIONAL Set font

########################################## Verify Boot mode

# TODO: UEFI vs BIOS
# Mejor usar BIOS

# UEFI activated if the directory exists.
ls /sys/firmware/efi/efivars

# If the directory does not exist, the system may be booted in BIOS

########################################## Connect to the Internet

# dhcpcd is activated. Check connection with ping
ping archlinux.org

########################################## Update the system clock

# Ensure the system clock is accurate
timedatectl set-ntp true

########################################## Partition

# 1) Identify disks
lsblk     # Option 1
fdisk -l  # Option 2

# 2) Particionate a disk (sda, sdb, ...)
# 4 needed partitions:
#   sda                  256G
#   ├─sda1    /boot/efi  200..512 = 256M
#   ├─sda2    [SWAP]     16..32   = 32G
#   ├─sda3    /          25..32   = 32G
#   └─sda4    /home      rest
#
#   sda                  256G
#   ├─sda1    /boot      200..512 = 256M
#   ├─sda2    [SWAP]     16..32   = 32G
#   ├─sda3    /          25..32   = 32G
#   └─sda4    /home      rest

fdisk /dev/sda  # Option 1
    m       # Help
    p       # Print status
    d       # Delete current partitons
    n       # Create new partition: Boot (200MB)
            #   type: default (primary)
            #   number: default (1)
            #   fisrt sector: default
            #   last sector: +200M
            #   Remove signature: Yes
            #   repeat for rest
    w       #   Write changes
    
parted /dev/sda # Option 2
    mklabel gpt
    mkpart ESP fat32 1MiB 513MiB
    set 1 boot on
    mkpart primary linux-swap 513MiB 4.5GiB
    mkpart primary ext4 4.5GiB 100%

# 3) Format partitions
mkfs.ext4 /dev/sda1  # Boot
mkswap /dev/sda2     # Swap
swapon /dev/sda2     # Swap
mkfs.ext4 /dev/sda3  # Root
mkfs.ext4 /dev/sda4  # Home

# 4) Mount
mount /dev/sda3 /mnt        # Mount root
mkdir /mnt/boot             # Mount boot
mount /dev/sda1 /mnt/boot   # Mount boot
mkdir /mnt/home             # Mount home
mount /dev/sda4 /mnt/home   # Mount home


################################################
########          INTALLATION           ########
################################################


########################################## Install base packages 
pacstrap /mnt base base-devel

########################################## Generate /est/fstab file
genfstab -U /mnt >> /mnt/etc/fstab

########################################## Bootable

# Enter the system
# Command line from pendrive to my system
arch-chroot /mnt

########################################## Time zone

ln -sf /usr/share/zoneinfo/Europe/Madrid /etc/localtime
hwclock --systohc

########################################## System language

# Set the system language
nano /etc/locale.gen
#   Uncomment en_US.UTF-8 UTF-8

locale-gen

nano /etc/locale.conf # (new file)
#   LANG=es_ES.UTF-8
#   LANG=en_US.UTF-8

########################################## Keyboard

nano /etc/vconsole.conf
#   KEYMAP=es

########################################## Hostname

nano /etc/hostname # (new file)
#   pc

nano /etc/hosts # (separate with tabs)
#   127.0.0.1    localhost.localdomain localhost
#   ::1          localhost.localdomain localhost
#   127.0.1.1    pc.localdomain         pc

########################################## Network config

pacman -S networkmanager # install
systemctl enable NetworkManager # Start on boot

########################################## Root pass

passwd

########################################## Boot loader

pacman -S grub intel-ucode


# OPTION A: Install grub (for BIOS)
grub-install /dev/sda

# OPTION B: Install grub (for UEFI)
grub-install --target=x86_64-efi --efi-directory=boot     --bootloader-id=GRUB
grub-install --target=x86_64-efi --efi-directory=boot/efi --bootloader-id=GRUB

# Config. (Microcode updates will be added automatically)
grub-mkconfig -o /boot/grub/grub.cfg

########################################## Reboot

exit
umount -R /mnt
reboot

# login: root
# enter password



################################################
########        POST-INTALLATION        ########
################################################
Read https://wiki.archlinux.org/index.php/General_recommendations


editar /etc/pacman.conf para activar el repositorio [community]

########################################## Add user

#useradd -m           -g    wheel -s      /bin/bash javi
useradd --create-home --gid wheel --shell /bin/bash javi
passwd javi

########################################## Trim support for SSD

# https://wiki.archlinux.org/index.php/Solid_State_Drive#TRIM

lsblk -D                            # Verify trim support
# disc-gran/disc-max should not be empty if enabled

# The util-linux package provides fstrim.service and fstrim.timer
# Enabling the timer will activate the service weekly
systemctl start fstrim.timer
systemctl enable fstrim.timer

########################################## Install LTS Kernel

# https://youtu.be/b-H3jURTgqk

uname -r                             # Check your current kernel
sudo pacman -S linux-lts             # Install LTS kernel
pacman -R linux                      # [OPTIONAL] Remove the standard kernel 
grub-mkconfig -o /boot/grub/grub.cfg # Reconfigure GRUB
sudo pacman -S linux-lts-headers     # Install LTS headers
sudo reboot                          # Reboot
uname -r                             # Check new current kernel

# Note, for syslinux you'll need to edit the syslinux config file in /boot/syslinux/syslinux.cfg accordingly,
# just point everything to the -lts kernel.

########################################## Install microcode (for Intel)

sudo pacman -S intel-ucode           # Install microcode
grub-mkconfig -o /boot/grub/grub.cfg # Reconfigure GRUB

########################################## Disable GRUB delay

# Add the following to /etc/default/grub:
# achieve the fastest possible boot:
GRUB_FORCE_HIDDEN_MENU="true"

# Then put file 31_hold_shift to /etc/grub.d/.
# Download 31_hold_shift https://goo.gl/nac6Kp

# Make it executable, and regenerate the grub configuration:
sudo chmod a+x /etc/grub.d/31_hold_shift
sudo grub-mkconfig -o /boot/grub/grub.cfg

########################################## Install key packages

sudo pacman -S adobe-source-sans-pro-fonts aspell-en enchant gst-libav gst-plugins-good \
hunspell-en icedtea-web jre8-openjdk languagetool libmythes mythes-en pkgstats \
ttf-anonymous-pro ttf-bitstream-vera ttf-dejavu ttf-droid ttf-gentium ttf-liberation ttf-ubuntu-font-family

########################################## Firewall

# iptables is already installed. I like ufw.

pacman -S ufw                # Install ufw
ufw enable                   # Enable it only once, when package is installed
ufw status verbose           # Check its status
systemctl start ufw          # Start the firewall
systemctl enable ufw         # Enable the start-up with the system [option a]
systemctl enable ufw.service # Enable the start-up with the system [option b]

########################################## Encrypt your home directory

########################################## Optimize pacman's database access speeds

sudo pacman-optimize

########################################## Check for errors

sudo systemctl --failed
sudo journalctl -p 3 -xb

########################################## Backup the system

sudo rsync -aAXvP --delete --exclude=/dev/* --exclude=/proc/* --exclude=/sys/* --exclude=/tmp/* --exclude=/run/* --exclude=/mnt/* --exclude=/media/* --exclude=/lost+found --exclude=/home/.ecryptfs / /mnt/backupDestination/



################################################
########      GRAPHICAL ENVIROMENT      ########
################################################

If you want to use the latest nvidia drivers in the official repository,
you can choose libglvnd (and not nvidia-304xx-utils).

########################################## Xorg

pacman -S xorg-server xorg-xinit
pacman -S xterm                      # Necessary??

# It will read from ~/.xinitrc to know what to start
nano ~/.xinitrc
      exec i3

# You can start X by running:
xinit
startx

ENTER
ENTER

########################################## Display manager (login screen)

# Terminal login screen:
# nano ~/.profile ~/.bash_profile
if [[ "$(tty)" == '/dev/tty1' ]]; then
exec startx
fi

# or use a Display manager (login screen)
pacman -S lightdb lightdm-gtk-greeter
systemctl enable lightdm.service

########################################## Colors

# Colors in terminal for bash, pacman and nano
# https://youtu.be/giAb4Ckh8BQ



# Install i3 window manager
pacman -S i3-gaps i3status rxvt-unicode dmenu

# Other things needed for a wm
nano ~/.xinitrc
# exec i3


# Fonts
pacman -S ttf-linux-libertine ttf-inconsolata
# Or just
pacman -S noto-fonts

# Manually edit
~/.config/fontconfig/fonts.conf





################################################
########       DEEP LEARNING SETUP      ########
################################################

# READ https://www.hackster.io/Ladvien/gpu-accelerated-deep-learning-environment-on-arch-linux-16631b

dialog --backtitle "Deep learning with Arch linux"\
       --title     "Welcome!"\
       --msgbox    "\nThis is the configuration to make your perfect linux distro."\
       8 40


dialog --backtitle "CPU Selection" \
       --radiolist "Select CPU type:" 10 40 4 \
        1 386SX off \
        2 386DX on \
        3 486SX off \
        4 486DX off

########################################## Nvidia drivers

# Identify your card
lspci    | grep -i nvidia
lspci    | grep -e VGA -e 3D
lspci -k | grep -A 2 -i "VGA"

# Install drivers and driver's utils
pacman -S nvidia                     # Nvidia drivers
pacman -S nvidia-utils               # Nvidia driver's utils
reboot

######################################## GPU computation

pacman -S cuda                       # Nvidia API for GPGPU
pacman -S cudnn                      # Nvidia primitives for Neural Networks
#Magma                               # Linear Algebra for OpenCL and CUDA and heteregenous many-core systems

######################################## Python

It is always preferred to use pacman to install software. 
If you must use pip, use a virtual environment or with "pip install --user" to avoid conflicting with packages in /usr.

pacman -S python                     # Install Python 3

pacman -S jupyter-notebook           # Jupyter:      Python notebooks
pacman -S python-numpy               # Numpy:        Matrix manipulation
pacman -S python-scipy               # Scipy:        Scientific library for Python. Sparse matrices support
pacman -S python-pandas              # Pandas:       Deal with data
pacman -S python-scikit-learn        # Scikit-learn: Machine learning
pacman -S python-matplotlib          # Matplotlib:   Visualization
pacman -S python-seaborn             # Seaborn:      Visualization
pacman -S python-nltk                # NLTK:         Natural language processing in Python

pacman -S python-pip                 # The PyPA recommended tool for installing Python packages

pacman -S gtkglext                   # opengl extensions for gtk2 (necesario para opencv)
pacman -S opencv opencv-samples      # Open Source Computer Vision Library
pacman -S graphviz                   # Graph visualization software
pacman -S hdf5                       # General purpose library and file format for storing scientific data

pip install --user bcolz
pip install --user graphviz          # Interface for python
pip install --user sklearn-pandas
pip install --user isoweek
 
AUR: python-numba

######################################## Deep larining frameworks

pacman -S python-pytorch-cuda        # Pytorch
pacman -S python-tensorflow-opt-cuda # Tensorflow
pacman -S tensorflow-opt-cuda        # Tensorflow
pacman -S tensorboard                # Tensorboard

AUR: python-torchvision
AUR: python-keras                    # Keras API for Tensorflow
AUR: python-theano
AUR: caffe
AUR: mxnet                           # MXNet: Apache DL
AUR: cntk                            # CNTK:  Microsoft DL

Nervana Neon, Chainer, DyNet, MinPy


######################################## Other packages

# Monitoring
htop       - Monitor CPU, RAM, load, kill programs
nvidia-smi - Monitor Nvidia GPU

CSV manipulation
xsv - The fastest, multi-processing CSV library. Written in Rust.


    
Rapid Development, Research
Jupyter - Code Python, R, Haskell, Julia with direct feedback in your browser
jupyter_contrib_nbextensions - Extensions for jupyter (commenting code, ...)
```