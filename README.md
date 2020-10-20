# Dotfiles
My personal optimal tmux, zsh and vim(nvim) configurations. This is mostly
intended for myself only but if you randomly come here be advised that **the
commands bellow will overwrite files**.

## Installation 
 
Please backup your files! This will overwrite them. 
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/matheusfillipe/dotfiles/master/install.sh)"
```

Don't do this!

```
cd ~; git clone https://github.com/matheusfillipe/dotfiles.git dotfiles --depth 1; cp -rf dotfiles/* ~/; cp -rf dotfiles/.* ~/; rm -rf dotfiles/; rm -rf .git
```

## Update 
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/matheusfillipe/dotfiles/master/update.sh)"
```

## What is this does

![alt text](https://github.com/matheusfillipe/dotfiles/blob/master/screenshot.png?raw=true)

![alt text](https://github.com/matheusfillipe/dotfiles/blob/master/nvim1.png?raw=true)

![alt text](https://github.com/matheusfillipe/dotfiles/blob/master/nvim2.png?raw=true)

* **ZSH**: Stuff like ctrl+F to start a file search in the current path using retfile, ctrl+O to lfcd, intuitive vim mode, oh-my-zsh and many other keybindings and plugins and theme. Esc enters vi mode, the clipboard is synced with the X's. 

* **VIM**: Line number display, dark theme, clipboard synced with Xorg...

* **NVIM:** Python, Rust, Go, Dart, nerdtree, tagtree and many other development
  focused plugins. Alt+Z = tagree; Alt+\ = nerdtree, C-M+[hjkl] for pane
  switching, tt for new tab, A-[q1] previous tab, A-[w2] next tab, fzf (A-B
  Buffer,  A-F Files, A-H history)

* **TMUX**: Clipboard synced with Xorg that works from remote ssh sessions, full mouse integration, basic plugins like tmux-ressurect, continuumm, vim copy mode. Vi like pane switching and resizing with hjkl both with the ctrl-b and alt, alt-a alternates between windows.
