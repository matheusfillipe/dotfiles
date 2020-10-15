#!/bin/bash
if [[ "$1" == "update" ]]
then
  cp ~/.vimrc .
  cp ~/.zshrc .
  cp ~/.tmux.conf .
  cp ~/.config/nvim/init.vim nvim/
  cp ~/.config/vifm/vifmrc vifm/
  exit
fi

if command -v apt &> /dev/null 
then
  sudo apt install mosh curl vim neovim tmux git vifm -y
fi
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/kutsan/zsh-system-clipboard ~/.zsh/plugins/zsh-system-clipboard
mkdir -p ~/.config/nvim/
mkdir -p ~/.config/vifm/
cp ~/.vim/plugged ~/.config/nvim/plugged -r

curl https://raw.githubusercontent.com/matheusfillipe/My-Terminal-Setup/master/.vimrc -o ~/.vimrc
curl https://raw.githubusercontent.com/matheusfillipe/My-Terminal-Setup/master/.zshrc -o ~/.zshrc
curl https://raw.githubusercontent.com/matheusfillipe/My-Terminal-Setup/master/.tmux.conf -o ~/.tmux.conf
curl https://raw.githubusercontent.com/matheusfillipe/My-Terminal-Setup/master/nvim/init.vim -o ~/.config/nvim/init.vim
curl https://raw.githubusercontent.com/matheusfillipe/My-Terminal-Setup/master/vifm/vifmrc -o ~/.config/vifm/vifmrc

vim +PlugInstall +qall +silent
nvim +PlugInstall +qall +silent

chsh -s $(which zsh)
zsh
