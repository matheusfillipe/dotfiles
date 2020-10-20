#!/bin/bash
curl https://raw.githubusercontent.com/matheusfillipe/dotfiles/master/.vimrc -o ~/.vimrc
curl https://raw.githubusercontent.com/matheusfillipe/dotfiles/master/.zshrc -o ~/.zshrc
curl https://raw.githubusercontent.com/matheusfillipe/dotfiles/master/.tmux.conf -o ~/.tmux.conf
curl https://raw.githubusercontent.com/matheusfillipe/dotfiles/master/nvim/init.vim -o ~/.config/nvim/init.vim
curl https://raw.githubusercontent.com/matheusfillipe/dotfiles/master/nvim/coc-settings.json -o ~/.config/nvim/coc-settings.json
curl https://raw.githubusercontent.com/matheusfillipe/dotfiles/master/vifm/vifmrc -o ~/.config/vifm/vifmrc

vim +PlugInstall +qall +silent
nvim +PlugInstall +qall +silent
nvim +"CocInstall coc-solargraph" +qall +silent
nvim +"CocInstall coc-solargraph" +qall +silent
~/.tmux/plugins/tpm/scripts/install_plugins.sh
