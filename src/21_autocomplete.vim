function! Vimrc_AutoComplete_Key(chr)
  return a:chr . ( pumvisible() ? '' : "\<C-X>\<C-P>\<C-N>")
endfunction

for k in split("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_",'\zs')
  exec printf("imap <silent> <expr> %s Vimrc_AutoComplete_Key('%s')", k, k)
endfor

