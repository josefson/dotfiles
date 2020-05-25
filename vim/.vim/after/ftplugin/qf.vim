nmap <buffer> dd 0:Reject<cr>
nmap <buffer> yy 0:Keep<cr>
nmap <buffer> u :Restore<cr>

nmap <buffer> <space>k :Keep 
nmap <buffer> <space>j :Reject 
nmap <buffer> <space>r :Restore<cr>

nmap <buffer> <space>dl :Doline
nmap <buffer> <space>df :Dofile

nmap <buffer> <space>sl :SaveList
nmap <buffer> <space>sa :SaveListAdd
nmap <buffer> <space>e :LoadList <tab>
nmap <buffer> <space>la :LoadListAdd <tab>
nmap <buffer> <space>ll :ListLists
nmap <buffer> <space>R :RemoveList <tab>

nmap <buffer> <c-k> <Plug>(qf_previous_file)
nmap <buffer> <c-j> <Plug>(qf_next_file)

nmap <buffer> <c-l>  <Plug>(qf_older)
nmap <buffer> <c-h> <Plug>(qf_newer)
