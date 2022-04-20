# Pacman

```bash
pacman -S {pkg}    # Install package
pacman -Syu        # Update packages. Update database (-y) and upgrade packages (-u)
pacman -Ss {pkg}   # Search for a new package

pacman -Q          # Display all installed packages
pacman -Qe         # Display only packages explicitly installed
pacman -Qn         # Display only packages installed from main repositories
pacman -Qm         # Display only packages installed from AUR
pacman -Qdt        # Display orphaned dependencies
pacman -Qs {pkg}   # Search local repository for package

pacman -R {pkg}    # Remove package {pkg}
pacman -Rs {pkg}   # Remove package as well as unneeded dependencies (-s)
pacman -Rns {pkg}  # Remove package, dependencies (-s), and system config files (-n)
```




## [Arch User Repository (AUR)](https://aur.archlinux.org/packages)

|                                     | Manually           | `yay` (AUR Helper) | `pamac` (AUR Helper) |
|:-----------------------------------:|--------------------|--------------------|----------------------|
| Preparation<br>(install yay)        |                    | `sudo pacman -S --needed base-devel git`<br>`git clone https://aur.archlinux.org/yay.git`<br>`cd yay`<br>`makepkg -si` | Default in manjaro |
| Install<br>some package<br>(chrome) | `git clone https://aur.archlinux.org/google-chrome.git`<br>`cd google-chrome`<br>`makepkg -si` | `yay -S google-chrome` | `pamac install google-chrome` |
| Upgrade<br>some package<br>(chrome) | `cd google-chrome`<br>`git pull`<br>`makepkg -si` | `yay -Syu` | `pamac upgrade -a` |


### YAY

https://www.chrisatmachine.com/Linux/03-AUR-yay/