" *****************************************************************************
"""" 00_default.vim  {{{
"" vim: set ft=vim foldmethod=marker et ts=2 sts=2 sw=2
source $VIMRUNTIME/defaults.vim

scriptencoding utf-8
syntax on

"""" }}}

" *****************************************************************************
"""" 01_remote.vim  {{{
if has('gui_running') && has('clientserver') && argc() && !&diff && 0
  let servers = filter(split(serverlist(), '\n'), { idx, val -> v:servername !=# val })

  if !empty(servers)
    silent execute '!start gvim'
        \ '--servername' servers[0]
        \ '--remote-tab-silent ' join(map(copy(argv()), { key, val -> fnameescape(val) }), ' ')
    qa!
  endif
endif

"""" }}}

" *****************************************************************************
"""" 02_encoding.vim  {{{
set ambiwidth=double
set encoding=utf-8
set fileformats=dos,unix,mac
set fileencodings=utf-8,ucs-bom,euc-jp,eucjp-jisx0213,cp932,iso-2022-jp-3,iso-2022-jp,ucs-2le,ucs-2,cp936,default,latain1

" for win32
if has('win32')
  set makeencoding=cp932
  set termencoding=cp932
endif

"""" }}}

" *****************************************************************************
"""" 10_options.vim  {{{
set lazyredraw
" set synmaxcol=200
" set shortmess=coOIWtT
set laststatus=2
set belloff=all

if has('vcon') | set termguicolors | endif

set statusline=
set statusline+=%#StatusLine_Normal#%{(mode()=='n')?'\ \ NO\ ':''}
set statusline+=%#StatusLine_Insert#%{(mode()=='i')?'\ \ IN\ ':''}
set statusline+=%#StatusLine_Replace#%{(mode()=='r')?'\ \ RE\ ':''}
set statusline+=%#StatusLine_Visual#%{(mode()=='v')?'\ \ VI\ ':''}
set statusline+=%#StatusLine_Visual#%{(mode()=='s')?'\ \ SE\ ':''}
set statusline+=%#StatusLine_Modes#
set statusline+=%{(&modified?'⚡':'')}
set statusline+=%{(&readonly?'❎':'')}
set statusline+=〉
set statusline+=%#StatusLine#
set statusline+=\ %{pathshorten(bufname('%'))}
set statusline+=%=
set statusline+=%#StatusLine_Modes#
set statusline+=§
set statusline+=%y\ %{&fileencoding}\ %{&fileformat}\
set statusline+=%#StatusLine_CursorPos#
set statusline+=📐\ %l,\ %v\ -\ %04B\

set guioptions+=cM

set number
set list
let &showbreak="> "
set listchars=tab:>\ ,trail:.,extends:$,precedes:^,nbsp:%,conceal:.

if has('conceal') | set conceallevel=1 | endif 

" set colorcolumn=120
set formatoptions+=jnmM2
set formatoptions-=l
set display=lastline
set nofixendofline
set showtabline=2
" set textwidth=0
set scrolloff=0
set nowrap

set whichwrap+=h,l,<,>,[,]
set virtualedit+=block

set smarttab shiftround
set tabstop=4 shiftwidth=4 softtabstop=4

set autoindent smartindent
set copyindent preserveindent
set breakindent breakindentopt=shift:2

set complete=.,b,k,w
set completeopt=menuone,preview
set wildignore=*.bmp,*.png,*.jpg,*.jpeg

if has('win32')
  " Windows ('noshellslash')
  set wildignore+=.git\*,.hg\*,.svn\*,*.exe,*.lib,*.dll
else
  " Linux/MacOSX
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
endif

set wildignorecase
set wildmode=list:full
set pumheight=16

set isfname+=(,)

set autowrite autowriteall
set autoread
set autochdir

set noswapfile
set viminfo=

set switchbuf=useopen,usetab
set hidden

set ignorecase
set smartcase

set nowrapscan
" set noincsearch
set hlsearch
set tags+=./tags;

if has('win32')
  set grepprg=findstr\ /NSR
endif

set cryptmethod=blowfish2

"""" }}}

" *****************************************************************************
"""" 20_keymapping.vim  {{{
" a"/a'/a` trim whitespaces, a(/a{/a[ don't trim whitespaces.
vnoremap a" 2i"
vnoremap a' 2i'
vnoremap a` 2i`

onoremap a" 2i"
onoremap a' 2i'
onoremap a` 2i`

" blackhole
nnoremap <silent> d "_d
nnoremap <silent> D "_D
vnoremap <silent> d "_d

" compatible D
nnoremap <silent> Y y$

" clipboard
if has('clipboard') && 0
  set clipboard&
  set clipboard+=unnamed,unnamedplus
else
  nnoremap <silent> gp "*p
  nnoremap <silent> gP "*P

  nnoremap <silent> gy "*y
  nnoremap <silent> gY "*y$

  nnoremap <silent> gx "*x
  nnoremap <silent> gX "*X

  vnoremap <silent> gp "*p
  vnoremap <silent> gy "*y
  vnoremap <silent> gx "*x
endif

" visual replace
vnoremap <silent> _ "0p`<

" switch modes.
nnoremap <silent> <Leader>se :setl expandtab! expandtab?<CR>
nnoremap <silent> <Leader>sh :setl hlsearch!  hlsearch?<CR>
nnoremap <silent> <Leader>sr :setl readonly!  modifiable! modifiable?<CR>
nnoremap <silent> <Leader>sw :setl wrap!      wrap?<CR>
nnoremap <silent> <Leader>ss :setl wrapscan!  wrapscan?<CR>
nnoremap <silent> <Leader>si :setl incsearch! incsearch?<CR>
nnoremap <silent> <Leader>sl :setl relativenumber! relativenumber?<CR>

" buffer
nnoremap <silent> [b :bprev<CR>
nnoremap <silent> ]b :bnext<CR>

" window
nnoremap <silent> <C-Down>  <C-w>j
nnoremap <silent> <C-Up>    <C-w>k
nnoremap <silent> <C-Left>  <C-w>h
nnoremap <silent> <C-Right> <C-w>l

inoremap <silent> <C-Down>  <C-o><C-w>j
inoremap <silent> <C-Up>    <C-o><C-w>k
inoremap <silent> <C-Left>  <C-o><C-w>h
inoremap <silent> <C-Right> <C-o><C-w>l

" text operations
nnoremap <silent> <LocalLeader>d :copy .-1<CR>
vnoremap <silent> <LocalLeader>d :copy '<-1<CR>gv

nnoremap <silent> <C-k> :move .-2<CR>
nnoremap <silent> <C-j> :move .+1<CR>

vnoremap <silent> <C-k> :move '<-2<CR>gv
vnoremap <silent> <C-j> :move '>+1<CR>gv

" popup menu
inoremap <expr> <CR>  pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
inoremap <expr> <C-n> pumvisible() ? "\<Down>" : "\<C-n>"
inoremap <expr> <C-p> pumvisible() ? "\<Up>" : "\<C-p>"

" abbr datetime
inoreabbr -d <C-r>=strftime('%Y-%m-%d')<CR>
inoreabbr /d <C-r>=strftime('%Y/%m/%d')<CR>
inoreabbr -t <C-r>=strftime('%H:%M')<CR>
inoreabbr -f <C-r>=strftime('%Y-%m-%dT%H:%M')<CR>
inoreabbr /f <C-r>=strftime('%Y/%m/%dT%H:%M')<CR>

"""" }}}

" *****************************************************************************
"""" 21_autocomplete.vim  {{{
function! Vimrc_AutoComplete_Key(chr)
  return a:chr . ( pumvisible() ? '' : "\<C-X>\<C-P>\<C-N>")
endfunction

for k in split("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_",'\zs')
  exec printf("imap <silent> <expr> %s Vimrc_AutoComplete_Key('%s')", k, k)
endfor

"""" }}}

