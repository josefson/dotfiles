" VIM.PLUG ---------------------------------------------------------------- {{{
call plug#begin('~/.vim/bundle')
source ~/dotfiles/vim/.vimrc_trash
" UTILS
    Plug 'Shougo/denite.nvim' | Plug 'neoclide/denite-extra' | Plug 'roxma/nvim-yarp' | Plug 'roxma/vim-hug-neovim-rpc'
    Plug 'junegunn/fzf.vim'
    Plug 'tpope/vim-unimpaired'                     " Default pair keymappings
    Plug 'tpope/vim-repeat'                         " Support repeat command(.) for plugin actions
    Plug 'tpope/vim-obsession'                      " Persistent session manager
    " Plug 'tpope/vim-eunuch'                         " :sudo[edits|writes],Locate,Find,Move,Chmod,Remove,Rename,Mkdir,Unlink
    Plug 'mattn/webapi-vim' | Plug 'mattn/gist-vim' " Gist and dependency
    Plug 'tommcdo/vim-lion'                         " gl|L[ip|i{] Alight left|right
    Plug 'romainl/vim-cool'                         " enable disable search hl
" IDE
    Plug 'tpope/vim-dispatch'                       " Async shit
    Plug 'sjl/gundo.vim'                            " UndoTree
    Plug 'majutsushi/tagbar'                        " Lateral tagbar
    Plug 'w0rp/ale'                                 " Async lint
    Plug 'rhysd/devdocs.vim'                        " Documentation Plugin
    " Plug 'ludovicchabant/vim-gutentags'             " Auto Tag creation
    Plug 'junegunn/vim-peekaboo'                    " live show registers
    " Plug 'kkoomen/vim-doge'                         " generate documentation
" GIT
    Plug 'tpope/vim-fugitive' | Plug 'rbong/vim-flog'   " Gitk alternative for vim
    Plug 'airblade/vim-gitgutter'                        " Only for git
" MOVEMENT/SEARCH&REPLACE
    " Plug 'tpope/vim-abolish'                        " :Abolish {despa,sepe}rat{e,es,ed,ing,ely,ion,ions,or}  {despe,sepa}rat{}
    Plug 'rhysd/clever-f.vim'                       " repeatable f/t/F/T instead of ;/,
    Plug 'kshenoy/vim-signature'                   " Display marks on gutter
" COMPLETERS
    Plug 'ajh17/VimCompletesMe'                                         " TabContextual
    " Plug 'lifepillar/vim-mucomplete'                                    " Chain completion
    " Plug 'maralla/completor.vim', {'for': ['python', 'c'] }             " Async completion
    " Plug 'ervandew/supertab'
    Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'                 " Snippets
    Plug 'tpope/vim-commentary'                                         " Comment
    Plug 'tpope/vim-surround'                                           " Parenthesis, quotes, tags, etc... as text objects
    Plug 'Raimondi/delimitMate'                                         " Auto close quotes, brackets, parenthesis, etc
    Plug 'davidhalter/jedi-vim', { 'for': 'python' }                    " GoTo def,assignments,etc
" PYTHON
    Plug 'alfredodeza/pytest.vim', { 'for': 'python' }
    Plug 'kalekundert/vim-coiled-snake', { 'for': 'python' }            " python folding
    Plug 'mitsuhiko/vim-jinja'                                          " jinja syntax
" HTML
    Plug 'mattn/emmet-vim', { 'for': 'html' }                           " html snippets
    Plug 'Valloric/MatchTagAlways', { 'for': 'html' }                   " Highlight html/xml tags when between text
" TMUX
    Plug 'jalvesaq/vimcmdline', { 'for': 'python' }
" Testing
    Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)'] }
call plug#end()
" }}}
" VIM OPTIONS ------------------------------------------------------------- {{{
filetype plugin indent on   "required
syntax on                   "syntax highlight and colorscheme
" set nocompatible
set exrc                    "project local .exrc vimconfigs

" ENCODING
set termencoding=utf-8
set encoding=utf-8
" UI - USER INTERFACE
try
    colorscheme monokai
catch
    set background=dark
