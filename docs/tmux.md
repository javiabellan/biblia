# TMUX

https://hackernoon.com/using-tmux-to-improve-your-terminal-experience-jt4932zv

The most popular terminal multiplexer these days is [`tmux`](https://www.man7.org/linux/man-pages/man1/tmux.1.html).
- tmux can have several **sessions**.
- a **session** can have several **windows** (like tabs)
- a **window** can have several **panes** (like a divided terminal)

Commands:

- **Outside tmux**
  - `tmux`: starts a new session.
  - `tmux new -s NAME`: starts it with that name.
  - `tmux ls`: lists the current sessions.
  - `tmux a`: attaches the last session.
  - `tmux -t sesName`: attaches to specific session.
- **Inside tmux**:
  - `[Ctrl+b] c`: Creates a new window. To close it you can just terminate the shells doing `<C-d>`
  - `[Ctrl+b] 0`: Go to window 0
  - `[Ctrl+b] 1`: Go to window 1
  - `[Ctrl+b] 2`: Go to window 2
  - `[Ctrl+b] p`: Go to the previous window
  - `[Ctrl+b] n`: Go to the next window
  - `[Ctrl+b] ,`: Rename the current window
  - `[Ctrl+b] w`: List current windows
  - `[Ctrl+b] d`: Detaches the current session (remains active in background)
  - `[Ctrl+d]`: Kill the current window (kill the sesion if is it the only window)
- **Panes**: Like vim splits, panes let you have multiple shells in the same visual display.
  - `[Ctrl+b] "` Split the current pane horizontally
  - `[Ctrl+b] %` Split the current pane vertically
  - `[Ctrl+b] <direction>` Move to the pane in the specified _direction_. Direction here means arrow keys.
  - `[Ctrl+b] z` Toggle zoom for the current pane
  - `[Ctrl+b] [` Start scrollback. You can then press `<space>` to start a selection and `<enter>` to copy that selection.
  - `[Ctrl+b] <space>` Cycle through pane arrangements.
