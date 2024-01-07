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

