# Path to My dotfiles folder
export OS=$(uname -s)
DOTFILES=$HOME/dotfiles

DISABLE_AUTO_TITLE="true"   # Disable autorename tmux windows <c-a>+, ranme window
DISABLE_AUTO_UPDATE="true"

# PLUGINS {{{
source $HOME/.zsh/antigen/antigen.zsh
antigen use oh-my-zsh
antigen bundle tmuxinator
antigen bundle soimort/translate-shell
antigen bundle rbenv
antigen bundle pass
if [[ $OS == 'Darwin' ]]; then
    antigen bundle brew-cask
    antigen bundle osx #vncviewer() quick-look()
fi
antigen bundle web-search # web_search ->web_search() google, duckduckgo, etc
# antigen theme #clean #nanotech #edvardm #robbyrussell
# antigen theme agnoster
antigen apply
# }}}
# THEME {{{
source $HOME/.zsh/agnoster.zsh-theme
# source $HOME/.zsh/padawan_agnoster.zsh-theme
# source $HOME/.zsh/padawan.zsh-theme
# }}}
# PATH
PATH=$HOME/bin/:/usr/local/bin:/usr/local/sbin:$HOME/bin/dasht/bin:$PATH
export MANPATH=location_where_you_cloned_or_downloaded_dasht/man:$MANPATH
# SOURCES {{{
fpath=($HOME/.zsh/zsh-completions/src $fpath)
source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
# }}}
#3rd party packages {{{
if [[ -f $HOME/bin/z/z.sh ]]; then
    source $HOME/bin/z/z.sh # z  - Recent/Frequent cd
elif [[ -f $HOME/bin/autoenv/activate.sh ]]; then
    source $HOME/bin/autoenv/activate.sh
elif [[ -f $HOME/bin/zaw/zaw.zsh ]]; then
    source $HOME/bin/zaw/zaw.zsh # compleion?
    bindkey '^@' zaw
else
    echo 'Please run dotfiles/start.sh in orser to install necessary packages'
fi
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh      # Must be after set -o vi
export FZF_COMPLETION_TRIGGER='**'
export FZF_TMUX=1
export FZF_DEFAULT_OPTS="--multi --no-height"
export FZF_CTRL_T_OPTS="--no-height --select-1 --exit-0 --preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
# export FZF_CTRL_R_OPTS=''
# }}}

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=6
# BINDS {{{
# ZLE - Zsh Line Editor - http://www.cs.elte.hu/zsh-manual/zsh_14.html
# VIM-MODE
export KEYTIMEOUT=1
set -o vi
bindkey -v
# COMMAND MODE
bindkey -M vicmd 'k' history-substring-search-up                    # fish up
bindkey -M vicmd 'j' history-substring-search-down                  # fish down
bindkey -M vicmd "?" history-incremental-pattern-search-backward    # increm up
bindkey -M vicmd "/" history-incremental-pattern-search-forward     # increm down
bindkey -M vicmd '^v' edit-command-line                              # open line in vi
bindkey -M vicmd 'u' undo                                           # undo
bindkey -M vicmd '^r' redo                                          # redo
bindkey -M vicmd '~' vi-swap-case                                   # swap case
# INSERT MODE
bindkey -M viins '^[[A' history-search-backward                  # crap searchUp
bindkey -M viins '^[[B' history-search-forward                   # poor searchDown
# bindkey -M viins '^r' history-incremental-search-backward        # increm up
# bindkey -M viins '^s' history-incremental-search-forward         # increm down
bindkey -M viins '^[[Z' reverse-menu-complete
bindkey -M viins '^a' vi-beginning-of-line
bindkey -M viins '^e' vi-end-of-line
bindkey -M viins '^f' vi-forward-blank-word
bindkey -M viins '^b' vi-backward-blank-word
bindkey -M viins '^l' clear-screen                               # Clear
bindkey -M viins '^w' vi-backward-kill-word
bindkey -M viins '^k' kill-whole-line                            # fish like C-c
bindkey -M viins '^u' vi-kill-line                               # kill from cursor to begin
bindkey -M viins '^d' vi-kill-eol                                # kill from cursor to EOL
bindkey -M viins '^y' vi-yank-whole-line
# FISH LIKE
bindkey '^p' history-substring-search-up                # best search ever fishUp
bindkey '^n' history-substring-search-down              # love  fisheDown
bindkey '^f' autosuggest-accept                         # fish-like autosuggestion
# }}}
#EXPORTS
export EDITOR='vim'
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
if [[ $OS == 'Darwin' ]]; then
    export HOMEBREW_NO_GITHUB_API="true"
