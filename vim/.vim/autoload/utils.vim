" See http://stackoverflow.com/questions/4064651/what-is-the-best-way-to-do-smooth-scrolling-in-vim 
function! utils#SmoothScroll(up)
    execute "normal " . (a:up ? "\<c-y>" : "\<c-e>")
    redraw
    for l:count in range(3, &scroll, 2)
        sleep 10m
        execute "normal " . (a:up ? "\<c-y>" : "\<c-e>")
        redraw
    endfor
endfunction

function utils#WindowZoomToggle() abort
    if winnr('$') == 1 | return | endif
    if exists('t:zoom_restore') && win_getid() == t:zoom_restore.winid
        exe get(t:zoom_restore, 'cmd', '')
        unlet t:zoom_restore
    else
        let t:zoom_restore = {'cmd': winrestcmd(), 'winid': win_getid()}
        wincmd |
        wincmd _
    endif
endfunction

function! utils#FzfArgadd()
    " Clear argument list
    execute "%argdelete"
    " Run fzf with preview and select files.
    " Run argadd command passing seleted files as argument.
    call fzf#run(fzf#wrap({'sink': 'argadd', 'options': '--multi' }))
    " call fzf#run({'source': reverse(split(execute('registers'), "\n"))})
endfunction

function! utils#FzfRipgrep(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

function! utils#LoadUltiSnipsAndExpand()
    let l:curpos = getcurpos()
    execute plug#load('ultisnips')
    call cursor(l:curpos[1], l:curpos[2])
    call UltiSnips#ExpandSnippet()
    return ""
endfunction
