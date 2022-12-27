
# Vim

## Modes
- **`ESC`**: Normal mode. For moving around a file; reading; going to file to file
- **`i`**: Insert mode. For inserting text
- **`:`**: Command-line mode. For running a command
- **`r`**: Replace mode. For replacing text
- **`v`**: Visual mode. For selecting blocks of text
- **`SHIFT` + `v`**: Visual line mode
- **`Ctrl` + `v`**: Visual block mode


## Command-line

Command mode can be entered by typing `:` in Normal mode. Your cursor will jump
to the command line at the bottom of the screen upon pressing `:`. This mode
has many functionalities, including opening, saving, and closing files, and
[quitting Vim](https://twitter.com/iamdevloper/status/435555976687923200).

- `:q` quit (close window)
- `:w` save ("write")
- `:wq` save and quit
- `:e {name of file}` open file for editing
- `:ls` show open buffers
- `:help {topic}` open help
    - `:help :w` opens help for the `:w` command
    - `:help w` opens help for the `w` movement


## NeoVIM

- NvimTreeToogle: left tree panel
- nvchad