fi
# PYTHON {{{
export PYTHONUSERBASE="$HOME/.local"
# PYENV
export VIRTUAL_ENV_DISABLE_PROMPT="true" # let my theme manage the prompt
export WORKON_HOME="$HOME/.virtualenvs"
export PROJECT_HOME="$HOME/Workspace/Python"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
alias py='pyenv'
alias pya='pyenv activate'
alias pyd='pyenv deactivate'
alias pyg='pyenv global'
alias pys='pyenv shell'
alias pyi='pyenv install'
alias pyii='pyenv virtualenv'
alias pyu='pyenv uninstall'
alias pyv='pyenv virtualenvwrapper'
alias pyenvs='pyenv virtualenvs'
pyenv virtualenvwrapper # load virtualenvwrapper for cdv/workon/etc
# source $HOME/.local/bin/virtualenvwrapper.sh
# If wanna use pyenv instead of virtualev
    # export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
    # alias workon='pyenv activate'
    # alias deactivate='pyenv deactivate'
    # alias rmvirtualenv='pyenv uninstall'
if [[ $OS == 'Darwin' ]]; then
    export VERSIONER_PYTHON_PREFER_32_BIT=yes
elif [[ $OS == 'Linux' ]]; then
    alias python2='python2'
    alias pip2='pip2'
    alias python='python3'
    alias pip='pip3'
fi
# }}}
# TLDR-PAGES {{{
# pip install tldr
export TLDR_COLOR_BLANK="white"
export TLDR_COLOR_NAME="cyan"
export TLDR_COLOR_DESCRIPTION="white"
export TLDR_COLOR_EXAMPLE="green"
export TLDR_COLOoR_COMMAND="white"
# }}}
# HISTORY {{{
export HISTFILE=$HOME/.zsh_history
export HISTIGNORE="ls:exit:bg:fg:cd:history:clear"
export HISTSIZE=10000
export HISTTIMEFORMAT='%Y-%m-%d %T '
export SAVEHIST=10000
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE
setopt ignore_eof
# }}}
# ALIASES {{{
# Caution
alias rm='rm -v '
#Lazyness
alias q='exit'
alias fuck='eval $(thefuck $(fc -ln -1 | tail -n 1)); fc -R'
alias ls='ls -ahFt'
alias lg='ls | grep'
alias si='cd ~/Documents/SI'
alias doc='cd ~/Documents'
# alias hg='history | grep'
alias zshrc='vim ~/.zshrc'
alias bashrc='vim ~/.bashrc'
alias vimrc='vim ~/.vimrc'
alias so='source'
alias sz='source ~/.zshrc'
if [[ $OS == 'Darwin' ]]; then
    alias top='top -stats pid,command,user,cpu,threads,mem,vsize,pageins,purg,state,time -o cpu -O mem -s 5 -n 20'
    alias quicksilver='. ~/Documents/QuicksilverIndexFix.sh'
fi
alias lyrics='. ~/.config/pianobar/lyrics.sh'
alias polipo='polipo -c ~/.polipo'
alias youtube_mp3='youtube-dl -i --extract-audio --audio-format mp3'
alias weather='ansiweather'
alias webshare='python -c "import SimpleHTTPServer;SimpleHTTPServer.test()"'
alias killentr='kill -9 $(ps -o ppid= $(pgrep entr))'
# Tmux
alias tm='tmux'
alias tt='tmuxinator'
alias tnew='tmux new-session'
alias ta='tmux attach -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tkillsesion='tmux kill-session -t'
alias tkillall='tmux kill-server'
# pip
alias pipi='pip install '
alias pipiu='pip install --user '
alias pipu='pip uninstall '
alias pipg='pip list | grep'
alias pipf='pip freeze'
alias pips='pip search '
# git
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gca='git commit -a'
alias gcm='git commit -m'
alias go='git checkout '
alias gl='git log --oneline --graph --decorate --all'
alias gr='git rm '
# brew
if [[ $OS == 'Darwin' ]]; then
    alias bcask='brew cask'
