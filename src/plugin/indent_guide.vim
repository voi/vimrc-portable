if has('gui_running')
  ""
  function! s:IndentGuide_set() abort
    if !&expandtab
      return
    endif

    setlocal conceallevel=2 concealcursor=iv

    for l:i in range(1, 32)
      call matchadd('Conceal', printf('\%%(^ \{%d}\)\zs ', i * &softtabstop), 0, -1, {'conceal': '¦'})
    endfor
  endfunction

  ""
  function! s:IndentGuide_init() abort
    highlight Conceal gui=NONE guifg=#AAAAAA guibg=NONE
  endfunction

  ""
  augroup plugin_autocmd_indent_guide
    autocmd!
    autocmd FileType * call s:IndentGuide_set()
    autocmd VimEnter,ColorScheme * call s:IndentGuide_init()
  augroup END
endif

