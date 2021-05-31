" VIM.PLUG ---------------------------------------------------------------- {{{
call plug#begin('~/.vim/bundle')
" UTILS
    Plug 'junegunn/fzf.vim'
    " Plug 'tpope/vim-unimpaired'                                             " Default pair keymappings
    Plug 'tpope/vim-repeat'                                                 " Support repeat command(.) for plugin actions
    Plug 'tpope/vim-obsession'                                              " Persistent session manager
    Plug 'tpope/vim-commentary'                                             " Comment
    Plug 'tpope/vim-surround'                                               " Parenthesis, quotes, tags, etc... as text objects
    " Plug 'vim-scripts/ReplaceWithRegister'                                  " [count][\"register]gr{motion}
    " Plug 'tpope/vim-eunuch'                                             " :sudo[edits|writes],Locate,Find,Move,Chmod,Remove,Rename,Mkdir,Unlink
    Plug 'mattn/webapi-vim' | Plug 'mattn/gist-vim'                         " Gist and dependency
    Plug 'tommcdo/vim-lion'                                                 " gl|L[ip|i{] Alight left|right gl/pattern/
    Plug 'romainl/vim-cool'                                                 " enable disable search hl
    Plug 'kshenoy/vim-signature'                                            " Display marks on gutter
" REFACTORING
    Plug 'markonm/traces.vim'                                               " Preview substitute/replacement on buffer
    Plug 'romainl/vim-qf'
    Plug 'fcpg/vim-kickfix'
    Plug 'ludovicchabant/vim-gutentags'
    " Plug 'tpope/vim-abolish'                                            " :Abolish {despa,sepe}rat{e,es,ed,ing,ely,ion,ions,or}  {despe,sepa}rat{}
" IDE
    Plug 'tpope/vim-dispatch'                                               " Async shit
    Plug 'hauleth/asyncdo.vim'                                              " Async shit
    Plug 'sjl/gundo.vim'                                                    " UndoTree
    Plug 'majutsushi/tagbar'                                                " Lateral tagbar
    " Plug 'rhysd/devdocs.vim'                                                " Documentation Plugin
    Plug 'romainl/vim-devdocs'
    Plug 'junegunn/vim-peekaboo'                                            " live show registers: \"; @ ; Ctrl-R
" GIT
    Plug 'tpope/vim-fugitive'                                               " Git inside vim
    Plug 'airblade/vim-gitgutter'                                           " Only for git
" COMPLETERS
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'ervandew/supertab'
    " Plug 'blueyed/jedi-vim', {'branch': 'call-signatures'}
    Plug 'davidhalter/jedi-vim', { 'for': 'python' }
    " Plug 'dense-analysis/ale'                                               " Lingter
    " Plug 'ajh17/VimCompletesMe', { 'for': 'python'}                     " TabContextual
    " Plug 'lifepillar/vim-mucomplete', { 'for': 'python' }               " Chain completion
    Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'                     " Snippets
" PYTHON
    Plug 'Vimjas/vim-python-pep8-indent'
    Plug 'vim-python/python-syntax'
    " Plug 'alfredodeza/pytest.vim'
" VUE
    Plug 'posva/vim-vue', { 'for': 'vue' }
" HTML
    Plug 'Valloric/MatchTagAlways'                                          " Highlight html/xml tags when between text
    Plug 'mattn/emmet-vim'                                                  " html snippets
    Plug 'vim-scripts/django.vim', { 'for': 'django' }                      " syntax highlight for django templates
" DATABASES
    Plug 'tpope/vim-dadbod'
    Plug 'kristijanhusak/vim-dadbod-ui'
" TMUX
    Plug 'jpalardy/vim-slime', { 'for': 'python' }
" COLORSCHEMES
    " Plug 'lifepillar/vim-colortemplate'                                 " template to create colorshcemes
    Plug 'ryanoasis/vim-devicons'
    Plug 'sjl/badwolf'
    Plug 'morhetz/gruvbox'
    Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
    Plug 'tomasr/molokai'
    Plug 'dunckr/vim-monokai-soda'
    Plug 'crusoexia/vim-monokai'
    Plug 'flazz/vim-colorschemes'
" Testing
    Plug 'tpope/vim-dotenv'
    Plug 'itspriddle/vim-shellcheck', { 'for': 'sh' }
    Plug 'vim-scripts/ansiesc.vim'
    Plug 'vimwiki/vimwiki'
    " Plug sheerun/vim-polyglot"
    " Plug 'rhysd/vim-grammarous'                                         " :GrammarousCheck
    " Plug 'lifepillar/pgsql.vim'
        " let g:sql_type_default = 'pgsql'
call plug#end()
" }}}
" VIM OPTIONS ------------------------------------------------------------- {{{
filetype plugin indent on   "required
syntax on                   "syntax highlight and colorscheme
" set nocompatible

if executable('rg')
    set grepprg=rg\ --vimgrep
else
    set grepprg=grep\ -nr
endif
set grepformat^=%f:%l:%c:%m

" GENERAL STUFF
set path=.,,**                      " Search relative to current file + directory
set wildcharm=<C-z>                 " Tab for command-line-expansion in mappings
set termencoding=utf-8
set encoding=utf-8
set exrc                            " enable to read local .vimrc
set mouse=a                         " enable mouse features
" Show block cursor in Normal mode and line cursor in Insert mode
let &t_ti.="\e[2 q"
let &t_SI.="\e[6 q"
let &t_SR.="\e[4 q"
let &t_EI.="\e[2 q"
let &t_te.="\e[0 q"
" set relativenumber                " relative number to the cursor line
" set number                        " show linenumbers, puts number after relative(exclude 0)
" set cursorline                    " highlight current line
set showtabline=1                   " Show tabline only when more than one tab exists
set showmatch                       " show matching for symbols like () and etc.
set matchtime=2                     " Time spent displaying the mathcing symbol.
set visualbell                      " Flash the screen instead of beeping on errors"
set t_vb=                           " And then disable even the flashing"
set lazyredraw                      " redraw only when we need to.
" STATUS / COMMAND LINE:
set wildmenu                        " Better commandline completion
set wildmode=longest:full,full      " Expand match on first Tab complete
set showcmd                         " Show (partial) command in status line.
set showmode                        " show --MODE--
set laststatus=2                    " Always show a status line
set cmdheight=2                     " Prevent "Press Enter" messages
set shortmess+=Irm                    " Prevent intro when opening vim
"stuff to ignore when tab completing
set wildignore+=*.o,*.obj,*~,*.so,*.swp,*~,._*
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
set wildignore+=*.gif,*.jpg,*.png,*.log
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*.pyc,*.pyo,**/__pycache__/**,.venv/**
" SEARCH
set hlsearch                        " Highlight searches. See below for more.
set ignorecase                      " Do case insensitive matching...
set smartcase                       " ...except when using capital letters
set incsearch                       " Incremental search
" INSERT/EDIT
set backspace=indent,eol,start      " Better handling of backspace key
set autoindent                      " Sane indenting when filetype not recognised
set copyindent
set nostartofline                   " Emulate typical editor navigation behaviour
set nopaste                         " Start in normal (non-paste) mode
if has('patch-8.1.1880')
    set completeopt=menuone,noinsert,noselect,preview,popup    " Show even only 1 complete option
else
    set completeopt=menuone,noinsert,noselect    " Show even only 1 complete option
endif
" INDENTING
set tabstop=4                       " number of visual spaces per TAB
set softtabstop=4                   " number of spaces in tab when editing
set shiftwidth=4
set expandtab                       " number of spaces in tab when editing
set smarttab                        " use shiftwidth/tabstop based on context
" WRAPPING LINES
set colorcolumn=79
set wrap  	                    " enable wrap mode to see long code lines
set linebreak                   " when wrapping, wrap at word boundaries (vs last char)
set breakindent                 " preserves the indent level of wrapped lines
set whichwrap=b,~,<,>,[,],h,l   " More intuitive arrow movements
set showbreak=>\
set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
set textwidth=0
set backspace=indent,eol,start  " allow backspace on everything in insert mode
" BUFFERS
" {{{Changing between unsaved buffers is not possible by default. [hidden] makes
" it possible to change between unsaved buffers. [autowrite] auto save the
" modified buffer you are leaving from. This is good in order to keep your
" buffers saved in case of !qa}}}
set autoread                      " file is not modified in vim but changed outside, reload it
set hidden                        " Edit multiple unsaved files at the same time
set autowrite                     " write buffer to file when chnage focus
" set confirm                     " Prompt to save unsaved changes when exiting
set formatoptions=tcq
set history=9999
set diffopt+=context:4,vertical
set splitright                    " when :vs focus goes to right
set splitbelow                    " when :sp focus goes bottom
" " STATUSLINE {{{
" " Functions {{{
" function! StatusMode()
"     let l:modes={
"         \'n' : 'Normal',
"         \'no' : 'N·Operator Pending',
"         \'v' : 'Visual',
"         \'V' : 'V·Line',
"         \'^V' : 'V·Block',
"         \'s' : 'Select',
"         \'S': 'S·Line',
"         \'^S' : 'S·Block',
"         \'i' : 'Insert',
"         \'R' : 'Replace',
"         \'Rv' : 'V·Replace',
"         \'c' : 'Command',
"         \'cv' : 'Vim Ex',
"         \'ce' : 'Ex',
"         \'r' : 'Prompt',
"         \'rm' : 'More',
"         \'r?' : 'Confirm',
"         \'!' : 'Shell',
"         \'t' : 'Terminal '
"     \}
"     let l:current_mode = mode()
"     return get(l:modes, l:current_mode, 'Visual Block')
" endfunction
" " Function: display errors from Ale in statusline
" function! LinterStatus() abort
"    let l:counts = ale#statusline#Count(bufnr(''))
"    let l:all_errors = l:counts.error + l:counts.style_error
"    let l:all_non_errors = l:counts.total - l:all_errors
"    return l:counts.total == 0 ? '' : printf(
"    \ 'W:%d E:%d',
"    \ l:all_non_errors,
"    \ l:all_errors
"    \)
" endfunction
" function! LinterStatus2() abort
"     let l:qlist_items = len(getqflist())
"     let l:llist_items = len(getloclist(0))
"     if l:qlist_items > 0 || l:llist_items > 0
"         return "Qf[".l:qlist_items."]Loc[".l:llist_items."]"
"     else
"         return ''
"     endif
" endfunction
" function! StatusBranch()
"   return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
" endfunction
" function! StatuslineGit()
"     let l:branchname = system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
"     return strlen(l:branchname) > 0?"".l:branchname.' ':''
" endfunction
" " }}}
" hi Search cterm=NONE ctermbg=202 ctermfg=black
" hi IncSearch cterm=NONE ctermbg=white ctermfg=black
" hi User1 ctermbg=70 ctermfg=black
" hi User2 cterm=standout ctermbg=magenta ctermfg=black
" hi User3 cterm=standout,italic ctermbg=70 ctermfg=black
" hi User4 cterm=standout ctermbg=darkred ctermfg=black
" hi User9 cterm=NONE ctermbg=brown ctermfg=black
" hi StatusLineNC cterm=reverse ctermbg=white ctermfg=black
" hi StatusLine cterm=NONE ctermbg=black ctermfg=white
" set statusline=                                                   " clear the statusline for when vimrc is reloaded
" set statusline+=%#ErrorMsg#%{&paste?'paste/':''}%*                " errors if any
" set statusline+=%1*\ %{StatusMode()}\ %*                          " vim mode
" set statusline+=%2*[%(%W%H%R,%)%M%n]%*                             " flags and buf no
" set statusline+=%4*\ %{StatuslineGit()}%*                         " branch if any
" set statusline+=%3*\ %10f                                         " file name
" set statusline+=%4*%(%{gutentags#statusline('[',']')}%)%*
" set statusline+=%=                                                " right align
" if &rtp =~ 'coc.vim'
"     set statusline+=%<%{coc#status()}%{get(b:,'coc_current_function','')}
" endif
" set statusline+=%4*\ %{strlen(&ft)?&ft:'none'}\ %*                " filetype
" set statusline+=%2*\ %{strlen(&fenc)?&fenc:&enc}%*                " encoding
" set statusline+=%2*[%{&fileformat}]\ %*                           " file format
" " set statusline+=%(%9*\ %{LinterStatus()}\ %*%)
" set statusline+=%9*%(\ %{LinterStatus2()}\ %)%*
" set statusline+=%1*[%c,%l/%L]%*                                   " position in buffer

" " }}}
" }}}
set background=dark
colorscheme gruvbox
" MAPPINGS ---------------------------------------------------------------- [[[
" NORMAL {{{
" -------------- GENERAL SHIT
" Kill bad habits
" noremap h <nop>
" noremap j <nop>
" noremap k <nop>
" noremap l <nop>
" Get more info from c-g -> better file information on the status line
nnoremap <c-g> 2<c-g>
" Highlighting
nnoremap <silent> <space> :nohlsearch<bar>:echo<cr>
" Romainl's inner paragraph substitution <key>ipfoo , <key>Gfoo , <key>?bar<CR>foo<CR> from prev bar to current line
nmap <silent> <space>c m':set opfunc=romainl#Substitute<CR>g@
" SHORTCUTS -------------------------------------------------------------------
nmap Q @q
" Select last pasted text
nnoremap gp '[V']'<Esc>
" unimpaired
nnoremap [b :bprevious<CR>
nnoremap ]b :bnext<CR>
nnoremap ]B :blast<CR>
nnoremap [B :bfirst<CR>
nnoremap [l :lprevious<CR>
nnoremap ]l :lnext<CR>
nnoremap [L :lfirst<CR>
nnoremap ]L :llast<CR>
nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>
nnoremap [Q :cfirst<CR>
nnoremap ]Q :clast<CR>
nnoremap [<space> O<Esc>j
nnoremap ]<space> o<Esc>k
nnoremap [e "zdd k"zp
nnoremap ]e "zdd j"zp
" swap current to below/above
nnoremap >p p'[V']'<Esc>>w
nnoremap >P P'[V']'<Esc>>w
nnoremap <p p'[V']'<Esc><w
nnoremap <P P'[V']'<Esc><w
nnoremap =P P'[V']'<Esc>=w
nnoremap =P P'[V']'<Esc>=w
" move current line/selection above/below
nnoremap <expr> [e ":move ".eval('line(".")-2')."<CR>"
nnoremap <expr> ]e ":move ".eval('line(".")+1')."<CR>"
vnoremap <expr> [e ":move ".eval('line(".")-2')."<CR>"
vnoremap <expr> ]e ":move ".eval('line(".")+1')."<CR>"
" WINDOW ----------------------------------------------------------------------
nnoremap <space>w <c-w>
nnoremap <space>w< 5<c-w><
nnoremap <space>w> 5<c-w>>
nnoremap <space>w] 5<c-w>+
nnoremap <space>w[ 5<c-w>-
" Swap window_zoom and window only because better mapping/mnemonic
nnoremap <space>wo :<c-u>call utils#WindowZoomToggle()<cr>
nnoremap <space>wO <c-w>o
" Smooth scrolling
nnoremap <silent> <c-u> :call utils#SmoothScroll(1)<cr>
nnoremap <silent> <c-d> :call utils#SmoothScroll(0)<cr>
nnoremap <space>sb HmhLml<c-w>v'lzt:set scrollbind<CR>
" }}}
" YANK PASTE {{{
" make Y consistent with C and D.
nnoremap Y y$
nnoremap <space>y "+y
vnoremap <space>y "+y
nnoremap <space>Y "+Y
vnoremap <space>Y "+Y
nnoremap <space>p "+p
vnoremap <space>p "+p
nnoremap <space>P "+P
vnoremap <space>P "+P
" }}}
" INSERT {{{
" Short completion for: Tags,File/Path,dict,line
inoremap <C-]> <C-x><C-]>
inoremap <C-f> <C-x><C-f>
inoremap <C-l> <C-x><C-l>
" indented enter
inoremap <C-j> <CR><C-o>O<C-t>
inoremap <C-Return> <Esc>
" }}}
" VISUAL {{{
" unimpaired move last pasted text to up down
vmap <C-y> [e'[V']
vmap <C-e> ]e'[V']
" }}}
" COMMAND {{{
" Up make recursive search, C-P just do previous
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
" Command-line like reverse-search
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>
" }}}
" ONOREMAP {{{
onoremap in( :<c-u>normal! f(vi(<cr>
onoremap ip( :<c-u>normal! F)vi(<cr>
onoremap an( :<c-u>normal! f(vf)<cr>
onoremap ap( :<c-u>normal! F)vF(<cr>
onoremap in{ :<c-u>normal! f{vi{<cr>
onoremap ip{ :<c-u>normal! F}vi{<cr>
onoremap an{ :<c-u>normal! f{vf}<cr>
onoremap ap{ :<c-u>normal! F}vF{<cr>
"}}}
" FUNCTION KEYS {{{
nnoremap <F2> :GundoToggle<CR>
nnoremap <F3> :TagbarToggle<CR>
nnoremap <F4> :Dispatch 
nmap <F5> <Plug>(ale_lint)
nmap <F6> <Plug>(ale_fix)
set pastetoggle=<F10>               " Use <F10> to toggle paste modes
" }}}
" LEADER KEYS ------------------------------------------------------------- {{{
" let mapleader = \" "
" COMMA -----------------------------------------------------------------------
" Often utilize vertical splits
nnoremap ,b :buffer *
nnoremap ,e :e **/*
nnoremap ,f :find *
nnoremap ,s :sfind *
nnoremap ,v :vert sfind *
nnoremap ,t :tabfind *
nnoremap ,F :find <C-R>=fnameescape(expand('%:p:h')).'/**/*'<CR>
nnoremap ,V :vert sfind <C-R>=fnameescape(expand('%:p:h')).'/**/*'<CR>
nnoremap ,S :sfind <C-R>=fnameescape(expand('%:p:h')).'/**/*'<CR>
" Utils/Internals
cnoremap <expr> <CR> romainl#CCR()
nmap ,c :changes<CR>
nmap ,r :registers<CR>
nmap ,j :jumps<CR>
nmap ,m :marks<CR>
" nnoremap ,t :tjump /
nnoremap ,d :dlist /
nnoremap ,i :ilist /
nnoremap ,g :g//#<Left><Left>
nnoremap ,G :Global 
nnoremap ,u :call UltiSnips#RefreshSnippets()<CR>
nnoremap ,U :UltiSnips<C-z>
" SPACE -----------------------------------------------------------------------
" Options - o
nnoremap <space>on :<c-u>setlocal number!<cr>
nnoremap <space>or :<c-u>setlocal relativenumber!<cr>
nnoremap <space>oc :<c-u>setlocal cursorline!<cr>
nnoremap <space>ow :<c-u>setlocal wrap!<cr>
nnoremap <space>osp :<c-u>setlocal spell! \| set spell?<cr>
nnoremap <space>osb :<c-u>setlocal scrollbind!<cr>
nnoremap <space>of :<c-u>setlocal ft=
nnoremap <space>oh :<c-u>setlocal hlsearch!<cr>
nnoremap <space>ob :<c-u>set background=dark<cr>
nnoremap <space>oB :<c-u>set background=light<cr>
" Terminal
nnoremap <space>tv :vert term 
nnoremap <space>ts :term 
nnoremap <space>tt :term<cr>
" Git
nnoremap <silent> <space>gs :<c-u>Gstatus<cr>
nnoremap <silent> <space>gl :<c-u>Gclog<cr>
nnoremap <silent> <space>gL :<c-u>Gllog<cr>
nnoremap <space>gw :<c-u>Gwrite
nnoremap <space>gr :<c-u>Gread
nnoremap <space>gd :<c-u>Gdiffsplit<cr>
nnoremap <space>gg :<c-u>Ggrep<cr>
nnoremap <space>gG :<c-u>Glgrep<cr>
nnoremap <space>gb :<c-u>Git blame
nnoremap <space>gp :<c-u>Git push
nnoremap <space>gf :<c-u>Git fetch
if &rtp =~ 'vim-qf'
    " nmap <space>q? <Plug>(qf_qf_toggle)
    " nmap <space>q? <Plug>(qf_loc_toggle)
    nmap <space>qql <Plug>(qf_qf_switch)
    nmap <space>ql <Plug>(qf_loc_toggle_stay)
    nmap <space>qq <Plug>(qf_qf_toggle_stay)
endif
" }}}
" FZF-BINDINGS {{{
" fzf denite clap etc
if &rtp =~ 'fzf'
    " nnoremap <leader>e :FzfFiles<CR>
    " nnoremap <leader>f :Fzf
    nnoremap <space>ff :FzfFiles<CR>
    nnoremap <space>e :FzfGFiles<CR>
    nnoremap <space>b :FzfBuffers<CR>
    nnoremap <space>L :FzfLines<CR>
    nnoremap <space>l :FzfBLines<CR>
    nnoremap <space>T :FzfTags<CR>
    nnoremap <space>t :FzfBTags<CR>
    nnoremap <space>h :FzfHelptags<cr>
    nnoremap <space>r :RG<cr>
    nnoremap <space>u :FzfSnippets<CR>

    nnoremap <space>fm :FzfMarks<cr>
    nnoremap <space>fM :FzfMaps<cr>
    nnoremap <space>f/ :FzfHistory/<cr>
    nnoremap <space>f: :FzfHistory:<cr>
    nnoremap <space>fx :FzfCommands<cr>
    nnoremap <space>fc :FzfCommits<CR>
    nnoremap <space>fb :FzfBCommits<CR>
    nnoremap <space>fs :FzfSnippets<CR>

    " Mapping selecting mappings
    nmap <leader><tab> <plug>(fzf-maps-n)
    xmap <leader><tab> <plug>(fzf-maps-x)
    omap <leader><tab> <plug>(fzf-maps-o)

    " Insert mode completion
    imap <c-f> <plug>(fzf-complete-path)
    imap <c-l> <plug>(fzf-complete-line)
endif
" }}}
" ]]]
" FZF-CONFIG --------------------------------------------------------------------- {{{
" This is the default extra key bindings
let g:fzf_command_prefix = 'Fzf'
let g:fzf_buffers_jump = 1
let g:fzf_tags_command = ''
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit',
\}
" }}}
" ULTISNIPS --------------------------------------------------------------- {{{
if has('python3')
    let g:UltiSnipsUsePythonVersion=3
