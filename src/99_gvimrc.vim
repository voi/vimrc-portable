if has('gui_running')
  let $LANG='ja'
  " |¦»▸>￫↲
  let &showbreak="▸ "

  set listchars=tab:￫\ ,trail:.,extends:»,precedes:«,nbsp:%,conceal:￫
  " set listchars=tab:￫\ ,space:.,trail:.,extends:$,precedes:^,nbsp:%,conceal:@
  " set cmdheight=1
  set cursorline
  set guioptions=gre
  set columns=100
  set lines=40
  set linespace=3

  " ********
  if has('multi_byte_ime') || has('xim')
    highlight CursorIM guibg=#9900FF guifg=NONE

    inoremap <silent> <Esc> <ESC>:set iminsert=0<CR>

    if empty(mapcheck("\<C-j>", 'i'))
      inoremap <silent> <C-j> <C-^>
    endif

    set iminsert=0 imsearch=0
  endif

  " ********
  if has('win32')
    set rop=type:directx,renmode:5,taamode:1,contrast:2
    set guifont=Consolas:h10
    set guifontwide=BIZ_UDゴシック:h10
  endif
endif

