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