endtry
set mouse=a                 " enable mouse features
" set relativenumber          " relative number to the cursor line
" set number                  " show linenumbers, puts number after relative(exclude 0)
set cursorline              " highlight current line
set showtabline=1           " Show tabline only when more than one tab exists
set showmatch               " show matching for symbols like () and etc.
set matchtime=2             " Time spent displaying the mathcing symbol.
set visualbell              " Flash the screen instead of beeping on errors"
set t_vb=                   " And then disable even the flashing"
set lazyredraw              " redraw only when we need to.
" set noerrorbells
" STATUS / COMMAND LINE:
set wildmenu                        " Better commandline completion
set wildmode=longest:full,full      " Expand match on first Tab complete
set showcmd                         " Show (partial) command in status line.
set showmode                        " show --MODE--
set laststatus=2                    " Always show a status line
set cmdheight=2                     " Prevent "Press Enter" messages
"stuff to ignore when tab completing
set wildignore+=*.o,*.obj,*~,*.so,*.swp,*~,._*
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
set wildignore+=*.gif,*.jpg,*.png,*.log
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
" Jamesan statsline
" set statusline=   " clear the statusline for when vimrc is reloaded
" set statusline+=%#ErrorMsg#%{&paste?'paste/':''}%*
" set statusline+=[%n]%<                       " buffer number
" set statusline+=%f\                          " file name
" set statusline+=%{fugitive#statusline()}\    
" set statusline+=%h%m%r%w                     " flags
" set statusline+=[%{strlen(&ft)?&ft:'none'},  " filetype
" set statusline+=%{strlen(&fenc)?&fenc:&enc}, " encoding
" set statusline+=%{&fileformat}]              " file format
" set statusline+=%=                           " right align
" set statusline+=[%{synIDattr(synID(line('.'),col('.'),1),'name')}]\  " highlight
" set statusline+=[%c%V]
" set statusline+=[%p%%\ line\ %l\ of\ %L]     " position in buffer
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
set pastetoggle=<F10>               " Use <F10> to toggle paste modes
if has('patch-8.1.1880')
    set completeopt=menuone,noinsert,noselect,popup    " Show even only 1 complete option
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
set wrap  	        " enable wrap mode to see long code lines
set linebreak       " when wrapping, wrap at word boundaries (vs last char)
set breakindent     " preserves the indent level of wrapped lines
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
set autoread                    " file is not modified in vim but changed outside, reload it
set hidden                      " Edit multiple unsaved files at the same time
set autowrite                   " write buffer to file when chnage focus
" set confirm                     " Prompt to save unsaved changes when exiting
" NONAME
" set clipboard=unnamedplus           " enabling system clipboard
" if has('mac')
"     if has("clipboard")
"         set clipboard=unnamed
"     endif
"     if has("unnamedplus")
"         set clipboard=unnamedplus
"     endif
" elseif has("unix")
"     if $TMUX == ''
"         set clipboard=unnamedplus
"     else
"         set clipboard=unnamedplus
"     endif
" endif
set formatoptions=tcq
set history=9999
set diffopt+=context:4,vertical
" }}}
" MAPPINGS ---------------------------------------------------------------- {{{
" -------------- FUNCTION KEYS
nnoremap <F2> :GundoToggle<CR>
nnoremap <F3> :TagbarToggle<CR>
nnoremap <F5> :Dispatch 
" -------------- GENERAL SHIT
" :Silent command that doesnt require to press enter after :!external
command! -nargs=1 Silent execute 'silent !' . <q-args> | execute 'redraw!'
" column scroll-binding on <leader>sb
noremap <silent> <leader>sb :<c-u>let @z=&so<cr>:set so=0 noscb<cr>:bo vs<cr>ljzt:setl scb<cr><c-w>p:setl scb<cr>:let &so=@z<cr>

" Highlighting
nnoremap <silent> <space> :nohlsearch<bar>:echo<cr>
nnoremap <C-Bslash>       :set hls!<bar>:set hls?<CR>
inoremap <C-Bslash>       <Esc>:set hls!<bar>:set hls?<CR>a