" *****************************************************************************
"""" 30_user_command.vim  {{{
" command! -nargs=? -complete=filetype Temp 
"     \ execute printf('tabe %s_%s | setf %s', tempname(), strftime('%Y-%m-%d_%H-%M-%S'),
"     \   ('<args>' ==# '' ? (&filetype ==# 'qf' ? 'text' : &filetype) : '<args>'))

"" <http://d.hatena.ne.jp/fuenor/20100115/1263551230>
command! -nargs=+ -bang -complete=file Rename
    \ let pbnr=fnamemodify(bufname('%'), ':p') | exec 'f '.escape(<q-args>, ' ') | w<bang> | call delete(pbnr)

command! -bang BufClear bufdo bw<bang>

command! -bang BufOnly 
    \ let bnrs = join(filter(range(1, bufnr('$')), {
    \   idx, val -> bufexists(val) && val != bufnr('%')
    \ }), ' ') |
    \ if bnrs !=# '' | execute 'bw<bang> ' . bnrs | endif

command! -bang BufTidyUp 
    \ let bnrs = range(1, bufnr('$'))
    \   ->filter({ idx, val -> bufexists(val) && bufloaded(val) })
    \   ->filter({ idx, val -> get(get(getbufinfo(val), 0, {}), 'hidden', 0) })
    \   ->join(' ') |
    \ if bnrs !=# '' | execute 'bw<bang> ' . bnrs | endif

" command! -nargs=1 -complete=dir LcdX
"     \ execute 'lcd ' . fnamemodify(<f-args>, ':p',)

"""" }}}

" *****************************************************************************
"""" 31_filtype.vim  {{{
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

"""" }}}

" *****************************************************************************
"""" 32_events.vim  {{{
augroup vimrc_autocmd_events
  autocmd!

  " autocmd WinEnter,BufWinEnter * setlocal wincolor=
  " autocmd WinLeave             * setlocal wincolor=NormalNC
  autocmd WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave             * setlocal nocursorline
augroup END

"""" }}}

" *****************************************************************************
"""" 33_user_syntax.vim  {{{
augroup vimrc_autocmd_user_syntax
  autocmd!
  autocmd VimEnter,WinEnter * hi def Bold gui=bold
      \ | hi def DateTime gui=bold,underline
      \ | call matchadd('DateTime', '[12]0\d\{2}-\%(1[0-2]\|0[1-9]\)-\%(3[01]\|[12][0-9]\|0[1-9]\)')
      \ | call matchadd('DateTime', '[12]0\d\{2}\/\%(1[0-2]\|0[1-9]\)\/\%(3[01]\|[12][0-9]\|0[1-9]\)')
      \ | call matchadd('DateTime', '\%(2[0-3]\|[0-1][0-9]\):\%([0-5][0-9]\)\%(:\%([0-5][0-9]\)\%(\.\d\{1,3}\)\?\)\?')

  autocmd FileType c,cpp
      \   syn keyword Type __int16 __int32 __int64 __fastcall
      \ | syn keyword Type int16_t uint16_t int32_t uint32_t int64_t uint64_t
      \ | syn keyword Typedef BYTE WORD DWORD SHORT USHORT LONG ULONG LONGLONG ULONGLONG
      \ | syn keyword Typedef WPARAM LPARAM WINAPI UINT_PTR
      \ | syn keyword Boolean BOOL TRUE FALSE

  autocmd FileType c,cpp,cs,java,javascript 
      \   syn match Operator /\s\zs[+\-\*\/<>=|&]\ze\s/
      \ | syn match Operator /;/
      \ | syn match Operator /[<>!=~+\-\*\/]=/
      \ | syn match Operator /||\|&&\|++\|--/
      \ | syn match Operator /::\ze\w/
      \ | syn match Operator /\>[\*&]/
      \ | syn match Operator /\*\</
      \ | syn match Operator /[!&]\s*\</
      \ | syn match Operator /[!&]\s*\ze(/
      \ | syn match Operator /\%(->\|\.\)\</
      " \ | syn match Bold /[{}]/

  autocmd FileType log 
      \ | syn match LogDumpNonZero /\<\%([13-9A-F]0\|\x[1-9A-F]\)\>/
      \ | syn match LogDumpZero    /\<00\>/
      \ | syn match LogDumpSpace   /\<20\>/
      \ | syn match LogErrWord     /\cERR\%[OR]/
      \ | hi def link LogDumpZero    SpecialKey
      \ | hi def link LogDumpNonZero String
      \ | hi def link LogDumpSpace   Comment
      \ | hi def link LogErrWord     Error

augroup END

"""" }}}

" *****************************************************************************
"""" 40_colors_highlight.vim  {{{
function! s:Vimrc_HighlightPlus() abort
  hi clear CursorLine
  hi clear SpecialKey

  hi CursorLine term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE

  " ime
  hi CursorIM gui=NONE guifg=#FFFFFF guibg=#8000FF ctermbg=White ctermbg=Red

  if &g:background ==# 'dark'
    hi SpecialKey   guifg=#808080  guibg=NONE    gui=NONE       ctermfg=grey
    hi ZenkakuSpace guifg=darkgrey               gui=underline  ctermfg=darkgrey cterm=underline
    hi Comment      guifg=#cccccc  guibg=NONE    gui=italic     ctermfg=grey
  else
    hi SpecialKey   guifg=#cccccc  guibg=NONE    gui=NONE       ctermfg=grey
    hi ZenkakuSpace guifg=grey                   gui=underline  ctermfg=grey cterm=underline
    hi Comment      guifg=#808080  guibg=NONE    gui=italic     ctermfg=darkgrey
  endif

  "
  hi link TrailingSpace NonText

  "
  call matchadd('ZenkakuSpace', '　')
  call matchadd('TrailingSpace', '\s\{2,\}$')

  " statusline
  hi StatusLine_Modes      guifg=#030303 guibg=#FFFFFF ctermfg=Black ctermbg=White
  hi StatusLine_CursorPos  guifg=#FFFFFF guibg=#333399 ctermfg=White ctermbg=DarkBlue

  hi StatusLine_Normal     guifg=#FFFFFF guibg=#0000FF ctermfg=White ctermbg=Blue
  hi StatusLine_Insert     guifg=#FFFFFF guibg=#009944 ctermfg=White ctermbg=Green
  hi StatusLine_Replace    guifg=#FFFFFF guibg=#9933A3 ctermfg=White ctermbg=Cyan
  hi StatusLine_Visual     guifg=#FFFFFF guibg=#F20000 ctermfg=White ctermbg=Red
  hi StatusLine_Select     guifg=#030303 guibg=#F2F200 ctermfg=Black ctermbg=Yellow

  if has('gui_running')
    if &g:background ==# 'dark'
      hi Normal       guifg=#f0f0f0  guibg=#404042 gui=NONE
      hi NormalNC     guifg=#808080  guibg=#606060

    else
      hi Normal       guifg=#030303  guibg=#f0f0f0 gui=NONE
      hi NormalNC     guifg=#cccccc  guibg=#dddddd

      " based vim-kalisi
      hi Constant         guifg=#0000af guibg=NONE    gui=bold
      hi String           guifg=#0060a0 guibg=NONE
      hi Character        guifg=#9054c7 guibg=NONE    gui=bold
      hi Number           guifg=#0070c0 guibg=NONE
      hi Boolean          guifg=#66b600 guibg=NONE    gui=none
      hi Float            guifg=#00a0a0 guibg=NONE

      hi Identifier       guifg=#202090 guibg=NONE    gui=none
      hi Function         guifg=#1177dd               gui=none

      hi Statement        guifg=#66b600 guibg=NONE    gui=bold
      hi Conditional      guifg=#1177dd guibg=NONE    gui=bold
      hi Repeat           guifg=#1177dd guibg=NONE    gui=none
      hi Label            guifg=#007700               gui=bold
      hi Operator         guifg=#274aac guibg=NONE    gui=none
      hi Exception        guifg=#005090 guibg=NONE    gui=bold

      hi PreProc          guifg=#d80050 guibg=NONE    gui=bold
      hi Include          guifg=#d80050 guibg=NONE    gui=none
      hi Define           guifg=#d80050 guibg=NONE    gui=bold
      hi Macro            guifg=#d80000 guibg=NONE    gui=none
      hi PreCondit        guifg=#1177dd               gui=none

      hi Type             guifg=#f47300 guibg=NONE    gui=none

      hi StorageClass     guifg=#0000d7               gui=italic
      hi Structure        guifg=#274aac guibg=NONE    gui=none
      hi Typedef          guifg=#274aac               gui=italic

      hi Special          guifg=#ffaf00 guibg=NONE    gui=bold
      hi SpecialChar      guifg=#F92672               gui=bold
      hi Tag              guifg=#0010ff               gui=underline
      hi Delimiter        guifg=#d80050 guibg=NONE    gui=none
      hi Debug            guifg=#ddb800 guibg=NONE    gui=bold

      hi Underlined       guifg=#202020 guibg=NONE    gui=underline

      hi Error            guifg=#d80000 guibg=#ffff00 gui=bold,underline
      hi ErrorMsg         guifg=#d80000 guibg=#ffff00 gui=bold

      " Misc syntax
      hi Todo             guifg=#ff0000 guibg=#eeee00 gui=bold

      hi Directory        guifg=#0060a0 guibg=NONE    gui=NONE
      hi Keyword          guifg=#66b600               gui=none
      hi Title            guifg=#1060a0 guibg=NONE    gui=bold
      hi NonText          guifg=#000000 guibg=#e6e6e6 gui=none

      hi Conceal          guifg=#acacac

      hi DiffAdd                        guibg=#ddffdd 
      hi DiffChange                     guibg=#ffdddd 
      hi DiffText         guifg=#000055 guibg=#ddddff
      hi DiffDelete       guifg=#6c6c6c guibg=#cccccc

      hi SpellBad         guisp=#d80000 gui=undercurl
      hi SpellCap         guisp=#274aac gui=undercurl
      hi SpellLocal       guisp=#006600 gui=undercurl
      hi SpellRare        guisp=#a7a755 gui=undercurl

      " User interface
      hi Visual                         guibg=#d0eeff gui=NONE
      hi VisualNOS                      guibg=#d8d8d8 gui=none

      hi Cursor           guifg=#f0f0f0 guibg=#ff0000 gui=bold
      hi CursorLineNr     guifg=#606060 guibg=#fc8484 gui=bold
      hi Cursorline                     guibg=#eaeaea
      hi CursorColumn                   guibg=#eaeaea
      hi MatchParen       guifg=#ffffff guibg=#ffd030 gui=none

      hi Search           guifg=#303030 guibg=#b8ea00 gui=bold
      hi IncSearch        guifg=#f8cf00 guibg=#303030

      hi LineNr           guifg=#606060 guibg=#c0c0c0 gui=NONE

      hi VertSplit        guifg=#a0a0a0 guibg=#a0a0a0 gui=NONE
      hi Folded           guifg=#606060 guibg=#d8d8d8 gui=NONE
      hi FoldColumn       guifg=#707070 guibg=#b0b0b0 gui=bold

      hi WildMenu         guifg=#000000 guibg=#b6eB39 gui=none
      hi Question         guifg=#000000 guibg=#b6eB39 gui=none
      hi MoreMsg          guifg=#000000 guibg=#b6eB39 gui=none

      hi ModeMsg          guifg=#000000 guibg=#A6DB29
      hi WarningMsg       guifg=#d82020 guibg=NONE    gui=bold

      hi TabLine          guifg=#afd700 guibg=#005f00 gui=none
      hi TabLineSel       guifg=#005f00 guibg=#afd700 gui=none
      hi TabLineFill      guifg=#303030 guibg=#a0a0a0 gui=none

      hi SignColumn       guifg=#A6E22E guibg=#c9c4c4

      hi Pmenu            guifg=#303030 guibg=#c6db29 gui=NONE
      hi PmenuSel         guifg=#d0d0d0 guibg=#638514 gui=bold
      hi PmenuSbar                      guibg=#a0a0a0
      hi PmenuThumb                     guibg=#555555
    endif
  endif
endfunction

augroup vimrc_autocmd_colors_highlight
  autocmd!
  autocmd VimEnter,WinEnter,ColorScheme * call <SID>Vimrc_HighlightPlus()
augroup END

"""" }}}

