" fix tabulation. enable long lines highlighting

augroup python
    au BufNewFile,BufRead *.py,*.py_tmpl set filetype=python
    au BufNewFile,BufRead *.py,*.py_tmpl setlocal fileformat=unix
    au BufNewFile,BufRead *.py,*.py_tmpl setlocal tabstop=4
    au BufNewFile,BufRead *.py,*.py_tmpl setlocal shiftwidth=4
    au BufNewFile,BufRead *.py,*.py_tmpl setlocal shiftwidth=4
    au BufNewFile,BufRead *.py,*.py_tmpl call PythonBinding()
    au BufWinEnter *.py,*.py_tmpl call MatchLongLines()
    au BufWinLeave *.py,*.py_tmpl call clearmatches()
augroup END

function! PythonBinding()
    imap <buffer> xxx import pdb;pdb.set_trace()
    imap <buffer> ixx import ipdb;ipdb.set_trace()
endfunction

function! MatchLongLines()
    if exists('w:long_line_match')
        silent! call matchdelete(w:long_line_match)
        unlet w:long_line_match
    elseif &textwidth > 0
        let w:long_line_match = matchadd('ErrorMsg', '\%>'.&tw.'v.\+', -1)
    else
        let w:long_line_match = matchadd('ErrorMsg', '\%>80v.\+', -1)
    endif
endfunction
nnoremap <silent> <leader>l :call MatchLongLines()<CR>