elseif has('python')
    let g:UltiSnipsUsePythonVersion=2
endif
let g:UltiSnipsEditSplit = "vertical"
let g:UltiSnipsSnippetDirectories = ["UltiSnips"]
" let g:UltiSnipsSnippetDirectories = ["bundle/vim-snippets/UltiSnips"]
let g:UltiSnipsJumpForwardTrigger = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"
let g:UltiSnipsExpandTrigger = "<C-b>"
let g:UltiSnipsListSnippets = "<C-u>" "replaced by fzf one
inoremap <silent> <C-j> <C-r>=utils#LoadUltiSnipsAndExpand()<CR>
" }}}
" EMMET-VIM --------------------------------------------------------------- {{{
" let g:user_emmet_mode='n'    "only enable normal mode functions.
" let g:user_emmet_mode='inv'  "enable all functions, which is equal to
let g:user_emmet_mode='a'    "enable all function in all mode.
let g:user_emmet_leader_key=','
" }}}
" JEDI-VIM ---------------------------------------------------------------- {{{
    if &rtp =~ 'supertab'
        let g:SuperTabDefaultCompletionType = 'context'
        let g:SuperTabContextDefaultCompletionType = '<c-n>'
    endif
    let g:jedi#auto_initialization = 1
    let g:jedi#auto_vim_configuration = 0
    " Let Something else complete
    let g:jedi#completions_enabled = 0
    let g:jedi#popup_on_dot = 0
    " let g:jedi#popup_select_first = 0
    let g:jedi#show_call_signatures = 0
    " let g:jedi#show_call_signatures_modes = '' " ni normal and insert. disabling cuz coc-python
    " let g:jedi#show_call_signatures_delay = 0
    " let g:jedi#smart_auto_mappings = 1 " auto type form module.name<space> import
    " let g:jedi#auto_close_doc = 1
    " let g:jedi#use_tabs_not_buffers = 0  " goto in tabs = 0 for buffers
    " let g:jedi#use_splits_not_buffers = ""  "goto in splits: top,left,right,bottom
