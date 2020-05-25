" SETTINGS
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal foldlevel=1
setlocal tags=tags,.tags,pytags,.pytags
" Code Completion
" Omni c-x c-o, User c-x c-u
if &rtp =~ 'jedi-vim'
    setlocal completefunc=jedi#completions
    setlocal omnifunc=python3complete#Complete
    nnoremap <silent> <buffer> gd :call jedi#usages()<cr>
    nnoremap <silent> <buffer> gr :call jedi#go_to_definition()<cr>
endif
setlocal makeprg=flake8\ %
setlocal formatprg=black\ --quiet\ -\ 2>\ /dev/null

" INDENT VARS
" let g:pyindent_disable_parentheses_indenting = 1
let g:pyindent_open_paren = ''
let g:pyindent_nested_paren = ''
" Line continuation without indentation better to use tab than backspace
let g:pyindent_continue = ''

" PLUGIN VARS
let b:dispatch = 'python %'
let b:vcm_tab_complete = "user"

" MAPPINGS
" Method like objects
nmap dam :call PythonMethodTextObject('d', 'a')<cr>
nmap dim :call PythonMethodTextObject('d', 'i')<cr>
nmap cam :call PythonMethodTextObject('c', 'a')<cr>
nmap cim :call PythonMethodTextObject('c', 'i')<cr>

" nnoremap <buffer> <F5> :silent make \| redraw!<cr>
nnoremap <buffer> <F5> :Make<cr>
" nnoremap <buffer> <F6> gggqG2<c-o>
nnoremap <buffer> <F6> :Format<cr>

nnoremap <buffer> <space>pb o__import__('ipdb').set_trace()<Esc>
nnoremap <buffer> <space>pB O__import__('ipdb').set_trace()<Esc>
inoremap <buffer> <c-k> <c-o>:call PyHelper()<CR>
" autocmd FileType python nmap <buffer>K <Plug>(devdocs-under-cursor-all)

" COMMANDS
command! Format :call system('isort --quiet '.expand("%").'; black --quiet '.expand("%")) | :e %
command! Pytags :call system('ctags --totals -R --languages=python -f pytags $(python -c """import os, sys; print(" ".join("{}".format(d) for d in sys.path if os.path.isdir(d)))""")')

" FUNCTIONS
function! PyHelper()
    " This function is meant to be run in insert mode
    if bufwinnr('__doc__') > 0
        let buffer_number = bufnr(bufname('__doc__'))
        echom "Deleting __doc__ buffer =>" . buffer_number
        execute ":bd" . buffer_number
    else
        echom "Opening jedi docs"
        let saved_cursor = getcurpos()
        execute "normal \<Esc>F(\<space>pk\<Esc>\<c-w>j"
        execute "call setpos('.', saved_cursor)"
    endif
endfunction

function! PythonMethodTextObject(operation, object)
    let line = getline(".")
    echo "this is the line:"
    echo line
    echo "\n"
    if line =~ '^\s*\<\(def\|class\)\>'
        echom "this"
        if a:operation == 'c' && a:object == 'i'
            normal V]Mc
        elseif a:operation == 'c' && a:object == 'a'
            normal kV]Mc
        elseif a:operation == 'd' && a:object == 'i'
            normal V]Md
        elseif a:operation == 'd' && a:object == 'a'
            normal kV]Md
        endif
    else
        echom "that"
        if a:operation == 'c' && a:object == 'i'
            normal [mV]Mc
        elseif a:operation == 'c' && a:object == 'a'
            normal [mkV]Mc
        elseif a:operation == 'd' && a:object == 'i'
            normal [mV]Md
        elseif a:operation == 'd' && a:object == 'a'
            normal [mkV]Md
        endif
    endif
endfunction
