# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
THEME='p10k'
# THEME='padawan'
if [[ $THEME == 'p10k' ]]; then
    if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
      source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
    fi
fi

# Disable autorename tmux windows <c-a>+, ranme window
DISABLE_AUTO_TITLE="true"
DISABLE_AUTO_UPDATE="true"

# EXPORTS {{{
export OS=$(uname -s)
export EDITOR='vim'
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
if [[ $OS == 'Darwin' ]]; then
    export HOMEBREW_NO_GITHUB_API="true"
fi
# }}}
# PATH {{{
# PATH=$HOME/bin/:/usr/local/bin:/usr/local/sbin:$PATH
if [ -d "$HOME/bin" ] ; then
    PATH=$HOME/bin:$PATH
fi
if [ -d "$HOME/.local/bin" ] ; then
    PATH=$HOME/.local/bin/:$PATH
fi
# }}}
# PLUGINS {{{
source $HOME/.zsh/antigen/antigen.zsh
# fzf-tab must come before all plugins to glob every completion
antigen bundle Aloxaf/fzf-tab 
antigen use oh-my-zsh
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zaw
# antigen bundle matthewfranglen/speedread
# antigen bundle wfxr/forgit
source /home/elodin/bin/speedread/speedread.plugin.zsh
# THEME {{{
if [[ $THEME == 'p10k' ]]; then
    # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
    antigen theme romkatv/powerlevel10k
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
fi
if [[ $THEME != 'p10k' ]]; then
    POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
    source $HOME/.zsh/padawan_agnoster.zsh-theme
fi
# }}}
antigen apply

# Must exist after antigen apply
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main line brackets cursor)
typeset -A ZSH_HIGHLIGH_STYLES
ZSH_HIGHLIGHT_STYLES[line]='bold'
ZSH_HIGHLIGHT_STYLES[default]='fg=red'
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=7
# }}}
# 3RD PARTY {{{
if [[ -f $HOME/bin/z/z.sh ]]; then
    source $HOME/bin/z/z.sh # z  - Recent/Frequent cd
fi
# DIRENV
if command -v direnv &> /dev/null; then
    eval "$(direnv hook zsh)"
fi
# PIP
if command -v pip3 &> /dev/null; then
    eval "`pip completion --zsh`"
    compctl -K _pip_completion pip3
fi
# nnn
if command -v nnn &> /dev/null; then
    source $HOME/.config/nnn/exports.sh
fi
# TLDR
if command -v tldr &> /dev/null; then
    # pip install tldr
    export TLDR_COLOR_BLANK="white"
    export TLDR_COLOR_NAME="cyan"
    export TLDR_COLOR_DESCRIPTION="white"
    export TLDR_COLOR_EXAMPLE="green"
    export TLDR_COLOoR_COMMAND="white"
fi
# }}}
# VIM-MODE {{{
# ZLE - Zsh Line Editor - http://www.cs.elte.hu/zsh-manual/zsh_14.html
# status/mode on right side of command
if [[ $THEME != 'p10k' ]]; then
    function zle-line-init zle-keymap-select {
        RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
        RPS2=$RPS1
        zle reset-prompt
    }
    zle -N zle-line-init
    zle -N zle-keymap-select
