# Path to My dotfiles folder
export OS=$(uname -s)
DOTFILES=$HOME/dotfiles

DISABLE_AUTO_TITLE="true"   # Disable autorename tmux windows <c-a>+, ranme window
DISABLE_AUTO_UPDATE="true"

# PLUGINS {{{
source $HOME/.zsh/antigen/antigen.zsh
antigen use oh-my-zsh
antigen bundle gem
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
if [[ $OS == 'Linux' ]]; then
    PATH=$HOME/.gem/ruby/2.4.0/bin:$PATH
fi
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
# }}}

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=6
# BINDS {{{
# ZLE - Zsh Line Editor - http://www.cs.elte.hu/zsh-manual/zsh_14.html
# VIM-MODE
export KEYTIMEOUT=1
set -o vi
bindkey -v
if [[ -f $HOME/bin/fzf/bin/fzf ]]; then
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh      # Must be after set -o vi
    export FZF_COMPLETION_TRIGGER='**'
    export FZF_TMUX=1
    export FZF_DEFAULT_OPTS="--multi --no-height"
    export FZF_CTRL_T_OPTS="--no-height --select-1 --exit-0 --preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
    # export FZF_CTRL_R_OPTS=''
    source $HOME/.zsh/fzf_snippets.sh
fi
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
bindkey -r '^j'
bindkey -r '^s'
bindkey '^j' fz_pane
bindkey '^s' fz_session
# Avaliable keys -> ^o;^c;^i;^j;^m;^s;^q;^v;^y;^z
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
source $HOME/.aliases
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
# vim: fdm=marker 
