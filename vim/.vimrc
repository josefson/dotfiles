" VIM.PLUG ---------------------------------------------------------------- {{{
call plug#begin('~/.vim/bundle')
source ~/dotfiles/vim/.vimrc_trash
" UTILS
    Plug 'Shougo/unite.vim' | Plug 'Shougo/neomru.vim' | Plug 'osyo-manga/unite-quickfix' | Plug 'thinca/vim-unite-history' " | Plug 'Shougo/neoyank.vim'
    Plug 'paradigm/SkyBison'                        " 'Better/diff' vim cmd line
    Plug 'tpope/vim-unimpaired'                     " Default pair keymappings
    Plug 'tpope/vim-repeat'                         " Support repeat command(.) for plugin actions
    Plug 'tpope/vim-obsession'                      " Persistent session manager
    " Plug 'tpope/vim-eunuch'                         " :sudo[edits|writes],Locate,Find,Move,Chmod,Remove,Rename,Mkdir,Unlink
    Plug 'mattn/webapi-vim' | Plug 'mattn/gist-vim' " Gist and dependency
    " Plug 'godlygeek/tabular'                        " :Tab /regex
    Plug 'tommcdo/vim-lion'                         " gl|L[ip|i{] Alight left|right
" WRITER'S TOOLBOX
    " Plug 'chrisbra/NrrwRgn'                         " ,nr|:NR Narrow region
" IDE
    Plug 'tpope/vim-dispatch'                       " Async shit
    Plug 'sjl/gundo.vim'                            " UndoTree
    Plug 'majutsushi/tagbar'                        " Lateral tagbar
    Plug 'w0rp/ale'                                 " Async lint
    Plug 'rhysd/devdocs.vim'                        " Documentation Plugin
    " Plug 'ludovicchabant/vim-gutentags'             " Auto Tag creation
    " Plug 'scrooloose/syntastic'                     " Linter/checker
" GIT
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'                   " Only for git
    Plug 'gregsexton/gitv'                          " Gitk alternative for vim
" MOVEMENT/SEARCH&REPLACE
    Plug 'justinmk/vim-sneak'                       " s[xx] vert/horiz moving
    Plug 'terryma/vim-multiple-cursors'
    " Plug 'tpope/vim-abolish'                        " :Abolish {despa,sepe}rat{e,es,ed,ing,ely,ion,ions,or}  {despe,sepa}rat{}
" COMPLETERS
    Plug 'ajh17/VimCompletesMe'                                         " TabContextual
    " Plug 'ervandew/supertab'
    " Plug 'lifepillar/vim-mucomplete'                                    " Chain completion
    " Plug 'maralla/completor.vim', {'for': ['python', 'c'] }             " Async completion
    " Plug 'Valloric/YouCompleteMe', {'do': './install.py --clang'}
    " Plug 'roxma/nvim-completion-manager' | Plug 'roxma/vim-hug-neovim-rpc'
    Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
    Plug 'tpope/vim-commentary'                                         " Comment
    Plug 'tpope/vim-surround'                                           " Parenthesis, quotes, tags, etc...
    Plug 'Raimondi/delimitMate'                                         " Auto close quotes, brackets, parenthesis, etc
    Plug 'davidhalter/jedi-vim', { 'for': 'python' }
" PYTHON
    " Plug 'alfredodeza/pytest.vim', { 'for': 'python' }
    " Plug 'jmcantrell/vim-virtualenv', { 'on': 'VirtualEnvList', 'for': 'python' }
    " Plug 'tmhedberg/SimpylFold'                                         " Better python folding
" HTML
    " Plug 'Valloric/MatchTagAlways', { 'for': 'xhtml' }                  "Highlight html/xml tags when between text
    " Plug 'rstacruz/sparkup'                                             " Html magic expansion/snippets
" TMUX
    Plug 'jpalardy/vim-slime'
call plug#end()
" }}}
" VIM OPTIONS ------------------------------------------------------------- {{{
filetype plugin indent on   "required
syntax on                   "syntax highlight and colorscheme
set nocompatible
set exrc                    "project local .exrc vimconfigs
"set t_co=16                "ubuntu compatibility

" ENCODING
set termencoding=utf-8
set encoding=utf-8
" UI - USER INTERFACE
try
    colorscheme Monokai
    " set background=dark
