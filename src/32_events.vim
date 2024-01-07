augroup vimrc_autocmd_events
  autocmd!

  " autocmd WinEnter,BufWinEnter * setlocal wincolor=
  " autocmd WinLeave             * setlocal wincolor=NormalNC
  autocmd WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave             * setlocal nocursorline
augroup END

