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