catch
endtry
set title
set mouse=a                 " enable mouse features
set relativenumber          " relative number to the cursor line
set number                  " show linenumbers, puts number after relative(exclude 0)
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
set completeopt=menuone,noinsert,noselect    " Show even only 1 complete option
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
set showbreak=↪     " illustrate wrapped lines
set wrap            " wrapping with breakindent is tolerable
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
" set clipboard=unnamed           " enabling system clipboard
if has('mac')
    if has("clipboard")
        set clipboard+=unnamed
    endif
    if has("unnamedplus")
        set clipboard+=unnamedplus
    endif
endif
" elseif has("unix")
"     if $TMUX == ''
"         set clipboard+=unnamed
"     endif
" endif
set formatoptions=tcq
set history=9999
" }}}
" MAPPINGS ---------------------------------------------------------------- {{{
":Silent command that doesnt require to press enter after :!external
command! -nargs=1 Silent execute 'silent !' . <q-args> | execute 'redraw!'
" GENERAL {{{
" let mapleader = ","      " remaping leader to comma
"press space to turn off highlighting and clear any message already displayed.
nnoremap <silent> <space> :nohlsearch<bar>:echo<cr>

" Toggle search highlighting
nnoremap <C-Bslash>       :set hls!<bar>:set hls?<CR>
inoremap <C-Bslash>       <Esc>:set hls!<bar>:set hls?<CR>a