" *****************************************************************************
"""" 50_runtime_config.vim  {{{
let c_gnu = 1
let c_comment_strings = 1
let c_space_errors = 1
let c_no_tab_space_error = 1
let c_no_bracket_error = 1
let c_no_curly_error = 1

let did_install_default_menus = 1
let did_install_syntax_menu = 1

let g:loaded_gzip = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1
let g:loaded_rrhelper = 1
let g:loaded_2html_plugin = 1
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1
let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1

" let g:loaded_netrw = 1 
" let g:loaded_netrwPlugin = 1 
" let g:loaded_netrwSettings = 1
" let g:loaded_netrwFileHandlers = 1

" let g:loaded_matchparen = 1 

let g:vim_indent_cont = 4

packadd! matchit
packadd! cfilter

"""" }}}

" *****************************************************************************
"""" 60_common_function.vim  {{{
function! Vimrc_EmptyMethod(arg0, ...) dict
  let nop = a:0
endfunction

function! Vimrc_GetMethod(object, name)
  let Handler = get(a:object, a:name, 0)

  return (type(Handler) == v:t_func) ? Handler  : funcref('Vimrc_EmptyMethod')
endfunction

function! s:Vimrc_popup_open_file(winid, open, file) abort
    call popup_close(a:winid)
    execute a:open a:file
    return 1
endfunction

function! s:Vimrc_popup_filter(ctx, winid, key) abort
    if a:key is# 'j'
        if a:ctx.idx < len(a:ctx.active_lines) -1
            let a:ctx.idx += 1
        endif
    elseif a:key is# 'k'
        if a:ctx.idx > 0
            let a:ctx.idx -= 1
        endif
    elseif a:key is# 'i'
      let word = inputdialog('input include filter word.')
      if !empty(word)
        let a:ctx.active_lines = a:ctx.active_lines->filter({ idx, val -> val =~ word })
        let a:ctx.idx = 0
        call popup_settext(a:winid, a:ctx.active_lines)
      endif
    elseif a:key is# 'I'
      let word = inputdialog('input exclude filter word.')
      if !empty(word)
        let a:ctx.active_lines = a:ctx.active_lines->filter({ idx, val -> val !~ word })
        let a:ctx.idx = 0
        call popup_settext(a:winid, a:ctx.active_lines)
      endif
    elseif a:key is# 'f'
      let text = inputdialog('input fuzzy filter text.')
      if !empty(text)
        let a:ctx.active_lines = matchfuzzy(a:ctx.active_lines, text)
        let a:ctx.idx = 0
        call popup_settext(a:winid, a:ctx.active_lines)
      endif
    elseif a:key is# 'r'
      let a:ctx.active_lines = a:ctx.lines->copy()
      let a:ctx.idx = 0
      call popup_settext(a:winid, a:ctx.active_lines)
    elseif a:key is# "\<cr>"
        return s:Vimrc_popup_open_file(a:winid, 'edit', a:ctx.active_lines[a:ctx.idx])
    elseif a:key is# "\<c-v>"
        return s:Vimrc_popup_open_file(a:winid, 'vsplit', a:ctx.active_lines[a:ctx.idx])
    elseif a:key is# "\<c-s>"
        return s:Vimrc_popup_open_file(a:winid, 'split', a:ctx.active_lines[a:ctx.idx])
    elseif a:key is# "\<c-t>"
        return s:Vimrc_popup_open_file(a:winid, 'tabedit', a:ctx.active_lines[a:ctx.idx])
    endif

    return popup_filter_menu(a:winid, a:key)
endfunction

function! Vimrc_Popup(lines)
  if empty(a:lines) | echomsg '[Vimrc_Popup] no entries.' | return | endif
  let ctx = #{
      \ idx: 0,
      \ lines: a:lines,
      \ active_lines: a:lines->copy(),
      \ }
  let winid = popup_menu(ctx.active_lines, #{
      \ filter: function('s:Vimrc_popup_filter', [ctx])
      \ })
  call popup_move(winid, #{ maxheight: min([len(ctx.lines), winheight(0) - 5]) })
endfunction

function! Vimrc_ListUp(what, bang)
  if empty(a:what) | return | endif
  if empty(a:what.lines) | echomsg '[Vimrc_ListUp] no entries.' | return | endif
  if empty(a:bang)
    call setqflist([], ' ', a:what)
    cwindow
  else
    call setloclist(0, [], ' ', a:what)
    lwindow
  endif

  call matchadd('Conceal', '||\s$')

  setl concealcursor=nvic
  setl conceallevel=3
endfunction

"""" }}}

" *****************************************************************************
"""" 99_gvimrc.vim  {{{
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

"""" }}}