" -------------- SHORTCUTS
nmap Q @q
" window
nnoremap <space>w <c-w>
nnoremap <space>w< 5<c-w><
nnoremap <space>w> 5<c-w>>
nnoremap <space>w] 5<c-w>+
nnoremap <space>w[ 5<c-w>-

" Short completion for: Tags,File/Path,dict,line
inoremap <C-]> <C-x><C-]>
inoremap <C-f> <C-x><C-f>
inoremap <C-l> <C-x><C-l>
" Up make recursive search, C-P just do previous
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
" ------------------------- YANK PAST
map Y y$
nnoremap <space>y "+y
vnoremap <space>y "+y
nnoremap <space>p "+p
" Select last pasted text
nnoremap gp '[V']'<Esc>
" unimpaired move last pasted text to up down
vmap <C-y> [e'[V']
vmap <C-e> ]e'[V']
" LEADER KEYS --------------------------------------------------------------
" let mapleader = \" "
" PLUGINS ----------------------------------------------------------------- {{{
" Jedi
let g:jedi#completions_command = "<C-Space>"
let g:jedi#goto_assignments_command = "<Space>pa"
let g:jedi#goto_definitions_command = "<Space>pd"
let g:jedi#usages_command = "<Space>pu"
let g:jedi#rename_command = "<Space>pr"
let g:jedi#documentation_command = "<Space>k"
" }}}
" }}}
" COMMANDS ---------------------------------------------------------------- {{{
" sharing is caring, if osx pipe to pbcopy, elif linux requires(curl, xclip)
" command! -range=% SP <line1>,<line2>w !curl -F 'sprunge=<-' http://sprunge.us | tr -d '\n' | xclip -i -selection clipboard " command! -range=% CL <line1>,<line2>w !curl -F 'clbin=<-' https://clbin.com | tr -d '\n' | xclip -i -selection clipboard
" command! -range=% VP <line1>,<line2>w !curl -F 'text=<-' http://vpaste.net | tr -d '\n' | xclip -i -selection clipboard
" command! -range=% IX <line1>,<line2>w !curl -F 'f:1=<-' ix.io | tr -d '\n' | xclip -i -selection clipboard
" command! -range=% PB <line1>,<line2>w !curl -F 'c=@-' https://ptpb.pw/?u=1 | tr -d '\n' | xclip -i -selection clipboard
command! -range=% TB <line1>,<line2>w !nc termbin.com 9999 | tr -d '\n' | xclip -i -selection clipboard
" }}}
" DENITE ------------------------------------------------------------------ {{{
if &rtp =~ 'denite'
    " CONFIG {{{
    if executable('rg')
        call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])
    endif

    " Change ignore_globs
    call denite#custom#filter('matcher/ignore_globs', 'ignore_globs',
                \ [ '.git/', '.ropeproject/', '__pycache__/',
                \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/',
                \   '*~', '*.o', '*.exe', '*.bak',
                \   '.DS_Store', '*.pyc', '*.sw[po]', '*.class',
                \   '.hg/', '.git/', '.bzr/', '.svn/',
                \   'tags', 'tags-*'])

    " Change matchers.
    call denite#custom#source(
    \ 'file/rec', 'matchers', ['matcher/fuzzy', 'matcher/ignore_globs'])

    " Change default action.
    call denite#custom#kind('command', 'default_action', 'edit')
    " Ripgrep command on grep source
    call denite#custom#var('grep', 'command', ['rg'])
    call denite#custom#var('grep', 'default_opts',
                \ ['-i', '--vimgrep', '--no-heading'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])

    " Add custom menus
    let s:menus = {}
    let s:menus.zsh = {
                \ 'description': 'Edit your import zsh configuration'
                \ }
    let s:menus.zsh.file_candidates = [
                \ ['zshrc', '~/.config/zsh/.zshrc'],
                \ ['zshenv', '~/.zshenv'],
                \ ]
    let s:menus.my_commands = {
                \ 'description': 'Example commands'
                \ }
    let s:menus.my_commands.command_candidates = [
                \ ['Split the window', 'vnew'],
                \ ['Open zsh menu', 'Denite menu:zsh'],
                \ ['Format code', 'FormatCode', 'go,python'],
                \ ]
    call denite#custom#var('menu', 'menus', s:menus)
