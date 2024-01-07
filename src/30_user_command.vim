" command! -nargs=? -complete=filetype Temp 
"     \ execute printf('tabe %s_%s | setf %s', tempname(), strftime('%Y-%m-%d_%H-%M-%S'),
"     \   ('<args>' ==# '' ? (&filetype ==# 'qf' ? 'text' : &filetype) : '<args>'))

"" <http://d.hatena.ne.jp/fuenor/20100115/1263551230>
command! -nargs=+ -bang -complete=file Rename
    \ let pbnr=fnamemodify(bufname('%'), ':p') | exec 'f '.escape(<q-args>, ' ') | w<bang> | call delete(pbnr)

command! -bang BufClear bufdo bw<bang>

command! -bang BufOnly 
    \ let bnrs = join(filter(range(1, bufnr('$')), {
    \   idx, val -> bufexists(val) && val != bufnr('%')
    \ }), ' ') |
    \ if bnrs !=# '' | execute 'bw<bang> ' . bnrs | endif

command! -bang BufTidyUp 
    \ let bnrs = range(1, bufnr('$'))
    \   ->filter({ idx, val -> bufexists(val) && bufloaded(val) })
    \   ->filter({ idx, val -> get(get(getbufinfo(val), 0, {}), 'hidden', 0) })
    \   ->join(' ') |
    \ if bnrs !=# '' | execute 'bw<bang> ' . bnrs | endif

" command! -nargs=1 -complete=dir LcdX
"     \ execute 'lcd ' . fnamemodify(<f-args>, ':p',)

