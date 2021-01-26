" vim-kickfix zebra colors
hi qfZebra1 ctermbg=black ctermfg=yellow
hi qfZebra2 ctermbg=black ctermfg=red
hi qfFileName1 ctermbg=darkgray ctermfg=black
hi qfFileName2 ctermbg=gray ctermfg=black

" Navigate to next/previous file
nmap <buffer> <c-p> <Plug>(qf_previous_file)
nmap <buffer> <c-n> <Plug>(qf_next_file)
" Go to older/newer quickfix list
nmap <buffer> <c-h>  <Plug>(qf_older)
nmap <buffer> <c-l> <Plug>(qf_newer)
nmap <buffer> <left> :colder<CR>
nmap <buffer> <right> :cnewer<CR>
" Keep Reject mappings
nmap <buffer> dd 0:Reject<cr>
nmap <buffer> yy 0:Keep<cr>
nmap <buffer> <c-k> :Keep 
nmap <buffer> <c-j> :Reject 
nmap <buffer> u :Restore<cr>

" Manage list mappings
nmap <buffer> <space>sl :SaveList
nmap <buffer> <space>sa :SaveListAdd
nmap <buffer> <space>e :LoadList <tab>
nmap <buffer> <space>la :LoadListAdd <tab>
nmap <buffer> <space>ll :ListLists
nmap <buffer> <space>R :RemoveList <tab>

" Do mappings
nmap <buffer> <space>dl :Doline
nmap <buffer> <space>df :Dofile
