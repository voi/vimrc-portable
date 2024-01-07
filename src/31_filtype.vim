augroup vimrc_autocmd_filetype
  autocmd!

  if has('win32')
    autocmd BufWritePre *.c,*.cpp,*.h,*.hpp,*.def,*.bat,*.ini,*.env,*.js,*.vbs,*.ps1 setl fenc=cp932 ff=dos
    autocmd BufNewFile,BufRead *.vcproj,*.sln,*.xaml setf xml
  endif

  autocmd FileType help nnoremap <buffer> q :pclose<CR><C-w>c

  " comment
  autocmd FileType * let &commentstring = substitute(&commentstring, '%s', ' %s ', '')

  " complete
  autocmd FileType * if &l:omnifunc == '' | setl omnifunc=syntaxcomplete#Complete | endif
  autocmd FileType c,cpp setl omnifunc=syntaxcomplete#Complete

  " options
  autocmd FileType c,cpp,cs,java,javascript setl cindent cinoptions=:1s,l1,t0,(0,)0,W1s,u0,+0,g0
  autocmd FileType html,xhtml,xml,javascript,vim setl tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd FileType html,xhtml,xml inoremap <buffer> </ </<C-x><C-o>
  autocmd FileType javascript setl cinoptions+=J1
  autocmd FileType cpp        setl commentstring=//\ %s
  autocmd FileType dosbatch   setl commentstring=@rem\ %s
  autocmd FileType vim        setl fenc=utf8 ff=unix
  autocmd FileType changelog  setl textwidth=0

augroup END

