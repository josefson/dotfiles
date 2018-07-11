# Path to My dotfiles folder
export OS=$(uname -s)
DOTFILES=$HOME/dotfiles

DISABLE_AUTO_TITLE="true"   # Disable autorename tmux windows <c-a>+, ranme window
DISABLE_AUTO_UPDATE="true"

# SETOPT {{{
# Completions goodies
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path 
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
setopt extendedglob
setopt nocaseglob
setopt numericglobsort
setopt rcexpandparam
setopt nobeep
setopt autocd
setopt prompt_subst
# HISTORY
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt NO_HIST_VERIFY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE
setopt ignore_eof
export HISTFILE=$HOME/.zsh_history
export HISTIGNORE="ls:exit:bg:fg:cd:history:clear"
export HISTSIZE=10000
export HISTTIMEFORMAT='%Y-%m-%d %T '
export SAVEHIST=10000
# }}}
# EXPORTS {{{
export EDITOR='vim'
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
if [[ $OS == 'Darwin' ]]; then
    export HOMEBREW_NO_GITHUB_API="true"
fi
# }}}
# PLUGINS {{{
source $HOME/.zsh/antigen/antigen.zsh
antigen use oh-my-zsh
# antigen bundle gem
# antigen bundle tmuxinator
# antigen bundle soimort/translate-shell
# antigen bundle rbenv
# antigen bundle pass
# if [[ $OS == 'Darwin' ]]; then
#     antigen bundle brew-cask
#     antigen bundle osx #vncviewer()
# fi
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-syntax-highlighting
antigen apply
# THEME {{{
# antigen theme #clean #nanotech #edvardm #robbyrussell
# antigen theme agnoster
source $HOME/.zsh/agnoster.zsh-theme
# source $HOME/.zsh/padawan_agnoster.zsh-theme
# }}}
# }}}
# PATH
PATH=$HOME/bin/:/usr/local/bin:/usr/local/sbin:$PATH
#3rd party packages {{{
if [[ -f $HOME/bin/z/z.sh ]]; then
    source $HOME/bin/z/z.sh # z  - Recent/Frequent cd
fi
if [[ -f $HOME/bin/zaw/zaw.zsh ]]; then
    source $HOME/bin/zaw/zaw.zsh
    bindkey '^@' zaw
fi
# DIRENV
eval "$(direnv hook zsh)"
# PIP
eval "`pip completion --zsh`"
compctl -K _pip_completion pip3
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
    source $HOME/.zsh/fzf_snippets.sh
    # export FZF_CTRL_R_OPTS=''
    bindkey -r '^j'
    bindkey -r '^s'
    bindkey '^j' fz_pane        #tmux_pane
    bindkey '^s' fz_session     #tmux_session
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
# Avaliable keys -> ^o;^c;^i;^j;^m;^s;^q;^v;^y;^z
# }}}
# PYTHON {{{
export PYTHONUSERBASE="$HOME/.local"
export WORKON_HOME="$HOME/.virtualenvs"
# PIPENV
# eval "$(pipenv --completion)"
# eval "$(_PIPENV_COMPLETE=source-zsh pipenv)" # Completions
# PYENV
export VIRTUAL_ENV_DISABLE_PROMPT="true" # let my theme manage the prompt
export PROJECT_HOME="$HOME/Workspace/Python"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"
alias py='pyenv'
alias pya='pyenv activate'
alias pyd='pyenv deactivate'
alias pyg='pyenv global'
alias pys='pyenv shell'
alias pyi='pyenv install'
alias pyu='pyenv uninstall'
alias pyv='pyenv virtualenvwrapper'
# pyenv virtualenvwrapper # load virtualenvwrapper for cdv/workon/etc
# source $HOME/.local/bin/virtualenvwrapper.sh
# If wanna use pyenv instead of virtualev
#     export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
#     alias workon='pyenv activate'
#     alias deactivate='pyenv deactivate'
#     alias rmvirtualenv='pyenv uninstall'
# }}}
# TLDR-PAGES {{{
# pip install tldr
export TLDR_COLOR_BLANK="white"
export TLDR_COLOR_NAME="cyan"
export TLDR_COLOR_DESCRIPTION="white"
export TLDR_COLOR_EXAMPLE="green"
export TLDR_COLOoR_COMMAND="white"
# }}}
source $HOME/.aliases
# completion
autoload -U compinit colors zcalc
compinit -d
# vim: fdm=marker 
