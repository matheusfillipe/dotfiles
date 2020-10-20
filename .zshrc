# If you come from bash you might have to change your $PATH.
# u
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/home/matheus/.cargo/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="ys"
ENABLE_CORRECTION="true"
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#plugins=(git)

export PER_DIRECTORY_HISTORY_TOGGLE='^ '

plugins=(
    archlinux
    git
    history-substring-search
    colored-man-pages
    zsh-autosuggestions
    zsh-syntax-highlighting
    per-directory-history
   # zsh-vim-mode
)

source $ZSH/oh-my-zsh.sh

# History in cache directory:
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.cache/zsh/history

# Basic auto/tab complete:
#autoload -U compinit
#zstyle ':completion:*' menu select
#zmodload zsh/complist
#compinit
#_comp_options+=(globdots)		# Include hidden files.

# vi mode
#bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init

echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
#
# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^O' 'lfcd'
bindkey -s '^F' 'retfile=$(finder.sh) # $retfile'

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

# Load zsh-syntax-highlighting; should be last.
#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

bindkey -e
bindkey -M emacs '^[' vi-cmd-mode


# start typing + [Up-Arrow] - fuzzy find history forward
if [[ "${terminfo[kcuu1]}" != "" ]]; then
  autoload -U up-line-or-beginning-search
  zle -N up-line-or-beginning-search
  bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# start typing + [Down-Arrow] - fuzzy find history backward
if [[ "${terminfo[kcud1]}" != "" ]]; then
  autoload -U down-line-or-beginning-search
  zle -N down-line-or-beginning-search
  bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi

bindkey '^r' history-incremental-search-backward      # [Ctrl-r] - Search backward incrementally for a specified string. The string may begin with ^ to anchor the search to the beginning of the line.
if [[ "${terminfo[kpp]}" != "" ]]; then
  bindkey "${terminfo[kpp]}" up-line-or-history       # [PageUp] - Up a line of history
fi
if [[ "${terminfo[knp]}" != "" ]]; then
  bindkey "${terminfo[knp]}" down-line-or-history     # [PageDown] - Down a line of history
fi

if [[ "${terminfo[kcbt]}" != "" ]]; then
  bindkey "${terminfo[kcbt]}" reverse-menu-complete   # [Shift-Tab] - move through the completion menu backwards
fi

bindkey '^?' backward-delete-char                     # [Backspace] - delete backward
if [[ "${terminfo[kdch1]}" != "" ]]; then
  bindkey "${terminfo[kdch1]}" delete-char            # [Delete] - delete forward
else
  bindkey "^[[3~" delete-char
  bindkey "^[3;5~" delete-char
  bindkey "\e[3~" delete-char
fi


PATH="$HOME/.local/bin${PATH:+:${PATH}}"

source "$HOME/.zsh/plugins/zsh-system-clipboard/zsh-system-clipboard.zsh"
bindkey '^n' expand-or-complete
bindkey '^p' reverse-menu-complete
bindkey '^k' up-history
bindkey '^j' down-history
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward




# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias cx='chmod +x'
alias hotreload="ag -l | entr -r "
export EDITOR='vim'
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#if ! shopt -oq posix; then
#  if [ -f /usr/share/bash-completion/bash_completion ]; then
#    . /usr/share/bash-completion/bash_completion
#  elif [ -f /etc/bash_completion ]; then
#    . /etc/bash_completion
#  fi
#fi


remove=/opt/anaconda/bin
PATH=${PATH//$remove/}
export PATH="$PATH:/home/matheus/programs/flutter/bin"
export PATH=/home/matheus/mxe/usr/bin:$PATH
export PATH=$PATH:/opt/anaconda/bin
export PATH=$PATH:~/.emacs.d/bin
export http_proxy=''
export https_proxy=''
export ftp_proxy=''
export socks_proxy=''

PATH=/home/matheus/programs/simFlow/simFlow-3.1:${PATH};export PATH; # ADDED BY INSTALLER - DO NOT EDIT OR DELETE THIS COMMENT - 8F1FFBF3-4166-531F-536F-118E03C20EE2 588C0655-079F-B357-8FA5-5CEF1F102B8D

export ANDROID_HOME="/home/matheus/BACKUP/programs/android-sdk-linux/"
export NVPACK_ROOT="/media/matheus/Elements SE/CodeWorksforAndroid"
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/matheus/.sdkman"
[[ -s "/home/matheus/.sdkman/bin/sdkman-init.sh" ]] && source "/home/matheus/.sdkman/bin/sdkman-init.sh"
[ -z "$DISPLAY" ] && export DISPLAY=:0 



alias pacman="sudo pacman"
alias finds="grep -rn '.' -e "
alias findd="find . -type d -name "
alias findf="find . -type f -name "
alias lw="awk '{print \$NF}'"
alias fw="awk '{print \$1}'"
alias arec="parec -d 0 | lame -r -V0 - "
alias gitclone='git clone --depth 1 $(xclip -o | lw)'
alias ema="emacs -nw"

function gw {
  awk -v wc="$1" '{print $wc}'
}


lns(){
    [ "$3" = "-f" ] && rm -rf $2
    ln -s $(realpath $1) $(realpath $2)
}
# catch stdin, pipe it to stdout and save to a file
catch () { 
  cat - | tee /tmp/catch.out
  LAST=$(cat /tmp/catch.out)
  l=$(cat /tmp/catch.out)
}
# print whatever output was saved to a file
res () {
  cat /tmp/catch.out 
}

#. /opt/asdf-vm/asdf.sh


bindkey -s '^O' 'lfcd
'
bindkey -s '^F' 'retfile=$(finder.sh)
 $retfile'

# Edit line in vim with ctrl-G:
autoload edit-command-line; zle -N edit-command-line
bindkey '' edit-command-line


#source /home/matheus/.config/broot/launcher/bash/br

# >>> conda initialize >>>
function condainit(){
#
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda/bin:$PATH"
    fi
fi
unset __conda_setup
}
export PATH=$PATH:$HOME/.gem/ruby/2.7.0/bin
export PATH=$PATH:$HOME/.pub-cache/bin