endif
    " }}}
    " BINDINGS {{{
" fzf {{{
if &rtp =~ 'fzf'
    " nnoremap <leader>f :fzf
    " nnoremap <leader>e :FzfFiles<CR>
    " nnoremap <leader>b :FzfBuffers<CR>
    " nnoremap <leader>l :FzfLines<CR>
    " nnoremap <leader>L :FzfBLines<CR>
    " nnoremap <leader>g :<C-u>call fzf#run({'source': reverse(split(execute('changes'), "\n"))})<CR>
    " nnoremap <leader>j :<C-u>call fzf#run({'source': reverse(split(execute('jumps'), "\n"))})<CR>
    " nnoremap <leader>y :<C-u>call fzf#run({'source': reverse(split(execute('registers'), "\n"))})<CR>
    " nnoremap <leader>m :FzfMarks<CR>
    " nnoremap <leader>t :FzfTags<CR>
    " nnoremap <leader>T :FzfBTags<CR>
    " nnoremap <leader>: :FzfHistory:<CR>
    nnoremap <leader>/ :FzfHistory/<CR>
    nnoremap <leader>u :FzfSnippets<CR>
    inoremap <C-u> <Esc>:FzfSnippets<CR>
    imap <C-u> <plug>(fzf-complete-snippets)
    " nnoremap <leader>h :FzfHelptags<CR>

    " Mapping selecting mappings
    nmap <leader><tab> <plug>(fzf-maps-n)
    xmap <leader><tab> <plug>(fzf-maps-x)
    omap <leader><tab> <plug>(fzf-maps-o)

    " Insert mode completion
    imap <c-f> <plug>(fzf-complete-path)
    imap <c-l> <plug>(fzf-complete-line)
endif
" }}}
if &rtp =~ 'denite'
    if has ('nvim')
        nnoremap <leader>b :<C-u>Denite buffer -split=floating -start-filter=true -prompt=>> -direction=dynamictop<CR>
        nnoremap <leader>e :<C-u>Denite file/rec -split=floating -start-filter=true -prompt=>> -direction=dynamictop<CR>
        nnoremap <leader>y :<C-u>Denite register -split=floating -start-filter=true -prompt=>> -direction=dynamictop<CR>

        nnoremap <leader>l :<C-u>Denite line -split=floating -start-filter=true -prompt=>> -direction=dynamictop<CR>
        nnoremap <leader>m :<C-u>Denite mark -split=floating -start-filter=true -prompt=>> -direction=dynamictop<CR>
        nnoremap <leader>j :<C-u>Denite jump -split=floating -start-filter=true -prompt=>> -direction=dynamictop<CR>
        nnoremap <leader>t :<C-u>Denite tag -split=floating -start-filter=true -prompt=>> -direction=dynamictop<CR>
        nnoremap <leader>g :<C-u>Denite change -split=floating -start-filter=true -prompt=>> -direction=dynamictop<CR>
        nnoremap <leader>r :<C-u>Denite registers -split=floating -start-filter=true -prompt=>> -direction=dynamictop<CR>

        nnoremap <leader>h :<C-u>Denite help -split=floating -start-filter=true -prompt=>> -direction=dynamictop<CR>
        nnoremap <leader>c :<C-u>Denite command_history -split=floating -start-filter=true -prompt=>> -direction=dynamictop<CR>
        nnoremap <leader>c :<C-u>Denite command -split=floating -start-filter=true -prompt=>> -direction=dynamictop<CR>
        nnoremap <leader>s :<C-u>Denite source -split=floating -start-filter=true -prompt=>> -direction=dynamictop<CR>
    else
        nnoremap <leader>b :<C-u>Denite buffer -start-filter=true -prompt=>> -direction=dynamictop<CR>
        nnoremap <leader>e :<C-u>Denite file/rec -start-filter=true -prompt=>> -direction=dynamictop<CR>
        nnoremap <leader>y :<C-u>Denite register -start-filter=true -prompt=>> -direction=dynamictop<CR>

        nnoremap <leader>l :<C-u>Denite line -start-filter=true -prompt=>> -direction=dynamictop<CR>
        nnoremap <leader>m :<C-u>Denite mark -start-filter=true -prompt=>> -direction=dynamictop<CR>
        nnoremap <leader>j :<C-u>Denite jump -start-filter=true -prompt=>> -direction=dynamictop<CR>
        nnoremap <leader>t :<C-u>Denite tag -start-filter=true -prompt=>> -direction=dynamictop<CR>
        nnoremap <leader>g :<C-u>Denite change -start-filter=true -prompt=>> -direction=dynamictop<CR>
        nnoremap <leader>r :<C-u>Denite registers -start-filter=true -prompt=>> -direction=dynamictop<CR>

        nnoremap <leader>h :<C-u>Denite help -start-filter=true -prompt=>> -direction=dynamictop<CR>
        nnoremap <leader>c :<C-u>Denite command_history -start-filter=true -prompt=>> -direction=dynamictop<CR>
        nnoremap <leader>c :<C-u>Denite command -start-filter=true -prompt=>> -direction=dynamictop<CR>
        nnoremap <leader>s :<C-u>Denite source -start-filter=true -prompt=>> -direction=dynamictop<CR>
    endif