" *****************************************************************************
"""" plugin/align_cmd.vim  {{{
function! s:Align_calc_padding_tabs(token, align_width) abort
  let l:ts = &tabstop
  let l:align_width = (a:align_width % l:ts == 0) ? a:align_width :
      \ ((a:align_width + l:ts) / l:ts) * l:ts
  let l:mergin = l:align_width - strdisplaywidth(a:token)

  return repeat("\t", ((l:mergin + (l:mergin % l:ts ? l:ts : 0)) / l:ts))
endfunction

function! s:Align_calc_padding_space(token, align_width) abort
  return repeat(' ', a:align_width - strdisplaywidth(a:token))
endfunction

function! s:Align_get_token(tokens, align_width, ctx) abort
  if len(a:tokens) > 1
    let l:token = substitute(remove(a:tokens, 0), '\s*$', '', '')
    let a:tokens[0] = l:token
        \ . a:ctx.filler(l:token, a:align_width)
        \ . a:tokens[0]
  endif

  return a:tokens
endfunction

function! s:Align_parse(arguments) abort
  let l:ctx = {
      \ 'pattern': '',
      \ 'global': '',
      \ 'filler': function('<SID>align_calc_padding_space'),
      \ 'sub': '\n&',
      \ 'delim': '\n'
      \ }
  let l:use_regexp = 0
  let l:case = ''

  for l:opt in a:arguments
    if     l:opt ==# '-g' | let l:ctx.global = 'g'
    elseif l:opt ==# '-t' | let l:ctx.filler = function('<SID>align_calc_padding_tabs')
    elseif l:opt ==# '-a' | let l:ctx.sub = '&\n' | let l:ctx.delim = '\n\s*'
    elseif l:opt ==# '-r' | let l:use_regexp = 1
    elseif l:opt ==# '-c' | let l:case = '\C'
    else                  | let l:ctx.pattern = l:opt
    endif
  endfor

  if l:use_regexp
    let l:ctx.pattern = l:case . l:ctx.pattern
  else
    let l:ctx.pattern = '\V' . l:case . escape(l:ctx.pattern, '\')
  endif

  return l:ctx
endfunction

function! s:Align_apply(startl, endl, arguments) abort
  if empty(a:arguments)
    return
  endif

  let l:ctx = s:Align_parse(a:arguments)
  let l:line_tokens = map(getline(a:startl, a:endl),
      \ { key, val -> split(substitute(val, l:ctx.pattern, l:ctx.sub, l:ctx.global), l:ctx.delim, 1) })
  let l:width = 0

  while max(map(copy(l:line_tokens), { key, val -> (len(val) > 1) }))
    " 
    let l:width = max(map(filter(copy(l:line_tokens),
        \   { idx, val -> (len(val) > 1) }),
        \ { key, val -> strdisplaywidth(val[0]) }))
    " 
    let l:line_tokens = map(l:line_tokens,
        \ { key, val -> s:Align_get_token(val, l:width, l:ctx) })
  endwhile

  if l:width > 0
    call setline(a:startl, map(l:line_tokens, 'v:val[0]'))
  endif
endfunction

function! s:Align_complete_arguments(ArgLead, CmdLine, CursorPos) abort
  return [ '-g', '-t', '-a', '-r', '-c' ]
endfunction

command! -range -nargs=+ -complete=customlist,<SID>align_complete_arguments Align
    \ call <SID>Align_apply(<line1>, <line2>, [<f-args>])

"""" }}}

" *****************************************************************************
"""" plugin/changelogmd.vim  {{{
function s:Vimrc_changelog_new_entry()
  let header = printf('# %s  %s', strftime('%Y-%m-%d'), repeat('#', 64))
  let entry = strftime('* %Y-%m-%dT%H:%M:00Z ')

  if line('.') == 1
    let lnum = ( getline('.') =~# '^' . header )
  else
    let lnum = search('^' . header, 'bW', 1)
  endif

  if lnum
    call append(lnum, [ '', entry ])
    call cursor(lnum + 2, 9999)
  else
    call append(0, [ header, '', entry, ''])
    call cursor(3, 9999)
  endif
endfunction

augroup plugin_autocmd_changelog_md
  autocmd BufNewFile,BufReadPost changelog.md nnoremap <buffer> <silent> <LocalLeader>o :<C-u>call <SID>Vimrc_changelog_new_entry()<CR>
  autocmd BufNewFile,BufReadPost changelog.md xnoremap <buffer> <silent> <LocalLeader>o :<C-u>call <SID>Vimrc_changelog_new_entry()<CR>
augroup END

"""" }}}

" *****************************************************************************
"""" plugin/enclose_text.vim  {{{
function! s:enclose_text_parse(arguments) abort
  let l:command = '-a'
  let l:Escape = { val -> '\V' . escape(val, '\') }
  let l:trim_ptn = ''
  let l:spacing = ''
  let l:tokens = []

  for l:arg in a:arguments
    if     l:arg =~# '^-[adr]$' | let l:command = l:arg
    elseif l:arg ==# '-g'       | let l:Escape = { val -> val }
    elseif l:arg ==# '-s'       | let l:spacing = ' '
    elseif l:arg ==# '-t'       | let l:trim_ptn = '\v\s*'
    elseif l:arg ==# '-c'       | let l:tokens = split(&commentstring, '\s*%s\s*', 1)
    else                        | call add(l:tokens, l:arg)
    endif
  endfor

  let l:tokens += [ '', '', '', '' ]

  if l:command ==# '-a'
    return #{
        \ fo: '^' . l:trim_ptn,
        \ fc: l:trim_ptn . '$',
        \ to: l:tokens[0] . l:spacing,
        \ tc: l:spacing . l:tokens[1]
        \ }
  elseif l:command ==# '-d'
    return #{
        \ fo: '^' . l:Escape(l:tokens[0]) . l:trim_ptn,
        \ fc: l:trim_ptn . l:Escape(l:tokens[1]) . '\v$',
        \ to: '',
        \ tc: ''
        \ }
  elseif l:command ==# '-r'
    return #{
        \ fo: '^' . l:Escape(l:tokens[0]) . l:trim_ptn,
        \ fc: l:trim_ptn . l:Escape(l:tokens[1]) . '\v$',
        \ to: l:tokens[2] . l:spacing,
        \ tc: l:spacing . l:tokens[3]
        \ }
  endif

  return {}
endfunction

function! s:enclose_text_edit(text, pattern, type) abort
  let l:edit_text = a:text

  if and(a:type, 0x01) && !(empty(a:pattern.fo) && empty(a:pattern.to))
    let l:edit_text = substitute(l:edit_text, a:pattern.fo, a:pattern.to, '')
  endif

  if and(a:type, 0x02) && !(empty(a:pattern.fc) && empty(a:pattern.tc))
    let l:edit_text = substitute(l:edit_text, a:pattern.fc, a:pattern.tc, '')
  endif

  return l:edit_text
endfunction

function! s:enclose_text_apply(arguments) range abort
  let l:pattern = s:enclose_text_parse(a:arguments)

  if !empty(l:pattern)
    if visualmode() ==# 'v' && (getpos("'<")[1] != getpos("'>")[1])
      keepjumps execute "'<s/\\%V.*/\\=<SID>enclose_text_edit(submatch(0), l:pattern, 0x01)/e"
      keepjumps execute "'>s/.*\\%V.\\?/\\=<SID>enclose_text_edit(submatch(0), l:pattern, 0x02)/e"
    else
      keepjumps execute "'<,'>s/\\%V.*\\%V./\\=<SID>enclose_text_edit(submatch(0), l:pattern, 0x03)/e"
    endif

    execute "normal `<"
  endif
endfunction

function! s:enclose_text_complete_arguments(ArgLead, CmdLine, CursorPos) abort
  return [ '-a', '-d', '-r', '-g', '-s', '-t', '-c' ]
endfunction

command! -range -nargs=* -complete=customlist,<SID>enclose_text_complete_arguments
    \ EncloseText call <SID>enclose_text_apply([ <f-args> ])
command! -range -nargs=0 Comment   call <SID>enclose_text_apply([ '-a', '-s', '-c' ])
command! -range -nargs=0 Uncomment call <SID>enclose_text_apply([ '-d', '-t', '-c' ])

vnoremap <LocalLeader>ea :EncloseText -a 
vnoremap <LocalLeader>ed :EncloseText -d 
vnoremap <LocalLeader>er :EncloseText -r 

"""" }}}

