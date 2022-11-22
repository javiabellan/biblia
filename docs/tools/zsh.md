# ZSH

Change to zsh: `sudo chsh -s /usr/bin/zsh javi`
curl -L http://install.ohmyz.sh | sh

## Change Bash to ZSH

```bash
$ sudo pacman -S zsh                    # Install ZSH (and extras)
$ zsh                                   # Make sure that ZSH has been installed correctly
$ chsh -l                               # List all installed shells
$ chsh -s /usr/bin/zsh                  # WAY 1) Set new default shell (zsh) for your user
$ usermod --shell /usr/bin/zsh username # WAY 2) Set new default shell (zsh) for a user
$ nano /etc/passwd                      # WAY 3) Set new default shell (zsh) for a user
$ echo $SHELL                           # Comprobar la nueva shell
```

> - https://wiki.archlinux.org/title/zsh#Installation
> - https://wiki.archlinux.org/title/Command-line_shell#Changing_your_default_shell
> - [3 Ways to Change a Users Default Shell](https://www.tecmint.com/change-a-users-default-shell-in-linux/)

## ZSH: Better prompt -> Powerlevel10k

```bash
$ sudo pacman -S zsh-theme-powerlevel10k
$ echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
$ p10k configure
```

> - https://github.com/ahillio/powerlevel10k/blob/master/README.md#arch-linux

## ZSH: Other plugins

- zsh-completions
- grml-zsh-config
- zsh-sudo   -> con esc esc  te pone sudo al principio
- zsh-syntax-highlining
- zsh-suggestions
- zsh-autosuggestions
- fzf -> con ctrl + T busca