fi
# Mistakes
alias gti='git'
# Vim
if [[ $OS == 'Darwin' ]]; then
    alias mvim='/Applications/MacVim.app/Contents/MacOS/MacVim'
    alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
# elif [[ $OS == 'Linux' ]]; then
#     # Path to Gvim
fi
# Arconai
export vlc='/Applications/VLC.app/Contents/MacOS/VLC'
alias starwars="telnet towel.blinkenlights.nl" #starwars ascii
alias sports='arconai https://www.arconaitv.me/sports/'
alias sunny="arconai http://arconaitv.me/stream.php?id=5"
alias george='arconai https://www.arconaitv.me/sf/'
alias scroobs='arconai https://www.arconaitv.me/scroobs/'
alias 70s='arconai https://www.arconaitv.me/70s/'
alias office='arconai https://www.arconaitv.me/to/'
alias morty='arconai https://www.arconaitv.me/rm/'
alias docwho='arconai https://www.arconaitv.me/thedoctors/'
# }}}
# FUNCTIONS --------------------------------------------------------------- {{{
pytags(){
    ctags -R --fields=+l --languages=python --python-kinds=-iv -f ./pytags $(python -c "import os, sys; print(' '.join('{}'.format(d) for d in sys.path if os.path.isdir(d)))")
}

dasht(){
    command dasht "$@"
}

fzdo(){
    $@ $(fzf-tmux -m -x)
}

fzmdfind(){
    mdfind "$@" | fzf-tmux -m -x
}

p2k(){
    #command k2pdfopt $1 -w 600 -h 800 -dpi 167 -idpi -2 -wrap -hy -ws 0.375 -x
    command k2pdfopt $1 -mode fw -m 0.25 -x
}

arconai(){
    if [[ $# -eq 1 ]]; then
        url=$1
        player='mpv'
    elif [[ $# -eq 2 && $2 = 'vlc' ]]; then
        url=$1
        player="'$vlc' --file-caching=20000"
    elif [[ $# -eq 2 && $2 = 'mpv' ]]; then
        url=$1
        player='mpv'
    else
        echo 'arconai(ulr, player=mpv)'
    fi 
    command livestreamer --player $player hls://$(curl $url | grep m3u8 | cut -d '"' -f 2 | sed 's/\\//g') live
}

peerflix(){
    rm ~/Downloads/cache.torrent
    command peerflix $1 --vlc --path ~/Downloads
}

livestreamer(){
        command livestreamer --player-passthrough=hls --player "'$vlc' --file-caching=20000" $1 $2
}

streamlink(){
    command streamlink --player-passthrough=hls --player "'$vlc' --file-caching=20000" $1 $2
}

calc(){ awk "BEGIN{print $* }";}

i2p(){
if [ "$*" != "start" ] && [ "$*" != "stop" ]
	then
	echo "Error: Expect start or stop as argument to i2p command, try again!"
else 
#	su admin -c "sudo /Applications/i2p/i2prouter $*"
	/Applications/i2p/i2prouter $*
fi
}

# alias spoof='sudo ./Users/josefson/Documents/Hacking/spoof.sh'
spoof(){
    echo "Use the following command:"
    echo "bash -c '~/Documents/Hacking/spoof.sh -i en1 -n name -m 00:11:22:33:44:55'" 
}

vs(){ # VimServer - Starts vim remote server
    vim --servername vim
}

ve(){ # VimEdit - Edit files with current vim server
    vim --servername vim --remote $*
}

zsh_fix(){
    rm ~/.zcompdump*
    exec zsh
}
# }}}
# pip zsh completion start{{{
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] ) )
}
compctl -K _pip_completion pip
compctl -K _pip_completion pip2
compctl -K _pip_completion pip3
# }}}pip zsh completion end
tmcompare(){
    tmutil compare $1 $2 | grep -e "^$3"
}
qute(){
    workon qute;
    cdvirtualenv;
    cd qutebrowser;
    python -m qutebrowser --basedir ~/.config/qutebrowser
}
# vim: fdm=marker