" *****************************************************************************
"""" plugin/indent_at_head.vim  {{{
command! -range -nargs=0 IndentAtHead call call({ begin, end -> 
    \ execute(printf('silent! %d,%ds/^\ze./%s/', begin, end, (&expandtab ? repeat(' ',&sw) : '\t'))) },
    \ [ <line1>, <line2> ])

nnoremap <silent> g> :IndentAtHead<CR>
vnoremap <silent> g> :IndentAtHead<CR>

command! -range -nargs=0 UnIndentAtHead call call({ begin, end -> 
    \ execute(printf('silent! %d,%ds/^%s//', begin, end, (&expandtab ? repeat(' ',&sw) : '\t'))) },
    \ [ <line1>, <line2> ])

nnoremap <silent> g< :UnIndentAtHead<CR>
vnoremap <silent> g< :UnIndentAtHead<CR>

"""" }}}

" *****************************************************************************
"""" plugin/indent_guide.vim  {{{
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

"""" }}}

" *****************************************************************************
"""" plugin/list_up.vim  {{{
" https://github.com/skanehira/popupfiles.vim/blob/master/autoload/popupfiles.vim
let s:ListUp_history = []

function! s:ListUp_getBookmarkPath() "{{{
  let deffpath = expand('~/.bookmark.txt')
  let filepath = expand(get(g:, 'vimrc_plugin_listup_bookmark_path', deffpath))

  return (isdirectory(filepath) ? deffpath : filepath)
endfunction "}}}

function! s:ListUp_GetContext(name, args)
  if a:name ==# 'buffers'
    let files = range(1, bufnr('$'))
        \ ->filter({ idx, val -> bufexists(val) && buflisted(val) && bufloaded(val) && empty(getbufvar(val, '&buftype')) })
        \ ->map({ idx, val -> bufname(val) })
        \ ->filter({ idx, val -> !empty(val) })
    return #{ lines: files, efm: '%f', title: 'buffers' }

  elseif a:name ==# 'files'
    let root = empty(a:args) ? getcwd() : a:args[0]
    let files = globpath(fnamemodify(root, ':p'), '*', 0, 1)
        \ ->filter({ idx, val -> !isdirectory(val) })
    return #{ lines: files, efm: '%f', title: 'files: ' . root }

  elseif a:name ==# 'oldfiles'
    let files = copy(v:oldfiles)
        \ ->map({ idx, val -> fnamemodify(val, ':p') })
    return #{ lines: files, efm: '%f', title: 'MRU' }

  elseif a:name ==# 'bookmark'
    let filepath = s:ListUp_getBookmarkPath()
    let files = extend((filereadable(filepath) ? readfile(filepath) : []), s:ListUp_history)
        \ ->sort()->uniq()
    return #{ lines: files, efm: '%f', title: 'Bookmark' }

  else
    return #{}
  endif
endfunction

function! s:ListUp_List(name, bang, args)
  let ctx = s:ListUp_GetContext(a:name, a:args)
  call Vimrc_ListUp(ctx, a:bang)
endfunction

function! s:ListUp_Popup(name, args)
  let ctx = s:ListUp_GetContext(a:name, a:args)
  call Vimrc_Popup(ctx.lines)
endfunction

function! s:ListUp_addBookmark(args)
  call writefile(a:args
      \ ->map({ idx, val -> fnamemodify(expand(val), ':p') })
      \ ->filter({ idx, val -> filereadable(val) }),
      \ s:ListUp_getBookmarkPath(), 'a')
endfunction

function! s:ListUp_recordHistory()
  if !empty(getbufvar('%', '&buftype'))
    return
  endif

  let filepath = fnamemodify(expand(bufname('%')), ':p')

  if isdirectory(filepath) || !filereadable(filepath)
    return
  endif

  if index(s:ListUp_history, filepath) < 0
    call insert(s:ListUp_history, filepath)
  endif
endfunction

command! -bang -nargs=0               BufListup       call s:ListUp_List('buffers', '<bang>', [])
command! -bang -nargs=? -complete=dir FileListup      call s:ListUp_List('files', '<bang>', [<q-args>])
command! -bang -nargs=0               MruListup       call s:ListUp_List('oldfiles', '<bang>', [])
command! -bang -nargs=0               BookmarkListup  call s:ListUp_List('bookmark', '<bang>', [])

command! -nargs=0               BufPopup      call s:ListUp_Popup('buffers', [])
command! -nargs=? -complete=dir FilePopup     call s:ListUp_Popup('files', [<q-args>])
command! -nargs=0               MruPopup      call s:ListUp_Popup('oldfiles', [])
command! -nargs=0               BookmarkPopup call s:ListUp_Popup('bookmark', [])

command! -nargs=+ -complete=file BookmarkAdd call s:ListUp_addBookmark([<f-args>])

augroup plugin_autocmd_list_up
  autocmd!
  autocmd BufReadPost,BufWritePost * call s:ListUp_recordHistory()
augroup END

"""" }}}

" *****************************************************************************
"""" plugin/markdown.vim  {{{
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

"""" }}}

" *****************************************************************************
"""" plugin/popup_terminal.vim  {{{
function! s:vimrc_ShowCmdLine(height)
  let h_ = max([ 9, min([ str2nr(a:height), ((&lines * 9) / 10) ]) ])
  let w_ = (&columns * 9) / 10

  call popup_create(
    \ term_start([&shell], #{ hidden: 1, term_finish: 'close'}),
    \ #{ border: [], fixed: 1, minwidth: w_, minheight: h_, maxwidth: w_, maxheight: h_ })
endfunction

command! -nargs=? Cmdline call <SID>vimrc_ShowCmdLine(<q-args>)

"""" }}}

" *****************************************************************************
"""" plugin/prompt_grep.vim  {{{
function! s:PromptGrep_findReposRoot() abort
  let current = fnamemodify(getcwd(), ':p:h') . ';'
  let repos = map([ '.git', '.svn', '.bzr' ], { idx, val -> finddir(val, current) })

  return fnamemodify(repos[0], ':h')
endfunction

function! s:PromptGrep_search(bang, mode)
  let word = input('[grep pattern]: ', expand('<cword>'))
  if empty(word) | return | endif

  if a:mode is# 'vcs'
    let entry = s:PromptGrep_findReposRoot()
  else
    let entry = ''
  endif

  let entry = input('[grep entry]: ', entry, 'dir')
  if !empty(entry)
    execute printf('%svimgrep /%s/j %s', (empty(a:bang) ? '' : 'l'), word, entry)
  endif
endfunction

command -nargs=0 -bang PGrep call s:PromptGrep_search('<bang>', '')
command -nargs=0 -bang VCSGrep call s:PromptGrep_search('<bang>', 'vcs')

"""" }}}

" *****************************************************************************
"""" plugin/qf_util.vim  {{{
function! s:QFUtil_is_location(winid)
  return get(get(getwininfo(a:winid), 0, {}), 'loclist', 0)
endfunction

function! s:QFUtil_open(command)
  let winid = win_getid()
  let list = s:QFUtil_is_location(winid) ? getloclist(winid) : getqflist()
  let item = get(list, line('.') -1, {})
  let bufnr = get(item, 'bufnr', -1)

  if bufnr > 0
    wincmd p
    execute printf('%s %% | b %d', a:command, bufnr)
    call cursor(get(item, 'lnum', 1), get(item, 'col', 1))
  endif
endfunction

function! s:QFUtil_keymap()
  "
  nnoremap <buffer> <CR>   :pclose<CR><CR>
  nnoremap <buffer> <S-CR> :pclose<CR><CR><C-w>p<C-w>q
  nnoremap <buffer> <C-v>  :call <SID>QFUtil_open('vsplit')<CR>
  nnoremap <buffer> <C-s>  :call <SID>QFUtil_open('split')<CR>
  nnoremap <buffer> <C-t>  :call <SID>QFUtil_open('tabe')<CR>

  if s:QFUtil_is_location(win_getid())
    nnoremap <buffer> <C-p> :lolder<CR>
    nnoremap <buffer> <C-n> :lnewer<CR>
    nnoremap <buffer> <expr> i printf(":Lfilter  /%s/\<CR>", input('>', ''))
    nnoremap <buffer> <expr> I printf(":Lfilter! /%s/\<CR>", input('>', ''))
  else
    nnoremap <buffer> <C-p> :colder<CR>
    nnoremap <buffer> <C-n> :cnewer<CR>
    nnoremap <buffer> <expr> i printf(":Cfilter  /%s/\<CR>", input('>', ''))
    nnoremap <buffer> <expr> I printf(":Cfilter! /%s/\<CR>", input('>', ''))
  endif
endfunction

augroup plugin_autocmd_qf_utils
  autocmd!
  autocmd QuickFixCmdPost grep,grepadd,vimgrep topleft copen
  autocmd QuickFixCmdPost lgrep,lgrepadd,lvimgrep topleft lopen

  autocmd CmdwinEnter *    nnoremap <buffer> q <C-w>c

  autocmd FileType help,qf nnoremap <buffer> q :pclose<CR><C-w>c
  autocmd FileType qf call <SID>QFUtil_keymap()
augroup END

nnoremap <silent> <F9>    :lnext<CR>zz
nnoremap <silent> <S-F9>  :lprevious<CR>zz
nnoremap <silent> <C-F9>  :topleft lw<CR>

nnoremap <silent> <F10>   :cnext<CR>zz
nnoremap <silent> <S-F10> :cprevious<CR>zz
nnoremap <silent> <C-F10> :topleft cw<CR>

"""" }}}

