if has('gui')
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
    function! GVimrc_set_guifont(font_name)
      let height=11
      let name=a:font_name
      let &guifont=printf('%s:h%d,Consolas:h%d', name, height, height)
      let &guifontwide=printf('%s:h%d,BIZ_UDゴシック:h%d', name, height, height)
    endfunction

    set rop=type:directx,renmode:5,taamode:1,contrast:2

    " call GVimrc_set_guifont('UD_デジタル_教科書体_N-R')
    call GVimrc_set_guifont('BIZ_UDゴシック')
  endif
endif