" column scroll-binding on <leader>sb
noremap <silent> <leader>sb :<c-u>let @z=&so<cr>:set so=0 noscb<cr>:bo vs<cr>ljzt:setl scb<cr><c-w>p:setl scb<cr>:let &so=@z<cr>
" }}}
" INSERT ------------------------------------------------------------------ {{{
" Short completion for: Tags,File/Path,dict,line
inoremap <C-]> <C-x><C-]>
inoremap <C-f> <C-x><C-f>
inoremap <C-d> <C-x><C-d>
inoremap <C-l> <C-x><C-l>
" }}}
" COMMAND {{{
" Up make recursive search, C-P just do previous
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
" }}}
" NORMAL {{{
" clipboard copy paste
nnoremap y "+y
nnoremap <space>yy V"+y
noremap <space>p "+p
nnoremap <space>P "+P
nnoremap <space>d "_d
" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy
map Y y$
" qq to record, Q to replay
nmap Q @q
" }}}
" FUNCTION KEYS
nnoremap <F2> :GundoToggle<CR>
nnoremap <F5> :Dispatch 
" LEADER KEYS
" nnoremap <leader>pk :Silent dasht <C-R><C-W> <C-R>=&filetype<CR> using docsio for now
nnoremap <space>s :<C-u>call SkyBison("")<CR>
nnoremap <space>e :<C-u>call SkyBison('e ')<CR>
nnoremap <space>b 2:<C-u>call SkyBison('b ')<CR>
nnoremap <leader>h 2:<C-u>call SkyBison('h ')<CR>
nnoremap <leader>t 2:<C-u>call SkyBison('tag ')<CR>
nnoremap <leader>tj 2:<C-u>call SkyBison('tj ')<CR>
nnoremap <leader>e :<C-u>Unite -start-insert -buffer-name=Recursive_Files file_rec<CR>
nnoremap <leader>b :<C-u>Unite -start-insert -buffer-name=Buffers buffer<CR>
nnoremap <leader>p :<C-u>Unite -start-insert -buffer-name=MRU_Files file_mru<CR>
nnoremap <leader>u :<C-u>Unite -start-insert -buffer-name=UltiSnips ultisnips<CR>
nnoremap <leader>y :<C-u>Unite -start-insert -buffer-name=Registers register<CR>
nnoremap <leader>? :<C-u>Unite -start-insert -buffer-name=Unite_Sources source<CR>
nnoremap <leader>j :<C-u>Unite -start-insert -buffer-name=Jumplist jump<CR>
nnoremap <leader>s :<C-u>Unite -start-insert  -buffer-name=Search  history/search<CR>
nnoremap <leader>c :<C-u>Unite -start-insert  -buffer-name=Commands_List history/command<CR>
let g:jedi#completions_command = "<C-Space>"
let g:jedi#goto_assignments_command = "<leader>pa"
let g:jedi#goto_definitions_command = "<leader>pd"
let g:jedi#usages_command = "<leader>pu"
let g:jedi#rename_command = "<leader>pr"
let g:jedi#documentation_command = "<leader>k"
nnoremap <leader>zr :zR<CR>
nnoremap <leader>sc :SyntasticCheck<CR>
nnoremap <leader>st :SyntasticToggleMode<CR>
nnoremap <leader>us :<C-U>call UltiSnips#ListSnippets()<CR> 
" inoremap <C-?> <C-o>:<C-U>call UltiSnips#ListSnippets()<CR> 
nnoremap <leader>uf :UltiSnipsAddFiletypes 
" }}}
" AUTOCMD/FT -------------------------------------------------------------- {{{
" " PYTHON {{{
if has('python3')
    autocmd FileType python setlocal omnifunc=python3complete#Complete
    autocmd FileType python setlocal makeprg=python3\ %
    let g:UltiSnipsUsePythonVersion=3
endif
" if has('python')
"     autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"     autocmd FileType python setlocal makeprg=python\ %
"     let g:UltiSnipsUsePythonVersion=2
" endif
autocmd FileType python setlocal nofoldenable foldmethod=expr foldlevel=2
autocmd FileType python setlocal completefunc=jedi#completions
" autocmd FileType python setlocal makeprg=python\ %
autocmd FileType python setlocal tags=tags,./tags,pytags
autocmd FileType python nmap <buffer>K <Plug>(devdocs-under-cursor)
autocmd FileType python let b:dispatch = 'python %'
autocmd FileType python let b:vcm_tab_complete = "user"
" }}}
" }}}
" COLORS FOR TABS LINES AND AUTOPOPOUT MENU  ------------------------------ {{{
" let g:solarized_termcolors=257
" hi cursor ctermfg=234 ctermbg=202 cterm=none guifg=#1e1e1e guibg=#fc5604 gui=none
" hi visual ctermfg=none ctermbg=59 cterm=none guifg=none guibg=#373b41 gui=none
" hi cursorline ctermfg=none ctermbg=236 cterm=none guifg=none guibg=#2f2f2f gui=none
" hi cursorcolumn ctermfg=none ctermbg=236 cterm=none guifg=none guibg=#2f2f2f gui=none
" hi colorcolumn ctermfg=none ctermbg=236 cterm=none guifg=none guibg=#2f2f2f gui=none
" hi linenr ctermfg=248 ctermbg=236 cterm=none guifg=#727372 guibg=#2f2f2f gui=none
" hi title       term=none cterm=none ctermfg=251  ctermbg=none gui=none guifg=#c6c6c6 guibg=#000000
" hi tabline     term=none cterm=none ctermfg=248   ctermbg=237  gui=none guifg=#000000 guibg=#3a3a3a
" hi tablinefill term=none cterm=none ctermfg=248   ctermbg=237  gui=none guifg=#000000 guibg=#3a3a3a
" hi tablinesel  term=none cterm=none ctermfg=231  ctermbg=237  gui=none guifg=#ffffff guibg=#3a3a3a
" hi pmenu	term=none cterm=none ctermfg=231  ctermbg=237  gui=none guifg=#ffffff guibg=#3a3a3a
" hi pmenusel 	term=none cterm=none ctermfg=234  ctermbg=244  gui=none guifg=#ffffff guibg=#3a3a3a
" }}}
" SKYBISON ---------------------------------------------------------------- {{{
let g:skybison_fuzz = 1
" }}}
" UNITE ------------------------------------------------------------------- {{{
call unite#custom#profile('default', 'context', {
\   'no_empty': '1',
\   'start_insert': 1
\ })
call unite#filters#matcher_default#use(['matcher_fuzzy'])

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
    " Play nice with supertab
    let b:SuperTabDisabled=1
    " Enable navigation with control-j and control-k in insert mode
    imap <buffer> <C-j>   <Plug>(unite_select_next_line)
    imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
    " Normal mappings
    nmap <silent><buffer><expr> Enter unite#do_action('switch')
    nmap <silent><buffer><expr> <C-t> unite#do_action('tabswitch')
    nmap <silent><buffer><expr> <C-h> unite#do_action('splitswitch')
    nmap <silent><buffer><expr> <C-v> unite#do_action('vsplitswitch')
    " Insert mappings
    imap <silent><buffer><expr> Enter unite#do_action('switch')
    imap <silent><buffer><expr> <C-t> unite#do_action('tabswitch')
    imap <silent><buffer><expr> <C-h> unite#do_action('splitswitch')
    imap <silent><buffer><expr> <C-v> unite#do_action('vsplitswitch')
endfunction
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
" Use f instead of s
" nmap f <Plug>Sneak_s
" nmap F <Plug>Sneak_S
" xmap f <Plug>Sneak_s
" xmap F <Plug>Sneak_S
" omap f <Plug>Sneak_s
" omap F <Plug>Sneak_S

" Allow f/t/F/T with one character
" nmap f <Plug>Sneak_f
" nmap F <Plug>Sneak_F
" xmap f <Plug>Sneak_f
" xmap F <Plug>Sneak_F
" omap f <Plug>Sneak_f
" omap F <Plug>Sneak_F

" nmap t <Plug>Sneak_t
" nmap T <Plug>Sneak_T
" xmap t <Plug>Sneak_t
" xmap T <Plug>Sneak_T
" omap t <Plug>Sneak_t
" omap T <Plug>Sneak_T
" }}}
" MULTIPLE CURSORS -------------------------------------------------------- {{{
let g:multi_cursor_next_key='<C-n>'  " next
let g:multi_cursor_prev_key='<C-p>'  " prev
let g:multi_cursor_skip_key='<C-x>'  " jump/unmark
let g:multi_cursor_quit_key='<Esc>'  " cancel
" }}}
" SUPERTAB ---------------------------------------------------------------- {{{
" let g:SuperTabDefaultCompletionType = '<C-X><C-O>' " For Omni
let g:SuperTabDefaultCompletionType = '<C-X><C-U>' " For User
" let g:SuperTabDefaultCompletionType = '<C-n>' " For youcompleteme
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
let g:mucomplete#chains.unite = []
let g:mucomplete#chains.vim = []
" }}}
" COMPLETOR.VIM ----------------------------------------------------------- {{{
let g:completor_blacklist = ['tagbar', 'qf', 'netrw', 'unite', 'vimwiki', 'vim']
let g:completor_min_chars = 2
let g:completor_python_binary = '/usr/local/bin/python3'
" }}}
" YOUCOMPLETEME YCM ------------------------------------------------------- {{{
let g:ycm_key_invoke_completion = '<C-Space>'
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_auto_trigger = 1
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_use_ultisnips_completer = 1
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
" let g:ycm_seed_identifiers_with_syntax = 1
" }}}
" ULTISNIPS --------------------------------------------------------------- {{{
let g:UltiSnipsEditSplit = "vertical"
let g:UltiSnipsSnippetDirectories = ["UltiSnips"]
" let g:UltiSnipsSnippetDirectories = ["bundle/vim-snippets/UltiSnips"]
let g:UltiSnipsExpandTrigger = "<C-b>"
let g:UltiSnipsJumpForwardTrigger = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"
" }}}
" JEDI-VIM ---------------------------------------------------------------- {{{
" let g:jedi#force_py_version = 3       " Let jedi decide based on $(python) 
let g:jedi#auto_initialization = 1
let g:jedi#auto_vim_configuration = 0
" Let Something else complete
let g:jedi#completions_enabled = 1
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0
let g:jedi#show_call_signatures = 1
let g:jedi#show_call_signatures_delay = 0
let g:jedi#auto_close_doc = 1
let g:jedi#use_tabs_not_buffers = 0  " goto in tabs = 0 for buffers
let g:jedi#use_splits_not_buffers = ""  "goto in splits: top,left,right,bottom
let g:jedi#force_py_version = 3
" }}}
" VIRTUALENV -------------------------------------------------------------- {{{
let g:virtualenv_auto_activate = 1
let g:virtualenv_directory = '~/virtualenvs/'
" }}}
" SYNTASTIC --------------------------------------------------------------- {{{
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_mode_map = {
"         \ "mode": "passive",
"         \ "active_filetypes": [""],
"         \ "passive_filetypes": ["python"] }
" let g:syntastic_auto_jump = 2
" let g:syntastic_check_on_open = 0
" let g:syntastic_check_on_wq = 0
" let g:syntastic_aggregate_errors = 1
" let g:syntastic_id_checkers = 1
" let g:syntastic_echo_current_error = 1
" let g:syntastic_enable_signs = 1
" let g:syntastic_error_symbol = '✗'
" let g:syntastic_style_error_symbol = '>>'
" let g:syntastic_warning_symbol = '⚠'
" let g:syntastic_style_warning_symbol = 'S>'
" let g:syntastic_enable_highlighting = 1
" let g:syntastic_always_populate_loc_list = 1
" "0 no open, 1 auto, 2 no close "
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_loc_list_heigh = 5
" "dismiss warnings"
" let g:syntastic_quiet_messages = {'level': 'warnings', 'type': 'style'}
" let g:syntastic_python_checkers = ['python', 'flake8', 'pylint']
" let g:syntastic_debug = 3
" " }}}
" ALE-LINTER -------------------------------------------------------------- {{{
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save = 1
let g:ale_set_loclist = 1
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_linters = {
\   'python': ['flake8', 'pylint'],
\}
let g:ale_virtualenv_dir_names = ['.env', 'env', 've-py3', 've', 'virtualenv', 'virtualenvs']
" let g:ale_python_pylint_executable = '/usr/local/bin/pylint'
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
let g:gist_post_anonymous = 1
"}}}
" VIM-SLIME --------------------------------------------------------------- {{{
let g:slime_target = "tmux"
let g:slime_python_ipython = 1
" }}}
" KEYBINDS ---------------------------------------------------------------{{{
" <F2> :GundoToogle<CR>
" <F3> :Dispatch
" UNIMPAIRED --------------------------------------------------------------
" [a;]a;[A;]A             Arglist-> :previous,:next,:first,:last
"     b,c,l,t             :[b|c|l|t][previous|next|first|last]
"     b-buffers; c-quickfix-list; l-location-list; t-tags-list
" [<space>;]<space>       Add [count] blank lines above|bellow cursor
" [e;]e                   Exchange cursor line with [count] lines above|bellow
" [ox; ]ox                where x is charactere option
"         b background        h hlsearch      i ignorecase
"         c cursorline        u cursorcolumn  x cursor(column+line)
"         n number            r relative-n    
"         w wrap              s spell         v virtualedit
" yo; yO                  Invole o;O with paste active.
" LION -------------------------------------------------------------------
" g[l|L]{motion}x       Tabularize text adding spaces left|right of x
" ex: glip=, gLi{=, gl4j", etc
" MULTIPLE_CURSOR --------------------------------------------------------
" <c-n|p|x>,<Esc>       next,prev,skip,cancel
" ULTISNIPTS -------------------------------------------------------------
" <c-b|j|k>             expand,forward,backward
" SKYBISON ---------------------------------------------------------------
" <space>s              General SkyBison
" <space>e              :e
" <space>b              :b
" <leader>h             :h
" <leader>t             :tag
" <leader>tj            :tj tagjump
" UNITE ------------------------------------------------------------------
" <leader>e             :e recursive files
" <leader>b             :b
" <leader>p             Ctrl-P MRU(Most Recently Used)
" <leader>u             Ultisnips
" <leader>y             yank-history
" <leader>?             list   unite sources
" <leader>j             JumpList
" <leader>s             search history
" <leader>c             command history
" <leader>sc            :SyntasticCheck
" <leader>st            :SyntasticToogleMode
" <leader>us            List Ultisnippets
" <leader>uf            :UltisnipsaddFiletypes
" PYTHON JEDI ------------------------------------------------------------
" <K>                   Documentation
" <C-Space>             Completion
" <leader>pa            assignments
" <leader>pd            definition
" <leader>pu            usage
" <leader>pr            rename
" VIM-NOTES --------------------------------------------------------------
" @         automatically triggers tag completion
" '         becomes ‘ or ’ depending on where you type it
" "         becomes “ or ” (same goes for these)
" --        becomes —
" ->        becomes →
" <-        becomes ←
" *,-,+     becomes . 
" ***       cebomes horizontal ruler
" tab, shift-tab          indent|deindent list items
" alt-right,alt-left      indent|deindent list items
" \en executes :NoteFromSelectedText
" \sn executes :SplitNoteFromSelectedText
" \tn executes :TabNoteFromSelectedText
" }}}
" " vim: fo=tcq fdm=marker tw=0
