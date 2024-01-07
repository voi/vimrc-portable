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