" *****************************************************************************
"""" plugin/register_hints.vim  {{{
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

"""" }}}

" *****************************************************************************
"""" plugin/show_mark_sign.vim  {{{
" https://qiita.com/neras_1215/items/b4090deb7c07f52c6ec7
let s:ShowMarkSign_chars = 'abcdefghijklmnopqrstuvwxyz'

function! s:ShowMarkSign_getMarks() abort
  try
    let marks = split(execute('marks ' . s:ShowMarkSign_chars), '\n')
    return map(marks[1:], { idx, val -> split(substitute(val, '^\v\s*(\S)\s+(\d+)\s+.*', '\1 \2', ''), ' ') })
  catch
    return []
  endtry
endfunction

function! s:ShowMarkSign_getSigns() abort
  try
    return map(split(execute('sign list'), '\n'),
        \ { idx, val -> substitute(val, '\vsign\s+(\S+)\s+.*', '\1', '') })
  catch
    return []
  endtry
endfunction

function! s:ShowMarkSign_getSignId(char)
  return stridx(s:ShowMarkSign_chars, a:char) + 1
endfunction

function! s:ShowMarkSign_show()
  for [char, lineno] in s:ShowMarkSign_getMarks()
    execute printf('sign define %s text=%s texthl=ErrorMsg', char, char)
    execute printf('sign place %s line=%s name=%s file=%s', 
        \ s:ShowMarkSign_getSignId(char), lineno, char, expand("%:p"))
  endfor
endfunction

function! ShowMarkSign_ToggleMark() abort
  let active_marks = s:ShowMarkSign_getMarks()

  if empty(active_marks)
    " toggle(add)
    execute('mark a')
  else
    let markable_chars = copy(s:ShowMarkSign_chars)
    let curr_line = line('.')
    let curr_mark = ''

    for [char, lineno] in active_marks
      if lineno ==# curr_line
        let curr_mark = char
        break
      endif

      let markable_chars = substitute(markable_chars, char, '', '')
    endfor

    if empty(curr_mark)
      " toggle(add)
      if empty(markable_chars)
        echomsg 'all local marks are used.'
        return
      else
        execute('mark ' . markable_chars[0])
      endif
    else
      " toggle(delete)
      execute('delmarks '. curr_mark)

      if !empty(filter(s:ShowMarkSign_getSigns(), { idx, val -> val ==# curr_mark }))
        execute printf('sign undefine %s', curr_mark)
        execute printf('sign unplace %s', s:ShowMarkSign_getSignId(curr_mark))
      endif
    endif
  endif

  call s:ShowMarkSign_Show()
endfunction

augroup plugin_autocmd_show_sign
  autocmd!
  autocmd BufEnter,CmdwinEnter * call s:ShowMarkSign_show()
augroup END

nnoremap <silent> <Leader>m :call ShowMarkSign_ToggleMark()<CR>

"""" }}}

" *****************************************************************************
"""" plugin/toggle_comment.vim  {{{
function! s:ToggleComment_do(first_line, last_line) abort
  let [cbegin, cend] = split(escape(&commentstring, '/?'), '\s*%s\s*', 1)
  let pattern = printf('^\(\s*\)\V%s\m\s\?\(.*\)\s\?\V%s', cbegin, cend)

  for ln in range(a:first_line, a:last_line)
    let line = getline(ln)
    if line =~# pattern
      execute printf('%ds/%s/\1\2/', ln, pattern)
    elseif line !=# ''
      execute printf('%ds/\v^(\s*)(\S.*)/\1%s%s\2%s%s/',
          \ ln, cbegin, (empty(cbegin) ? '' : ' '), (empty(cend) ? '' : ' '), cend)
    endif
  endfor
endfunction

command! -range -nargs=0 ToggleComment call s:ToggleComment_do(<line1>, <line2>) 

nnoremap <silent> <C-q> :ToggleComment<CR>
vnoremap <silent> <C-q> :ToggleComment<CR>

"""" }}}

" *****************************************************************************
"""" plugin/tortoisesvn.vim  {{{
if has('win32') && executable('TortoiseProc.exe')
  "" 
  function! s:tsvn_command_do(command, arguments) abort
    if a:arguments ==# ''
      let l:path = finddir('.svn', getcwd() . ';')->fnamemodify(':h')->fnamemodify(':p')
    else
      let l:path = a:arguments
    endif

    let l:cmdline = 'TortoiseProc.exe /command:' . a:command . ' /path:"' . l:path . '"'

    if has('iconv') && (&termencoding != &encoding)
      let l:cmdline = iconv(l:cmdline, &encoding, &termencoding)
    endif

    call job_start(l:cmdline, { 'in_io': 'null', 'out_io': 'null', 'err_io': 'null' })
  endfunction

  ""
  command! -nargs=? -complete=file TSvnLog    call <SID>tsvn_command_do('log', <q-args>)
  command! -nargs=? -complete=file TSvnDiff   call <SID>tsvn_command_do('diff', <q-args>)
  command! -nargs=? -complete=file TSvnBlame  call <SID>tsvn_command_do('blame', <q-args>)
  command! -nargs=? -complete=file TSvnAdd    call <SID>tsvn_command_do('add', <q-args>)
  command! -nargs=? -complete=file TSvnStatus call <SID>tsvn_command_do('repostatus', <q-args>)
  command! -nargs=? -complete=file TSvnUpdate call <SID>tsvn_command_do('update', <q-args>)

  command! -nargs=0 TSvnCommit call <SID>tsvn_command_do('commit', <q-args>)
endif

"""" }}}

