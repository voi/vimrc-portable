function! s:PromptGrep_findReposRoot() abort
  let current = fnamemodify(getcwd(), ':p:h') . ';'
  let repos = map([ '.git', '.svn', '.bzr' ], { idx, val -> finddir(val, current) })

  return fnamemodify(repos[0], ':h')
endfunction

function! s:PromptGrep_search(bang, mode)
  let word = input('[grep pattern]: ', expand('<cword>'))
  if empty(word) | return | endif

  if a:mode is# 'vcs'
    let entry = s:PromptGrep_findReposRoot()
  else
    let entry = ''
  endif

  let entry = input('[grep entry]: ', entry, 'dir')
  if !empty(entry)
    execute printf('%svimgrep /%s/j %s', (empty(a:bang) ? '' : 'l'), word, entry)
  endif
endfunction

command -nargs=0 -bang PGrep call s:PromptGrep_search('<bang>', '')
command -nargs=0 -bang VCSGrep call s:PromptGrep_search('<bang>', 'vcs')