" }}}
" COC {{{
" :cocinstall coc-marketplace, coc-ultisnips, coc-python
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" }}}
" ALE-LINTER -------------------------------------------------------------- {{{
if &rtp =~ 'ale'
    let g:ale_completion_enabled=0
    let g:ale_lint_on_text_changed = 'never'
    let g:ale_lint_on_enter = 0
    let g:ale_lint_on_save = 0
    let g:ale_lint_on_insert_leave = 0
    let g:ale_set_highlights = 1
    let g:ale_set_signs = 1
    " let g:ale_set_loclist = 1
    let g:ale_set_quickfix = 1
    let g:ale_echo_msg_error_str = 'E'
    let g:ale_echo_msg_warning_str = 'W'
    let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

    " Flake8 is pep8 plus a sane and simplistic styleguide/checker
    let g:ale_linters = {
    \   'python': ['flake8'],
    \}
    " yapf or black for fixers
    let g:ale_fixers = {
    \   '*': ['remove_trailing_lines', 'trim_whitespace'],
    \   'python' : ['autopep8', 'isort', 'black'],
    \}
endif
" " }}}
" GIST-VIM ---------------------------------------------------------------- {{{
" :[range]Gist
if has('mac')
    let g:gist_clip_command = 'pbcopy'
elseif has("unix")
    let g:gist_clip_command = 'xclip -selection clipboard' "linux