" *****************************************************************************
"""" plugin/vcs_command.vim  {{{
function! s:vcs_get_cmdline(arguments)
  let args = a:arguments->copy()

  if has('win32')
    let args[0] = args[0] . '.exe'
  endif

  return join(args, ' ')
endfunction

function! s:vcs_get_files(repo, arguments)
  let root = finddir(a:repo, getcwd() . ';')
  let cwd = a:arguments[-1]->fnamemodify(':p')

  if !empty(root)
    let root = root->fnamemodify(':h')->substitute('\\$', '', '')
    let cwd = ((a:repo is# '.git') ? getcwd() : root)
  endif

  if !isdirectory(cwd)
    let cwd = getcwd()
  endif

  let cwd = cwd->fnamemodify(':p')
  let args = add(a:arguments, root)
  let cmdline = join(args, ' ')

  echomsg ' [listing...] ' . cmdline

  let cout = s:vcs_command(args)

" if has('iconv') && &termencoding != &encoding
"   let cout = iconv(cout, &termencoding, &encoding)
" endif

  return [ cmdline, cout->split('\n')
      \ ->map({ idx, val -> fnamemodify(cwd . val, ':p' ) })
      \ ->filter({ idx, val -> !isdirectory(val) })
      \ ->filter({ idx, val -> val !~ '/$'}) ]
endfunction

function! s:vcs_get_list(repo, arguments, errorformat, bang)
  let [ cmdline, files ] = s:vcs_get_files(a:repo, a:arguments)
  let what = #{
      \ lines: files,
      \ efm: a:errorformat,
      \ title: cmdline
      \ }

  call Vimrc_ListUp(what, a:bang)
endfunction

function! s:vcs_get_popup(repo, arguments)
  let [ _, files ] = s:vcs_get_files(a:repo, a:arguments)

  call Vimrc_Popup(files)
endfunction

function! s:vcs_get_output(arguments, extension)
  let cmdline = s:vcs_get_cmdline(a:arguments)

  silent! tab new

  execute('0r !' . cmdline)
  execute('setf ' . a:extension)

  setlocal buftype=nofile bufhidden=hide
  setlocal noswapfile nowrap nonumber
  setlocal nolist nobuflisted
endfunction

function! s:vcs_command(arguments)
  let cmdline = s:vcs_get_cmdline(a:arguments)

  if has('iconv') && &termencoding !=# &encoding
    return iconv(system(iconv(cmdline, &encoding, &termencoding)), &termencoding, &encoding)
  else
    return system(cmdline)
  endif
endfunction

"" subversion
if executable('svn')
  " svn ls --search [glob pattern]
  command! -nargs=*               SvnLsRootPopup call <SID>vcs_get_popup('.svn', [ 'svn', 'ls', '-R', <q-args> ])
  command! -nargs=* -complete=dir SvnLsPopup     call <SID>vcs_get_popup('', [ 'svn', 'ls', '-R', <q-args> ])

  command! -bang -nargs=* SvnLsRoot     call <SID>vcs_get_list('.svn', [ 'svn', 'ls', '-R', <q-args> ], '%f', '<bang>')
  command! -bang -nargs=* SvnStatusRoot call <SID>vcs_get_list('.svn', [ 'svn', 'status', <q-args> ], '%m\t%f', '<bang>')
  command! -bang -nargs=* SvnUpdateRoot call <SID>vcs_get_list('.svn', [ 'svn', 'update', <q-args> ], '%m\t%f', '<bang>')

  command! -bang -nargs=* -complete=dir SvnLs     call <SID>vcs_get_list('', [ 'svn', 'ls', <q-args> ], '%f', '<bang>')
  command! -bang -nargs=* -complete=dir SvnStatus call <SID>vcs_get_list('', [ 'svn', 'status', <q-args> ], '%m\t%f', '<bang>')
  command! -bang -nargs=* -complete=dir SvnUpdate call <SID>vcs_get_list('', [ 'svn', 'update', <q-args> ], '%m\t%f', '<bang>')

  command! -nargs=+ -complete=file SvnLog    call <SID>vcs_get_output(['svn', 'log', <q-args> ], 'log')
  command! -nargs=+ -complete=file SvnDiff   call <SID>vcs_get_output(['svn', 'diff', <q-args> ], 'diff')
  command! -nargs=+ -complete=file SvnBlame  call <SID>vcs_get_output(['svn', 'blame', '--force', <q-args> ], 'blame')
  command! -nargs=*                SvnHelp   call <SID>vcs_get_output(['svn', 'help', <q-args> ], 'txt')

  command! -nargs=+ -complete=file SvnAdd       call <SID>vcs_command([ 'svn', 'add', <q-args> ])
  command! -nargs=+ -complete=file SvnRevert    call <SID>vcs_command([ 'svn', 'revert', <q-args> ])
  command! -nargs=+ -complete=file SvnResolved  call <SID>vcs_command([ 'svn', 'resolved', <q-args> ])
endif

" git
if executable('git')
  command! -nargs=*                GitLsRootPopup call <SID>vcs_get_popup('.git', [ 'git', 'ls-files', <q-args> ])
  command! -nargs=* -complete=dir  GitLsPopup     call <SID>vcs_get_popup('', [ 'git', 'ls-files', <q-args> ])

  command! -bang -nargs=*                GitLsRoot call <SID>vcs_get_list('.git', [ 'git', 'ls-files', <q-args> ], '%f', '<bang>')
  command! -bang -nargs=* -complete=dir  GitLs     call <SID>vcs_get_list('', [ 'git', 'ls-files', <q-args> ], '%f', '<bang>')
  command! -bang -nargs=* -complete=dir  GitStatus call <SID>vcs_get_list('', [ 'git', 'status', '-s', <q-args> ], '%m\t%f', '<bang>')

  command! -nargs=+ -complete=file GitLog    call <SID>vcs_get_output(['git', 'log', <q-args> ], 'log')
  command! -nargs=+ -complete=file GitDiff   call <SID>vcs_get_output(['git', 'diff', <q-args> ], 'diff')
  command! -nargs=+ -complete=file GitBlame  call <SID>vcs_get_output(['git', 'blame', <q-args> ], 'blame')
  command! -nargs=*                GitHelpe  call <SID>vcs_get_output(['git', 'help', '-g', <q-args> ], 'txt')

  command! -nargs=+ -complete=file GitAdd       call <SID>vcs_command(['git', 'add', <q-args> ])
  command! -nargs=+ -complete=file GitRevert    call <SID>vcs_command(['git', 'revert', <q-args> ])
  command! -nargs=+ -complete=file GitResolved  call <SID>vcs_command(['git', 'resolved', <q-args> ])
endif

"""" }}}

" *****************************************************************************
"""" plugin/word_highlight.vim  {{{
" entries : { key(count): pattern }
let s:WordHighlight = #{
    \ colors: [
    \ "gui=bold ctermfg=16  ctermbg=153 guifg=#ffffff guibg=#0a7383",
    \ "gui=bold ctermfg=7   ctermbg=1   guibg=#a07040 guifg=#ffffff",
    \ "gui=bold ctermfg=7   ctermbg=2   guibg=#4070a0 guifg=#ffffff",
    \ "gui=bold ctermfg=7   ctermbg=3   guibg=#40a070 guifg=#ffffff",
    \ "gui=bold ctermfg=7   ctermbg=4   guibg=#70a040 guifg=#ffffff",
    \ "gui=bold ctermfg=7   ctermbg=5   guibg=#0070e0 guifg=#ffffff",
    \ "gui=bold ctermfg=7   ctermbg=6   guibg=#007020 guifg=#ffffff",
    \ "gui=bold ctermfg=7   ctermbg=21  guibg=#d4a00d guifg=#ffffff",
    \ "gui=bold ctermfg=7   ctermbg=22  guibg=#06287e guifg=#ffffff",
    \ "gui=bold ctermfg=7   ctermbg=45  guibg=#5b3674 guifg=#ffffff",
    \ "gui=bold ctermfg=7   ctermbg=16  guibg=#4c8f2f guifg=#ffffff",
    \ "gui=bold ctermfg=7   ctermbg=50  guibg=#1060a0 guifg=#ffffff",
    \ "gui=bold ctermfg=7   ctermbg=56  guibg=#a0b0c0 guifg=#000000",
    \ ],
    \ count: 0,
    \ entries: {}
    \ }

function! s:WordHighlight_Update(key) abort
  let tabnr = tabpagenr()
  let winnr = tabpagewinnr(tabnr)
  execute printf('tabdo windo call WordHighlight_Sync(%d) | tabn %d | %d wincmd w', a:key, tabnr, winnr)
endfunction

function! s:WordHighlight_Add(word) abort
  if a:word ==# '' | return | endif

  " check duplicated
  for pattern in values(s:WordHighlight.entries)
    if pattern ==# a:word | return | endif
  endfor

  let s:WordHighlight.count += 1
  let s:WordHighlight.entries[ s:WordHighlight.count ] = a:word

  call s:WordHighlight_Update(s:WordHighlight.count)
endfunction

function! s:WordHighlight_Delete() abort
  let key = inputlist(items(s:WordHighlight.entries)
      \ ->map({ idx, val -> printf("%d\t%s", val[0], val[1]) }))

  if has_key(s:WordHighlight.entries, key)
    call remove(s:WordHighlight.entries, key)
    call s:WordHighlight_Update(-1 * key)
  endif
endfunction

function! WordHighlight_Sync(key) abort
  " initialize
  " entries : { key(count): syntax-match-ID }
  if !has_key(w:, 'word_highlight_entries')
    let w:word_highlight_entries = {}

    for [key, val] in copy(s:WordHighlight.colors)->map({ idx, val -> [idx + 1, val] })
      execute printf('hi! WordHighlight%d %s', key, val)
    endfor
  endif

  if a:key == 0 " add/remove highlight of all entries
    if empty(s:WordHighlight.entries)
      for [key, id] in items(w:word_highlight_entries)
        call matchdelete(id)
      endfor

      let w:word_highlight_entries = {}

    else
      let len = len(s:WordHighlight.colors)

      for [key, val] in items(s:WordHighlight.entries)
        let w:word_highlight_entries[key] = matchadd(
            \ printf('WordHighlight%d', (key % len) + 1), val)
      endfor
    endif

  elseif a:key > 0  " add highlight of specify entry
    if !has_key(w:word_highlight_entries, a:key)
      let len = len(s:WordHighlight.colors)
      let w:word_highlight_entries[a:key] = matchadd(
          \ printf('WordHighlight%d', (a:key % len) + 1), s:WordHighlight.entries[a:key])
    endif

  else  " a:key < 0 : remove highlight of specify entry
    let key = -1 * a:key
    let id = get(w:word_highlight_entries, key, 0)

    if id > 0
      call remove(w:word_highlight_entries, key)
      call matchdelete(id)
    endif
  endif
endfunction

function! s:WordHighlight_Clear()
  let s:WordHighlight.entries = {}
  call s:WordHighlight_Update(0)
endfunction

command! -nargs=+ WordHLAdd    call s:WordHighlight_Add('<args>')
command! -nargs=0 WordHLDelete call s:WordHighlight_Delete()
command! -nargs=0 WordHLClear  call s:WordHighlight_Clear()

nnoremap <LocalLeader>wa <Esc>:WordHLAdd 
nnoremap <LocalLeader>ww <Esc>:WordHLAdd \<<C-r><C-w>\><CR>
nnoremap <LocalLeader>wd <Esc>:WordHLDelete<CR>
nnoremap <LocalLeader>wr <Esc>:WordHLClear<CR>

augroup plugin_autocmd_word_highlight
  autocmd!
  autocmd WinEnter * call WordHighlight_Sync(0)
augroup END

"""" }}}

