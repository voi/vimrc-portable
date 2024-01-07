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

