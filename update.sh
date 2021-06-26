#!/bin/bash
curl https://raw.githubusercontent.com/matheusfillipe/dotfiles/master/.vimrc -o ~/.vimrc
curl https://raw.githubusercontent.com/matheusfillipe/dotfiles/master/.zshrc -o ~/.zshrc
curl https://raw.githubusercontent.com/matheusfillipe/dotfiles/master/.tmux.conf -o ~/.tmux.conf
curl https://raw.githubusercontent.com/matheusfillipe/dotfiles/master/nvim/init.vim -o ~/.config/nvim/init.vim
curl https://raw.githubusercontent.com/matheusfillipe/dotfiles/master/nvim/spatch.diff -o ~/.config/nvim/spatch.diff
curl https://raw.githubusercontent.com/matheusfillipe/dotfiles/master/nvim/ginit.vim -o ~/.config/nvim/ginit.vim
curl https://raw.githubusercontent.com/matheusfillipe/dotfiles/master/nvim/coc-settings.json -o ~/.config/nvim/coc-settings.json
curl https://raw.githubusercontent.com/matheusfillipe/dotfiles/master/vifm/vifmrc -o ~/.config/vifm/vifmrc

vim +PlugInstall +qall +silent
nvim +PlugInstall +qall +silent
nvim +"CocInstall coc-solargraph" +qall +silent
nvim +"CocInstall coc-tsserver" +qall +silent
nvim +"CocInstall coc-json" +qall +silent
#nvim +"CocInstall coc-python" +qall +silent
nvim +"CocInstall coc-jedi" +qall +silent
nvim +"CocInstall coc-snippets" +qall +silent
nvim --headless -u ~/.config/nvim/init.vim +UpdateRemotePlugins +qa
~/.tmux/plugins/tpm/scripts/install_plugins.sh
pip3 install -U jedi-language-server flake8