endif

    " Define mappings
    autocmd FileType denite 
                \call s:denite_my_settings()
    autocmd FileType denite set wildcharm=<C-z>
    function! s:denite_my_settings() abort
        nnoremap <silent><buffer><expr> <CR>
                    \ denite#do_map('do_action')
        nnoremap <silent><buffer><expr> p
                    \ denite#do_map('do_action', 'preview')
        nnoremap <silent><buffer><expr> q
                    \ denite#do_map('quit')
        nnoremap <silent><buffer><expr> i
                    \ denite#do_map('open_filter_buffer')
        nnoremap <silent><buffer><expr> <Space>
                    \ denite#do_map('toggle_select').'j'

        nnoremap <silent><buffer><expr> <C-v>
                    \ denite#do_map('do_action', 'vsplit')
        nnoremap <silent><buffer><expr> <C-h> 
                    \ denite#do_map('do_action', 'split')
        nnoremap <silent><buffer><expr> <C-t> 
                    \ denite#do_map('do_action', 'tabopen')
        nnoremap <silent><buffer><expr> <Tab>
                    \ denite#do_map('choose_action')
    endfunction

    autocmd FileType denite-filter 
                \call s:denite_filter_my_settings()
    function! s:denite_filter_my_settings() abort
        " Map to quit
        imap <silent><buffer> <C-o> <Plug>(denite_filter_quit)
        imap <silent><buffer> q <Plug>(denite_filter_quit)
        " General mappings
        inoremap <silent><buffer><expr> <CR>
                    \ denite#do_map('do_action', 'default')
        inoremap <silent><buffer><expr> <C-h>
                    \ denite#do_map('do_action', 'splitswitch')
        inoremap <silent><buffer><expr> <C-v>
                    \ denite#do_map('do_action', 'vsplitswitch')
        inoremap <silent><buffer><expr> <C-t>
                    \ denite#do_map('do_action', 'tabswitch')
        inoremap <silent><buffer><expr> <C-v>
                    \ denite#do_map('do_action', 'split')
        " Map to denite main window
        imap <silent><buffer> <Tab>
                    \ <Esc><C-w>p<Tab><C-z>
        inoremap <silent><buffer> <C-j>
                    \ <Esc><C-w>p:call cursor(line('.')+1,0)<CR><C-w>pA
        inoremap <silent><buffer> <C-k>
                    \ <Esc><C-w>p:call cursor(line('.')-1,0)<CR><C-w>pA
    endfunction
    " }}}
" }}}
" FZF --------------------------------------------------------------------- {{{
" This is the default extra key bindings
let g:fzf_command_prefix = 'Fzf'
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }
 
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
command! -bang Colors
  \ call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'}, <bang>0)
