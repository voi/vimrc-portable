function! s:vimrc_ShowCmdLine(height)
  let h_ = max([ 9, min([ str2nr(a:height), ((&lines * 9) / 10) ]) ])
  let w_ = (&columns * 9) / 10

  call popup_create(
    \ term_start([&shell], #{ hidden: 1, term_finish: 'close'}),
    \ #{ border: [], fixed: 1, minwidth: w_, minheight: h_, maxwidth: w_, maxheight: h_ })
endfunction

command! -nargs=? Cmdline call <SID>vimrc_ShowCmdLine(<q-args>)

