#!/bin/bash
curl https://raw.githubusercontent.com/matheusfillipe/My-Terminal-Setup/master/.vimrc -o ~/.vimrc
curl https://raw.githubusercontent.com/matheusfillipe/My-Terminal-Setup/master/.zshrc -o ~/.zshrc
curl https://raw.githubusercontent.com/matheusfillipe/My-Terminal-Setup/master/.tmux.conf -o ~/.tmux.conf
curl https://raw.githubusercontent.com/matheusfillipe/My-Terminal-Setup/master/nvim/init.vim -o ~/.config/nvim/init.vim
curl https://raw.githubusercontent.com/matheusfillipe/My-Terminal-Setup/master/vifm/vifmrc -o ~/.config/vifm/vifmrc

vim +PlugInstall +qall +silent
nvim +PlugInstall +qall +silent
nvim +"CocInstall coc-solargraph" +qall +silent
nvim +"CocInstall coc-solargraph" +qall +silent
~/.tmux/plugins/tpm/scripts/install_plugins.sh
