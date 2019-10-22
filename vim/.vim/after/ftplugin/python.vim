setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4

setlocal makeprg=python\ %
setlocal completefunc=jedi#completions
setlocal tags=tags,./tags,pytags
setlocal nofoldenable

" Mappings
autocmd FileType python nmap <buffer>K <Plug>(devdocs-under-cursor-all)
" Plugin vars
autocmd FileType python let b:dispatch = 'python %'
autocmd FileType python let b:vcm_tab_complete = "user"
