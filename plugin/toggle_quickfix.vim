if get(g:, 'loaded_vim_toggle_quickfix', 0)
  finish
endif

" Toggle quickfix / location list {
function! s:ToggleQuickfix()
    if exists('s:quickfix_bufnr')
        silent! cclose
    else
        silent! copen
        wincmd J
    endif
endfunction

function! s:ToggleLocationList()
    if exists('s:quickfix_bufnr')
        silent! lclose
    else
        silent! lopen
    endif
endfunction

function! s:SetQuickfixBufnrOnBufWinEnter()
    let s:quickfix_bufnr = bufnr('$')
endfunction

function! s:CheckQuickfixBufnrOnBufWinLeave()
    if exists("s:quickfix_bufnr") && s:quickfix_bufnr == expand('<abuf>')
        unlet s:quickfix_bufnr
    endif
endfunction

augroup vim-toogle-quickfix
    autocmd!
    autocmd BufWinEnter quickfix call <SID>SetQuickfixBufnrOnBufWinEnter()
    autocmd BufWinLeave *        call <SID>CheckQuickfixBufnrOnBufWinLeave()
augroup END

nnoremap <silent> <Leader>q :call <SID>ToggleQuickfix()<CR>
nnoremap <silent> <Leader>l :call <SID>ToggleLocationList()<CR>
" }

let g:loaded_vim_toggle_quickfix = 1