fi
# VIM-MODE
export KEYTIMEOUT=1
set -o vi
bindkey -v
# BINDS
# COMMAND MODE
bindkey -M vicmd 'k' history-substring-search-up                    # fish up
bindkey -M vicmd 'j' history-substring-search-down                  # fish down
bindkey -M vicmd "?" history-incremental-pattern-search-backward    # increm up
bindkey -M vicmd "/" history-incremental-pattern-search-forward     # increm down
bindkey -M vicmd 'u' undo                                           # undo
bindkey -M viins '^v' edit-command-line                              # open line in vi
# bindkey -M vicmd '^r' redo                                          # redo
bindkey -M vicmd '~' vi-swap-case                                   # swap case
# INSERT MODE
bindkey -M viins '^[[A' history-search-backward                  # crap searchUp
bindkey -M viins '^[[B' history-search-forward                   # poor searchDown
# bindkey -M viins '^r' history-incremental-search-backward        # increm up
# bindkey -M viins '^s' history-incremental-search-forward         # increm down
bindkey -M viins '^[[Z' reverse-menu-complete                    # shift tab
bindkey -M viins '^a' vi-beginning-of-line
bindkey -M viins '^e' vi-end-of-line
bindkey -M viins '^w' vi-forward-blank-word
bindkey -M viins '^b' vi-backward-kill-word
bindkey -M viins '^h' vi-backward-blank-word
bindkey -M viins '^l' clear-screen                               # Clear
bindkey -M viins '^k' kill-whole-line                            # fish like C-c
bindkey -M viins '^u' vi-kill-line                               # kill from cursor to begin
bindkey -M viins '^d' vi-kill-eol                                # kill from cursor to EOL
bindkey -M viins '^y' vi-yank-whole-line
# FISH LIKE
bindkey '^p' history-substring-search-up                # best search ever fishUp
bindkey '^n' history-substring-search-down              # love  fisheDown
bindkey '^f' autosuggest-accept                         # fish-like autosuggestion
# Avaliable keys -> ^o;^i;^m;^s;^v;^y;^z
# FZF 
if [[ -f $HOME/bin/fzf/bin/fzf ]]; then
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh      # Must be after set -o vi
    export FZF_COMPLETION_TRIGGER='**'
    export FZF_TMUX=1
        # --bind=ctrl-h:backward-word\
        # --bind=ctrl-l:forward-word\
    export FZF_DEFAULT_OPTS="\
        --multi --no-height\
        --bind=ctrl-n:unix-line-discard\
        --bind=ctrl-m:clear-query\
\
        --bind=ctrl-f:kill-word\
        --bind=ctrl-b:backward-kill-word\
\
        --bind=ctrl-g:top\
        --bind=ctrl-u:page-up\
        --bind=ctrl-d:page-down\
\
        --bind=ctrl-p:toggle-preview\
        --bind=ctrl-o:jump\
        --bind=ctrl-y:yank\
        --bind=ctrl-c:cancel\
        --bind=enter:accept\
\
        --bind=ctrl-t:toggle-all\
        --bind=ctrl-z:deselect-all\
        --bind=tab:toggle+down\
        --bind=shift-tab:toggle+up\
    "
    export FZF_CTRL_T_OPTS="--no-height --select-1 --exit-0 --preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
    export FZF_CTRL_R_OPTS=''
    if [ -f $HOME/.zsh/fzf_snippets.sh ]; then
        source $HOME/.zsh/fzf_snippets.sh
        bindkey -r '^j'
        bindkey '^jk' fzf_kill              # fzf kill processes
        bindkey '^jg' fda                   # fzf cd -a(include hidden)
        bindkey '^o' fzf-cd-widget  #cd fzf
        bindkey '^@' zaw
    fi
fi
# }}}
# PYTHON {{{
# pip install --user location
export PYTHONUSERBASE="$HOME/.local"
export WORKON_HOME="$HOME/.virtualenvs"
# VENVWRAPPER
# if ! [[ -n $TMUX ]]; then
#     if [[ -f $HOME/.local/bin/virtualenvwrapper.sh ]]; then
#         source $HOME/.local/bin/virtualenvwrapper.sh
#     fi
# fi
# }}}
source $HOME/.aliases
# completion
autoload -U compinit colors zcalc bashcompinit
compinit -d
# pipx
bashcompinit
eval "$(register-python-argcomplete pipx)"
# SETOPT {{{
# Completions goodies
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path 
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
setopt EXTENDEDGLOB
setopt NOCASEGLOB
setopt NUMERICGLOBSORT
setopt RCEXPANDPARAM
setopt NOBEEP
setopt AUTOCD
setopt PROMPT_SUBST
setopt COMPLETE_IN_WORD
# HISTORY
setopt NO_HIST_VERIFY
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE
setopt IGNORE_EOF
# do not set this option, otherwise others(dups) will not work
# setopt INTERACTIVE_COMMENTS  # pound sign in prompt
export HISTFILE=$HOME/.zsh_history
export HISTIGNORE="man:ls:exit:bg:fg:cd:history:clear:echo:print:which:peerflix"
export HISTSIZE=10000
export HISTTIMEFORMAT='%Y-%m-%d %T '
export SAVEHIST=10000
# }}}
# vim: fdm=marker
