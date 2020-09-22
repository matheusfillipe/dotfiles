# My-Terminal-Setup
My personal optimal tmux, zsh and vim configurations. 

## Installation 

Don't do this!

```
cd ~; git clone https://github.com/matheusfillipe/My-Terminal-Setup.git dotfiles --depth 1; cp -rf dotfiles/* ~/; cp -rf dotfiles/.* ~/; rm -rf dotfiles/; rm -rf .git
```

![alt text](https://github.com/matheusfillipe/My-Terminal-Setup/blob/master/screenshot.png?raw=true)

* **ZSH**: Stuff like ctrl+F to start a file search in the current path using refind, ctrl+O to lfcd, intuitive vim mode, oh-my-zsh and many other keybindings and plugins and theme.

    Esc enters vi mode, the clipboard is synced with the system's. 


* **VIM**: Line number display, dark theme, clipboard synced with Xorg...
* **TMUX**: Clipboard synced with Xorg that works from remote ssh sessions, full mouse integration, basic plugins like tmux-ressurect, continuumm, vim copy mode.

    Vi like pane switching and resizing with hjkl both with the ctrl-b and alt, alt-a alternates between windows.