" *****************************************************************************
"""" plugin/zen_han_ja.vim  {{{
let s:ZenHanJa_kana_dakuten = {
      \ 'saffix': 'ﾞ',
      \ 'han': 'ｳｶｷｸｹｺｻｼｽｾｿﾀﾁﾂﾃﾄﾊﾋﾌﾍﾎ',
      \ 'zen': 'ヴガギグゲゴザジズゼゾダヂヅデドバビブベボ'
      \ }
let s:ZenHanJa_kana_handakuten = {
      \ 'saffix': 'ﾟ',
      \ 'han': 'ﾊﾋﾌﾍﾎ',
      \ 'zen': 'パピプペポ'
      \ }
let s:ZenHanJa_kana = {
      \ 'saffix': '',
      \ 'han': 'ｦｧｨｩｪｫｬｭｮｯｰｱｲｳｴｵｶｷｸｹｺｻｼｽｾｿﾀﾁﾂﾃﾄﾅﾆﾇﾈﾉﾊﾋﾌﾍﾎﾏﾐﾑﾒﾓﾔﾕﾖﾗﾘﾙﾚﾛﾜﾝ',
      \ 'zen': 'ヲァィゥェォャュョッーアイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワン'
      \ }
let s:ZenHanJa_alpha = {
      \ 'saffix': '',
      \ 'han': 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz',
      \ 'zen': 'ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ'
      \ }
let s:ZenHanJa_number = {
      \ 'saffix': '',
      \ 'han': '0123456789',
      \ 'zen': '０１２３４５６７８９'
      \ }
let s:ZenHanJa_symbol = {
      \ 'saffix': '',
      \ 'han': '!"#$%&' . "'" . '()*+,-./:;<=>?@[\]^_`{|}~',
      \ 'zen': '！”＃＄％＆’（）＊＋，－．／：；＜＝＞？＠［￥］＾＿‘｛｜｝～'
      \ }

function! s:ZenHanJa_char_map(str, rule)
  return a:rule.to[index(a:rule.from, a:str)] . a:rule.saffix
endfunction

function! s:ZenHanJa_convert(text, rules)
  let l:text = a:text

  for l:rule in a:rules
    let l:text = substitute(l:text, l:rule.match, '\=s:ZenHanJa_char_map(submatch(1), l:rule)', 'g')
  endfor

  return l:text
endfunction

function! s:ZenHanJa_get_rule_to_han(context)
  return { 
        \ 'saffix': a:context.saffix,
        \ 'match': '\m\([' . a:context.zen . ']\)',
        \ 'from': split(a:context.zen, '\zs'),
        \ 'to': split(a:context.han, '\zs')
        \ }
endfunction

function! s:ZenHanJa_get_rule_to_zen(context)
  return { 
        \ 'saffix': '',
        \ 'match': '\m\([' . escape(a:context.han, '[]\-^$*.') . ']\)' . a:context.saffix,
        \ 'from': split(a:context.han, '\zs'),
        \ 'to': split(a:context.zen, '\zs')
        \ }
endfunction

function! s:ZenHanJa_get_rules(types, rule_maker)
  let l:rules = []

  if a:types =~# 'K'
    let l:rules += [
          \ a:rule_maker(s:ZenHanJa_kana_dakuten),
          \ a:rule_maker(s:ZenHanJa_kana_handakuten),
          \ a:rule_maker(s:ZenHanJa_kana)
          \ ]
  endif

  if a:types =~# 'A'
    call add(l:rules, a:rule_maker(s:ZenHanJa_alpha))
  endif

  if a:types =~# 'N'
    call add(l:rules, a:rule_maker(s:ZenHanJa_number))
  endif

  if a:types =~# 'S'
    call add(l:rules, a:rule_maker(s:ZenHanJa_symbol))
  endif

  return l:rules
endfunction

function! s:ZenHanJa_apply_rules(line_begin, line_end, rules)
  if empty(a:rules)
    return
  endif

  for l:lnum in range(a:line_begin, a:line_end)
    call setline(l:lnum, s:ZenHanJa_convert(getline(l:lnum), a:rules))
  endfor
endfunction

function! s:ZenHanJa_to_Hankaku(line_begin, line_end, types)
  let l:rules = s:ZenHanJa_get_rules(toupper(a:types), function('s:ZenHanJa_get_rule_to_han'))

  call s:ZenHanJa_apply_rules(a:line_begin, a:line_end, l:rules)
endfunction

function! s:ZenHanJa_to_Zenkaku(line_begin, line_end, types)
  let l:rules = s:ZenHanJa_get_rules(toupper(a:types), function('s:ZenHanJa_get_rule_to_zen'))

  call s:ZenHanJa_apply_rules(a:line_begin, a:line_end, l:rules)
endfunction

function! ZenHanJa_Complete(ArgLead, CmdLine, CursorPos)
  return [ 'K', 'A', 'N', 'S' ]
endfunction

command! -range -nargs=0 Hankaku  call s:ZenHanJa_to_Hankaku(<line1>, <line2>, 'KANS')
command! -range -nargs=0 HankakuK call s:ZenHanJa_to_Hankaku(<line1>, <line2>, 'K')
command! -range -nargs=0 HankakuA call s:ZenHanJa_to_Hankaku(<line1>, <line2>, 'AN')
command! -range -nargs=0 HankakuS call s:ZenHanJa_to_Hankaku(<line1>, <line2>, 'S')
command! -range -nargs=* -complete=customlist,ZenHanJa_Complete HankakuX call s:ZenHanJa_to_Hankaku(<line1>, <line2>, '<args>')

command! -range -nargs=0 Zenkaku  call s:ZenHanJa_to_Zenkaku(<line1>, <line2>, 'KANS')
command! -range -nargs=0 ZenkakuK call s:ZenHanJa_to_Zenkaku(<line1>, <line2>, 'K')
command! -range -nargs=0 ZenkakuA call s:ZenHanJa_to_Zenkaku(<line1>, <line2>, 'AN')
command! -range -nargs=0 ZenkakuS call s:ZenHanJa_to_Zenkaku(<line1>, <line2>, 'S')
command! -range -nargs=* -complete=customlist,ZenHanJa_Complete ZenkakuX call s:ZenHanJa_to_Zenkaku(<line1>, <line2>, '<args>')

"""" }}}

""""""""
runtime _local_*.vim

