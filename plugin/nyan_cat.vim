function! s:NyanCat()
    let nyan_columns = &columns - 12 " subtract 12 to account for showcmd
    let nyan_cat = '~=[^,_,^]:3'
    for x in range(nyan_columns - strlen(nyan_cat))
        let nyan_cat = (x % 2 ? '_' : '-') . nyan_cat
    endfor
    for _ in range(nyan_columns)
        let nyan_cat = ' ' . nyan_cat
    endfor
    for x in range(strlen(nyan_cat))
        redraw
        if x < nyan_columns
            echo nyan_cat[-(x + 1):-1]
        else
            echo nyan_cat[-(x + 1):-(x - nyan_columns + 2)]
        endif
        sleep 40ms
    endfor
endfunction
command! NyanCat call s:NyanCat()

function! s:ShowNyanCat()
    if !exists('s:nyan_columns') || (s:nyan_columns != (&columns - 12))
        let s:nyan_columns = &columns - 12 " subtract 12 to account for showcmd
        let s:nyan_cat = '~=[^,_,^]:3'
        for x in range(s:nyan_columns - strlen(s:nyan_cat))
            let s:nyan_cat = (x % 2 ? '_' : '-') . s:nyan_cat
        endfor
        for _ in range(s:nyan_columns)
            let s:nyan_cat = ' ' . s:nyan_cat
        endfor
        let s:nyan_range = []
    endif
    if empty(s:nyan_range)
        let s:nyan_range = range(strlen(s:nyan_cat))
    endif
    let x = remove(s:nyan_range, 0)
    if x < s:nyan_columns
        echo s:nyan_cat[-(x + 1):-1]
    else
        echo s:nyan_cat[-(x + 1):-(x - s:nyan_columns + 2)]
    endif
    call feedkeys("z\<Esc>", 'n')
endfunction

function! s:DisableNyanCat()
    augroup show_nyan_cat
        autocmd!
    augroup END
    unlet! s:nyan_columns s:nyan_cat s:nyan_range
    let &updatetime = s:saveupdatetime
endfunction
command! DisableNyanCat call s:DisableNyanCat()

function! s:EnableNyanCat()
    let s:saveupdatetime = &updatetime
    set updatetime=40
    augroup show_nyan_cat
        autocmd!
        autocmd CursorHold * call s:ShowNyanCat()
    augroup END
endfunction
command! EnableNyanCat call s:EnableNyanCat()
