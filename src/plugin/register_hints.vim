function! Vimrc_Register_hints(prefix, saffix, cmd) abort
  echo execute(a:cmd)

  return a:prefix . nr2char(getchar()) . a:saffix
endfunction

" nnoremap <expr> <LocalLeader>rm  Vimrc_Register_hints('m', 'marks')
nnoremap <expr> <LocalLeader>r`  Vimrc_Register_hints('`', '', 'marks')
nnoremap <expr> <LocalLeader>ry  Vimrc_Register_hints('"', 'y', 'registers')
nnoremap <expr> <LocalLeader>rd  Vimrc_Register_hints('"', 'd', 'registers')
nnoremap <expr> <LocalLeader>rq  Vimrc_Register_hints('q', '', 'registers')
nnoremap <expr> <LocalLeader>r@  Vimrc_Register_hints('@', '', 'registers')

