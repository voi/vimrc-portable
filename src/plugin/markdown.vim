function! Vimrc_Markdown_IndentExpr()
  if v:lnum == 1 | return -1 | endif

  let baseLineNum = prevnonblank(v:lnum - 1)
  let marker = matchstr(getline(baseLineNum), '^\s*\zs\([-+*]\|\d\+[\.)]\)\s\+')
  let offset = ( &expandtab ? len(marker) : &shiftwidth )

  return (marker !=# '' ? indent(baseLineNum) + offset : -1)
endfunction

" GFM Toggle Todo
command! -range -nargs=0 GfmTodo call call({ begin, end -> 
    \ execute(printf('silent! %d,%ds/^\s*[-+*]\s\zs\[[x ]\]/\=(submatch(0) ==# "[x]" ? "[ ]" : "[x]")/', begin, end)) },
    \ [ <line1>, <line2> ])

nnoremap <silent> <LocalLeader>x :GfmTodo<CR>
vnoremap <silent> <LocalLeader>x :GfmTodo<CR>

augroup plugin_autocmd_markdown
  autocmd!
  autocmd FileType markdown setl
      \ tabstop=2 softtabstop=2 shiftwidth=2 wrap
      \ nosmartindent indentkeys=!^F,o,O indentexpr=Vimrc_Markdown_IndentExpr()
      \ commentstring=<!--\ %s\ -->
      \ | inoreabbr <buffer> -[ - [ ]
augroup END

