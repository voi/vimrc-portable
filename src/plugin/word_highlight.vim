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
  if a:key == 0 " add/remove highlight of all entries
    " initialize
    " entries : { key(count): syntax-match-ID }
    if !has_key(w:, 'word_highlight_entries')
      let w:word_highlight_entries = {}

      for [key, val] in copy(s:WordHighlight.colors)->map({ idx, val -> [idx + 1, val] })
        execute printf('hi! WordHighlight%d %s', key, val)
      endfor
    endif

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

