#!/bin/bash
if [[ "$1" == "update" ]]
then
  cp ~/.vimrc .
  cp ~/.zshrc .
  cp ~/.tmux.conf .
  cp ~/.config/nvim/init.vim nvim/
  cp ~/.config/nvim/coc-settings.json nvim/
  cp ~/.config/vifm/vifmrc vifm/
  git add .; git commit -m "$2"; git push origin master
  exit
fi

if command -v apt &> /dev/null 
then
  sudo apt -y install mosh curl vim neovim tmux git vifm vim-airline fonts-powerline python3 ipython3 python3-pip socat ruby nodejs fzf bat silversearcher-ag
fi
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/kutsan/zsh-system-clipboard ~/.zsh/plugins/zsh-system-clipboard
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

sudo pip3 install powerline-status

mkdir -p ~/.config/nvim/
mkdir -p ~/.config/vifm/
mkdir -p ~/.cache/zsh/

bash -c "$(curl -fsSL https://raw.githubusercontent.com/matheusfillipe/My-Terminal-Setup/master/update.sh)"
echo "Allowing mosh"
sudo ufw allow 60000:61000/udp
chsh -s $(which zsh)
zsh

# POWERLINE
# tmux: source 
# source /usr/local/lib/python3.8/dist-packages/powerline/bindings/tmux/powerline.conf