" }}}
" GUTENTAGS --------------------------------------------------------------- {{{
let g:gutentags_enabled = 1
let g:gutentags_ctags_executable = 'ctags'
let g:gutentags_tagfile = 'tags'
" let g:gutentags_cache_dir = '~/.tags_cache'
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_new = 0
let g:gutentags_generate_on_write = 1
let g:gutentags_background_update = 1
let g:gutentags_resolve_symlinks = 1
let g:gutentags_define_advanced_commands = 1
let g:gutentags_project_root = []
let g:gutentags_project_root += ['manage.py']
let g:gutentags_project_info = []
call add(g:gutentags_project_info, {'type': 'python', 'file': 'manage.py'})
" }}}
" VIM-SNEAK --------------------------------------------------------------- {{{
let g:sneak#label = 1
let g:sneak#s_next = 1
let g:sneak#label_esc = "<Space>"
" }}}
" SUPERTAB ---------------------------------------------------------------- {{{
" let g:SuperTabDefaultCompletionType = '<C-X><C-O>' " For Omni - if jedi only
let g:SuperTabDefaultCompletionType = '<C-X><C-U>' " For User - Completor-maralla
" let g:SuperTabDefaultCompletionType = '<C-n>' " For youcompleteme/completor
" let g:SuperTabCrMapping = 0
" }}}
" Mu-COMPLETE ------------------------------------------------------------- {{{
let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#trigger_auto_pattern = {}
let g:mucomplete#trigger_auto_pattern.default = '\k\k\K$'
let g:mucomplete#chains = {}
let g:mucomplete#chains.default = ['path', 'user', 'ulti', 'omni', 'c-p']
let g:mucomplete#chains.python = ['path', 'ulti', 'user', 'c-p']
let g:mucomplete#chains.xhtml = ['path', 'ulti']
let g:mucomplete#chains.c = ['path', 'ulti', 'user', 'tags']
let g:mucomplete#chains.vim = []
" }}}
" COMPLETOR.VIM ----------------------------------------------------------- {{{
" Disable default completeopt
let g:completor_set_options = 0
let g:completor_auto_trigger = 1
let g:completor_blacklist = ['tagbar', 'qf', 'netrw', 'vimwiki', 'vim']
let g:completor_min_chars = 1
" }}}
" ULTISNIPS --------------------------------------------------------------- {{{
let g:UltiSnipsEditSplit = "vertical"
let g:UltiSnipsSnippetDirectories = ["UltiSnips"]
" let g:UltiSnipsSnippetDirectories = ["bundle/vim-snippets/UltiSnips"]
let g:UltiSnipsJumpForwardTrigger = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"
let g:UltiSnipsExpandTrigger = "<C-b>"
" let g:UltiSnipsListSnippets = "<C-u>" replaced by fzf one
if has('python3')
    let g:UltiSnipsUsePythonVersion=3
elseif has('python')
    let g:UltiSnipsUsePythonVersion=2
endif

inoremap <silent> <C-j> <C-r>=LoadUltiSnipsAndExpand()<CR>

function! LoadUltiSnipsAndExpand()
    let l:curpos = getcurpos()
    execute plug#load('ultisnips')
    call cursor(l:curpos[1], l:curpos[2])
    call UltiSnips#ExpandSnippet()
    return ""
endfunction
" }}}
" EMMET-VIM --------------------------------------------------------------- {{{
let g:user_emmet_mode='n'    "only enable normal mode functions.
let g:user_emmet_mode='inv'  "enable all functions, which is equal to
let g:user_emmet_mode='a'    "enable all function in all mode.
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
let g:user_emmet_leader_key='<C-Z>'
" }}}
" JEDI-VIM ---------------------------------------------------------------- {{{
let g:jedi#auto_initialization = 1
let g:jedi#auto_vim_configuration = 0
" Let Something else complete
let g:jedi#completions_enabled = 1
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0
let g:jedi#show_call_signatures = 2
let g:jedi#show_call_signatures_delay = 0
let g:jedi#smart_auto_mappings = 1 " auto type form module.name<space> import
let g:jedi#auto_close_doc = 1
let g:jedi#use_tabs_not_buffers = 0  " goto in tabs = 0 for buffers
let g:jedi#use_splits_not_buffers = ""  "goto in splits: top,left,right,bottom
let g:jedi#force_py_version = 3
" }}}
" ALE-LINTER -------------------------------------------------------------- {{{
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save = 1
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
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
" DELIMITMATE --------------------------------------------------------------- {{{
if &rtp =~ 'delimitmate'
    imap <C-j> <Plug>delimitMateS-Tab
    imap <C-k> <Plug>delimitMateJumpMany