elseif has("win32")
    let g:gist_clip_command = 'putclip' "Cygwin
endif
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1
"}}}
" QF-VIM ------------------------------------------------------------------ {{{
if &rtp =~ 'vim-qf'
    let g:qf_mapping_ack_style = 1
    " s - open entry in a new horizontal window
    " v - open entry in a new vertical window
    " t - open entry in a new tab
    " o - open entry and come back
    " O - open entry and close the location/quickfix window
    " p - open entry in a preview window
endif
" }}}
" GRUVBOX ------------------------------------------------------------------ {{{
let g:gruvbox_italic = 1
let g:gruvbox_hls_cursor = 'orange'
let g:gruvbox_contrast_dark = 'hard'
" }}}
" AIRLINE ----------------------------------------------------------------- {{{
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.crypt = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.spell = '暈'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_symbols.dirty='⚡'
let g:airline#extensions#whitespace#enabled = 1
" }}}
" ONELINE-PLUGINS ------------------------------------------------------------- {{{
let g:gundo_prefer_python3 = 1
let g:shellcheck_disable_mappings = 1
let g:dispatch_no_maps = 1
let g:python_highlight_file_headers_as_comments = 1
" GutenTags
let g:gutentags_project_info = []
call add(g:gutentags_project_info, {'type': 'python', 'file': 'manage.py'})
call add(g:gutentags_project_info, {'type': 'python', 'file': 'pyproject.toml'})
" Repl
let g:slime_target = "tmux"
let g:slime_python_ipython = 1
" dadbod-ui
let g:db_ui_use_nerd_fonts = 1
" :CocInstall coc-db
" }}}
" COMMANDS ---------------------------------------------------------------- {{{
" sharing is caring{{{
"if osx pipe to pbcopy, elif linux requires(curl, xclip) 
command! -range=% SP <line1>,<line2>w !curl -F 'sprunge=<-' http://sprunge.us | tr -d '\n' | xclip -i -selection clipboard
command! -range=% CL <line1>,<line2>w !curl -F 'clbin=<-' https://clbin.com | tr -d '\n' | xclip -i -selection clipboard
command! -range=% VP <line1>,<line2>w !curl -F 'text=<-' http://vpaste.net | tr -d '\n' | xclip -i -selection clipboard
command! -range=% IX <line1>,<line2>w !curl -F 'f:1=<-' ix.io | tr -d '\n' | xclip -i -selection clipboard
command! -range=% TB <line1>,<line2>w !nc termbin.com 9999 | tr -d '\n' | xclip -i -selection clipboard
" }}}
" :Silent command that doesnt require to press enter after :!external
command! -nargs=1 Silent execute 'silent !' . <q-args> | execute 'redraw!'
command! -nargs=1 -complete=command Redir silent call romainl#Redir(<q-args>)
" GitJump [diff, merge] hash
command! -bar -nargs=* GitJump cexpr system('GIT_EDITOR= git-jump ' . expand(<q-args>))
" :Global pattern, Puts every instance of pattern on % inside locationlist; Change lgetexpr for cgetexpr for quickfixlist
command! -nargs=1 Global lgetexpr filter(map(getline(1,'$'), {key, val -> expand("%") . ":" . (key + 1) . ":1 " . val }), { idx, val -> val =~ <q-args> })
"Async grep: Making |:grep| to run asynchronously is also quite trivial with:
command! -bang -nargs=* -complete=dir Grep call asyncdo#run(
            \ <bang>0,
            \ { 'job': &grepprg, 'errorformat': &grepformat },
            \ <f-args>)
