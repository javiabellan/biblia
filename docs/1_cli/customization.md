# 🎨 Customization (dotfiles)

- bash: `~/.bashrc`, `~/.bash_profile`
- zsh `~/.zshrc`
- git: `~/.gitconfig`
- vim: `~/.vimrc` and the `~/.vim folder`
- ssh: `~/.ssh/config`
- tmux: `~/.tmux.conf`
- nano: `~/.nanorc`



## ZSH `~/.zshrc`

Change to zsh: `sudo chsh -s /usr/bin/zsh javi`
curl -L http://install.ohmyz.sh | sh

### Change Bash to ZSH

```bash
$ sudo pacman -S zsh                # Install ZSH (and extras)
$ zsh                               # Make sure that ZSH has been installed correctly
$ chsh -l                           # List all installed shells
$ chsh -s /usr/bin/zsh              # WAY 1) Set new default shell (zsh) for your user
$ usermod --shell /usr/bin/zsh javi # WAY 2) Set new default shell (zsh) for a user (S4vitar lo hizo asi)
$ nano /etc/passwd                  # WAY 3) Set new default shell (zsh) for a user
$ echo $SHELL                       # Comprobar la nueva shell
```

> - https://wiki.archlinux.org/title/zsh#Installation
> - https://wiki.archlinux.org/title/Command-line_shell#Changing_your_default_shell
> - [3 Ways to Change a Users Default Shell](https://www.tecmint.com/change-a-users-default-shell-in-linux/)


### Better prompt -> `zsh-theme-powerlevel10k`

```bash
$ sudo pacman -S zsh-theme-powerlevel10k
$ echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
$ source ~/.zshrc
$ p10k configure
```
- https://github.com/ahillio/powerlevel10k/blob/master/README.md#arch-linux

### Colors on terminal outout

```bash
alias ls='ls --color=auto'
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ip='ip -color=auto'
```
Pacman has a color option. Uncomment the `Color` line in `/etc/pacman.conf`.

https://wiki.archlinux.org/title/Color_output_in_console

Other way is to install `grml-zsh-config`

### Colors on terminal commands -> `zsh-syntax-highlighting`

```bash
$ sudo pacman -S zsh-syntax-highlighting
$ echo 'source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> ~/.zshrc
```

### Sugerir comandos del pasado -> `zsh-autosuggestions`

```bash
$ sudo pacman -S zsh-autosuggestions
$ echo 'source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh' >> ~/.zshrc
```

### ZSH: Other plugins

- zsh-completions
- zsh-sudo   -> con esc esc  te pone sudo al principio (source /usr/share/zsh-sudo/sudo.plugin.zsh
)
- zsh-suggestions
- fzf -> con ctrl + T busca

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
alias tree='lsd --tree'

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
alias title="figlet"

# Git
function commit() {
    git add .
    msg=$@ # Every argument
    git commit -m "$msg"
    git push
}
```






## Nano: `~/.nanorc`

```bash
set autoindent  # Tthe newly created line will contain the same indent as the preceding line
set tabsize 4   # Use a tab size of number columns. The default value is 8.
set softwrap    # Enable soft line wrapping for easier viewing of very long lines
set nowrap      # Don’t hard-wrap text at all
# set nohelp    # Don’t display the two help lines at the bottom of the screen.
set linenumbers # Display of line numbers in front of the text.

include "/usr/share/nano/*.nanorc" # Default Syntax highlighting
include "/usr/share/nano-syntax-highlighting/*.nanorc" #  syntax highlighting enhancements*
```

> sudo pacman -S nano-syntax-highlighting


## TMUX `~/.tmux.conf`

```bash
####### SAME PROMT
set -g default-terminal "screen-256color"
if 'infocmp -x tmux-256color > /dev/null 2>&1' 'set -g default-terminal "tmux-256color"'

####### MOUSE (enable scroll)
set -g mouse on        # For tmux version 2.1 and above
set -g terminal-overrides 'xterm*:smcup@:rmcup@' # Sane scrolling (instead of mimic arrrow keys)

####### Number windows and panes start at 1 instead of 0
set -g base-index 1
set -g pane-base-index 1
```

- [Oh my tmux!](https://github.com/gpakosz/.tmux): Self-contained, pretty & versatile tmux configuration
- [Practical Tmux](https://mutelight.org/practical-tmux)




## VIM: `~/.vimrc`

```
" Comments in Vimscript start with a `"`.

" If you open this file in Vim, it'll be syntax highlighted for you.

" Vim is based on Vi. Setting `nocompatible` switches from the default
" Vi-compatibility mode and enables useful Vim functionality. This
" configuration option turns out not to be necessary for the file named
" '~/.vimrc', because Vim automatically enters nocompatible mode if that file
" is present. But we're including it here just in case this config file is
" loaded some other way (e.g. saved as `foo`, and then Vim started with
" `vim -u foo`).
set nocompatible


" Use a line cursor within insert mode and a block cursor everywhere else.
"
" Using iTerm2? Go-to preferences / profile / colors and disable the smart bar
" cursor color. Then pick a cursor and highlight color that matches your theme.
" That will ensure your cursor is always visible within insert mode.
"
" Reference chart of values:
"   Ps = 0  -> blinking block.
"   Ps = 1  -> blinking block (default).
"   Ps = 2  -> steady block.
"   Ps = 3  -> blinking underline.
"   Ps = 4  -> steady underline.
"   Ps = 5  -> blinking bar (xterm).
"   Ps = 6  -> steady bar (xterm).
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"


" Turn on syntax highlighting.
syntax on

" Disable the default Vim startup message.
set shortmess+=I

" Show line numbers.
set number

" This enables relative line numbering mode. With both number and
" relativenumber enabled, the current line shows the true line number, while
" all other lines (above and below) are numbered relative to the current line.
" This is useful because you can tell, at a glance, what count is needed to
" jump up or down to a particular line, by {count}k to go up or {count}j to go
" down.
set relativenumber

" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2

" The backspace key has slightly unintuitive behavior by default. For example,
" by default, you can't backspace before the insertion point set with 'i'.
" This configuration makes backspace behave more reasonably, in that you can
" backspace over anything.
set backspace=indent,eol,start

" By default, Vim doesn't let you hide a buffer (i.e. have a buffer that isn't
" shown in any window) that has unsaved changes. This is to prevent you from "
" forgetting about unsaved changes and then quitting e.g. via `:qa!`. We find
" hidden buffers helpful enough to disable this protection. See `:help hidden`
" for more information on this.
set hidden

" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase

" Enable searching as you type, rather than waiting till you press enter.
set incsearch

" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" Enable mouse support. You should avoid relying on this too much, but it can
" sometimes be convenient.
set mouse+=a

" Try to prevent bad habits like using the arrow keys for movement. This is
" not the only possible bad habit. For example, holding down the h/j/k/l keys
" for movement, rather than using more efficient movement commands, is also a
" bad habit. The former is enforceable through a .vimrc, while we don't know
" how to prevent the latter.
" Do this in normal mode...
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>
```


## NeoVIM: `~/.vimrc`


```bash
sudo pacman -S neovim
```



## iTerm2

### [Shell Integration](https://iterm2.com/documentation-shell-integration.html)


```bash
curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh
source ~/.iterm2_shell_integration.zsh # Add this line at ~/.zshrc 


# If hostname command not found install https://www.gnu.org/software/inetutils/
sudo pacman -S inetutils
```

Download files from remote hosts with a click.
You can right click on a filename (e.g., in the output of ls) to download it.

Drag-drop files to upload with scp.
Hold down option and drag-drop a file from Finder into iTerm2 to upload it.


### `imgcat`

```bash
wget https://iterm2.com/utilities/imgcat ; chmod 755 imgcat`
```

Ranger + imgcat




# Set NTP time

```bash
sudo pacman -S ntp
sudo timedatectl set-ntp true
```


# Comunity configs/dotfiles

- Savitar
  - https://www.youtube.com/watch?v=fshLf6u8B-w&t=3276s
  - https://s4vitar.github.io/bspwm-configuration-files/#
- Josean Martinez
  - Terminal https://www.youtube.com/watch?v=CF1tMjvHDRA

- https://github.com/rxyhn/dotfiles