endif
" }}}
" DISPATCH --------------------------------------------------------------- {{{
let g:dispatch_no_maps = 1
" }}}
" VIMCMDLINE ------------------------------------------------------------- {{{
" vimcmdline mappings
let cmdline_map_start          = '<LocalLeader>s'
let cmdline_map_send           = '<Space>'
let cmdline_map_send_and_stay  = '<LocalLeader><Space>'
let cmdline_map_source_fun     = '<LocalLeader>sf'
let cmdline_map_send_paragraph = '<LocalLeader>sp'
let cmdline_map_send_block     = '<LocalLeader>sb'
let cmdline_map_quit           = '<LocalLeader>sq'

" vimcmdline options
" let cmdline_vsplit      = 1      " Split the window vertically

" Repl
let cmdline_app           = {}
let cmdline_app['python'] = 'ipython'
" }}}
" FUNCTIONS --------------------------------------------------------------- {{{
" romainl
" Background here: https://gist.github.com/romainl/047aca21e338df7ccf771f96858edb86

function! CCR()
    let cmdline = getcmdline()
    command! -bar Z silent set more|delcommand Z
    if cmdline =~ '\v\C^(ls|files|buffers)'
        " like :ls but prompts for a buffer command
        return "\<CR>:b "
    elseif cmdline =~ '\v\C/(#|nu|num|numb|numbe|number)$'
        " like :g//# but prompts for a command
        return "\<CR>:"
    elseif cmdline =~ '\v\C^(dli|il)'
        " like :dlist or :ilist but prompts for a count for :djump or :ijump
        return "\<CR>:" . cmdline[0] . "j  " . split(cmdline, " ")[1] . "\<S-Left>\<Left>"
    elseif cmdline =~ '\v\C^(cli|lli)'
        " like :clist or :llist but prompts for an error/location number
        return "\<CR>:sil " . repeat(cmdline[0], 2) . "\<Space>"
    elseif cmdline =~ '\C^old'
        " like :oldfiles but prompts for an old file to edit
        set nomore
        return "\<CR>:Z|e #<"
    elseif cmdline =~ '\C^changes'
        " like :changes but prompts for a change to jump to
        set nomore
        return "\<CR>:Z|norm! g;\<S-Left>"
    elseif cmdline =~ '\C^ju'
        " like :jumps but prompts for a position to jump to
        set nomore
        return "\<CR>:Z|norm! \<C-o>\<S-Left>"
    elseif cmdline =~ '\C^marks'
        " like :marks but prompts for a mark to jump to
        return "\<CR>:norm! `"
    elseif cmdline =~ '\C^undol'
        " like :undolist but prompts for a change to undo
        return "\<CR>:u "
    else
        return "\<CR>"
    endif
endfunction

cnoremap <expr> <CR> CCR()

function! Redir(cmd)
	for win in range(1, winnr('$'))
		if getwinvar(win, 'scratch')
			execute win . 'windo close'
		endif
	endfor
	if a:cmd =~ '^!'
		let output = system(matchstr(a:cmd, '^!\zs.*'))
	else
		redir => output
		execute a:cmd
		redir END
	endif
	vnew
	let w:scratch = 1
	setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
	call setline(1, split(output, "\n"))
endfunction

command! -nargs=1 -complete=command Redir silent call Redir(<q-args>)

" Usage:
" 	:Redir hi ............. show the full output of command ':hi' in a scratch window
" 	:Redir !ls -al ........ show the full output of command ':!ls -al' in a scratch window
" }}}
" vim: fo=tcq fdm=marker tw=0
