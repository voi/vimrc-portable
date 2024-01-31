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
  if a:key is# 'i'
    let word = inputdialog('input include filter word.')
    if !empty(word)
      let a:ctx.active_lines = a:ctx.active_lines->filter({ idx, val -> val =~ word })
      call popup_settext(a:winid, a:ctx.active_lines)
    endif

  elseif a:key is# 'I'
    let word = inputdialog('input exclude filter word.')
    if !empty(word)
      let a:ctx.active_lines = a:ctx.active_lines->filter({ idx, val -> val !~ word })
      call popup_settext(a:winid, a:ctx.active_lines)
    endif

  elseif a:key is# 'f'
    let text = inputdialog('input fuzzy filter text.')
    if !empty(text)
      let a:ctx.active_lines = matchfuzzy(a:ctx.active_lines, text)
      call popup_settext(a:winid, a:ctx.active_lines)
    endif

  elseif a:key is# 'r'
    let a:ctx.active_lines = a:ctx.lines->copy()
    call popup_settext(a:winid, a:ctx.active_lines)

  elseif a:key is# "\<cr>"
    return s:Vimrc_popup_open_file(
        \ a:winid, 'edit', get(a:ctx.active_lines, line('.', a:winid) - 1, ''))

  elseif a:key is# "\<c-v>"
    return s:Vimrc_popup_open_file(
        \ a:winid, 'vsplit', get(a:ctx.active_lines, line('.', a:winid) - 1, ''))

  elseif a:key is# "\<c-s>"
    return s:Vimrc_popup_open_file(
        \ a:winid, 'split', get(a:ctx.active_lines, line('.', a:winid) - 1, ''))

  elseif a:key is# "\<c-t>"
    return s:Vimrc_popup_open_file(
        \ a:winid, 'tabedit', get(a:ctx.active_lines, line('.', a:winid) - 1, ''))

  endif

  return popup_filter_menu(a:winid, a:key)
endfunction

function! Vimrc_Popup(lines)
  if empty(a:lines) | echomsg '[Vimrc_Popup] no entries.' | return | endif
  let ctx = #{
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

