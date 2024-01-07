function! s:vcs_get_cmdline(arguments)
  let args = a:arguments->copy()

  if has('win32')
    let args[0] = args[0] . '.exe'
  endif

  return join(args, ' ')
endfunction

function! s:vcs_job_out_cb(cwd, msg, lines)
  if has('iconv') && &termencoding != &encoding
    let out = iconv(a:msg, &termencoding, &encoding)
  else
    let out = a:msg
  endif

  call extend(a:lines, split(out, '\n')
      \ ->map({ idx, val -> fnamemodify(a:cwd . val, ':p' ) })
      \ ->filter({ idx, val -> !isdirectory(val) })
      \ ->filter({ idx, val -> val !~ '/$'})
      \ )
endfunction

function! s:vcs_get_files(repo, arguments, Handler)
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
  let lines = []

  call job_start(
      \ s:vcs_get_cmdline(args),
      \ {
      \   'out_cb': { ch, msg -> s:vcs_job_out_cb(cwd, msg, lines) },
      \   'close_cb': { ch -> a:Handler(lines) }
      \ })
  echomsg ' [listing...] ' . join(args, ' ')
endfunction

function! s:vcs_get_list_cb(arguments, errorformat, bang, lines)
  call Vimrc_ListUp(#{ lines: a:lines, efm: a:errorformat, title: join(a:arguments, ' ') }, a:bang)
endfunction

function! s:vcs_get_list(repo, arguments, errorformat, bang)
  call s:vcs_get_files(a:repo, a:arguments,
      \ function('s:vcs_get_list_cb', [ a:arguments, a:errorformat, a:bang ]))
endfunction

function! s:vcs_get_popup(repo, arguments)
  call s:vcs_get_files(a:repo, a:arguments, function('Vimrc_Popup'))
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

