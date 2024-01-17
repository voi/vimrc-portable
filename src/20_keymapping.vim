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
inoreabbr -date- <C-r>=strftime('%Y-%m-%d')<CR>
inoreabbr /date/ <C-r>=strftime('%Y/%m/%d')<CR>
inoreabbr -time- <C-r>=strftime('%H:%M')<CR>
inoreabbr -full- <C-r>=strftime('%Y-%m-%dT%H:%M')<CR>
inoreabbr /full/ <C-r>=strftime('%Y/%m/%dT%H:%M')<CR>