" Fzf User Commands
command! -bang Colors
    \ call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'}, <bang>0)
command! -bang Argadd call utils#FzfArgadd()
command! -nargs=* -bang RG call utils#FzfRipgrep(<q-args>, <bang>0)
" }}}
" FUNCTIONS --------------------------------------------------------------- {{{
" }}}

" overload the opfunc in order to perform gq without moving the cursor
function! FormatOperator(type, ...)
    normal! '[v']gq
    if v:shell_error > 0
        silent undo
        redraw
        echomsg 'formatprg "' . &formatprg . '" exited with status ' . v:shell_error
    endif
    call winrestview(w:gqview)
    unlet w:gqview
endfunction
nnoremap <silent> gq :let w:gqview = winsaveview()<CR>:set opfunc=FormatOperator<CR>g@
" needed in order for gqq to be used without using the above mapped gq
nnoremap gqq gqq

" Found this gist that would be possible to acomplish the same as above but quite didn't understand how to use/map it
" nnoremap <silent> gq :set opfunc=OpfuncSteady<CR>gq
" function! OpfuncSteady()
"   if !empty(&operatorfunc)
"     call winrestview(w:opfuncview)
"     unlet w:opfuncview
"     noautocmd set operatorfunc=
"   endif
" endfunction

" augroup OpfuncSteady
"   autocmd!
"   autocmd OptionSet operatorfunc let w:opfuncview = winsaveview()
"   autocmd CursorMoved * call OpfuncSteady()
" augroup END
" how to handle swapfiles (stolen from blueyed) {{{
augroup swapfile_handling
    au!
    au SwapExists * call s:handle_swapfile(expand('<afile>:p'))
augroup END
fu s:handle_swapfile(filename) abort
    " If the swap file is older than the file itself, just get rid of it.
    if getftime(v:swapname) < getftime(a:filename)
        call s:warning_msg('Old swap file detected, and deleted:   '..a:filename)
        call delete(v:swapname)
        let v:swapchoice = 'e'
    else
        call s:warning_msg('Swap file detected, opening read-only:   '..a:filename)
        let v:swapchoice = 'o'
    endif
endfu
fu s:warning_msg(msg) abort
    echohl WarningMsg
    " It seems that when `SwapExists` is fired, Vim executes `:echom` silently.
    unsilent echom a:msg
    echohl NONE
endfu
" }}}
" vim: fo=tcq fdm=marker tw=0
