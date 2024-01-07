let s:ZenHanJa_kana_dakuten = {
      \ 'saffix': 'ﾞ',
      \ 'han': 'ｳｶｷｸｹｺｻｼｽｾｿﾀﾁﾂﾃﾄﾊﾋﾌﾍﾎ',
      \ 'zen': 'ヴガギグゲゴザジズゼゾダヂヅデドバビブベボ'
      \ }
let s:ZenHanJa_kana_handakuten = {
      \ 'saffix': 'ﾟ',
      \ 'han': 'ﾊﾋﾌﾍﾎ',
      \ 'zen': 'パピプペポ'
      \ }
let s:ZenHanJa_kana = {
      \ 'saffix': '',
      \ 'han': 'ｦｧｨｩｪｫｬｭｮｯｰｱｲｳｴｵｶｷｸｹｺｻｼｽｾｿﾀﾁﾂﾃﾄﾅﾆﾇﾈﾉﾊﾋﾌﾍﾎﾏﾐﾑﾒﾓﾔﾕﾖﾗﾘﾙﾚﾛﾜﾝ',
      \ 'zen': 'ヲァィゥェォャュョッーアイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワン'
      \ }
let s:ZenHanJa_alpha = {
      \ 'saffix': '',
      \ 'han': 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz',
      \ 'zen': 'ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ'
      \ }
let s:ZenHanJa_number = {
      \ 'saffix': '',
      \ 'han': '0123456789',
      \ 'zen': '０１２３４５６７８９'
      \ }
let s:ZenHanJa_symbol = {
      \ 'saffix': '',
      \ 'han': '!"#$%&' . "'" . '()*+,-./:;<=>?@[\]^_`{|}~',
      \ 'zen': '！”＃＄％＆’（）＊＋，－．／：；＜＝＞？＠［￥］＾＿‘｛｜｝～'
      \ }

function! s:ZenHanJa_char_map(str, rule)
  return a:rule.to[index(a:rule.from, a:str)] . a:rule.saffix
endfunction

function! s:ZenHanJa_convert(text, rules)
  let l:text = a:text

  for l:rule in a:rules
    let l:text = substitute(l:text, l:rule.match, '\=s:ZenHanJa_char_map(submatch(1), l:rule)', 'g')
  endfor

  return l:text
endfunction

function! s:ZenHanJa_get_rule_to_han(context)
  return { 
        \ 'saffix': a:context.saffix,
        \ 'match': '\m\([' . a:context.zen . ']\)',
        \ 'from': split(a:context.zen, '\zs'),
        \ 'to': split(a:context.han, '\zs')
        \ }
endfunction

function! s:ZenHanJa_get_rule_to_zen(context)
  return { 
        \ 'saffix': '',
        \ 'match': '\m\([' . escape(a:context.han, '[]\-^$*.') . ']\)' . a:context.saffix,
        \ 'from': split(a:context.han, '\zs'),
        \ 'to': split(a:context.zen, '\zs')
        \ }
endfunction

function! s:ZenHanJa_get_rules(types, rule_maker)
  let l:rules = []

  if a:types =~# 'K'
    let l:rules += [
          \ a:rule_maker(s:ZenHanJa_kana_dakuten),
          \ a:rule_maker(s:ZenHanJa_kana_handakuten),
          \ a:rule_maker(s:ZenHanJa_kana)
          \ ]
  endif

  if a:types =~# 'A'
    call add(l:rules, a:rule_maker(s:ZenHanJa_alpha))
  endif

  if a:types =~# 'N'
    call add(l:rules, a:rule_maker(s:ZenHanJa_number))
  endif

  if a:types =~# 'S'
    call add(l:rules, a:rule_maker(s:ZenHanJa_symbol))
  endif

  return l:rules
endfunction

function! s:ZenHanJa_apply_rules(line_begin, line_end, rules)
  if empty(a:rules)
    return
  endif

  for l:lnum in range(a:line_begin, a:line_end)
    call setline(l:lnum, s:ZenHanJa_convert(getline(l:lnum), a:rules))
  endfor
endfunction

function! s:ZenHanJa_to_Hankaku(line_begin, line_end, types)
  let l:rules = s:ZenHanJa_get_rules(toupper(a:types), function('s:ZenHanJa_get_rule_to_han'))

  call s:ZenHanJa_apply_rules(a:line_begin, a:line_end, l:rules)
endfunction

function! s:ZenHanJa_to_Zenkaku(line_begin, line_end, types)
  let l:rules = s:ZenHanJa_get_rules(toupper(a:types), function('s:ZenHanJa_get_rule_to_zen'))

  call s:ZenHanJa_apply_rules(a:line_begin, a:line_end, l:rules)
endfunction

function! ZenHanJa_Complete(ArgLead, CmdLine, CursorPos)
  return [ 'K', 'A', 'N', 'S' ]
endfunction

command! -range -nargs=0 Hankaku  call s:ZenHanJa_to_Hankaku(<line1>, <line2>, 'KANS')
command! -range -nargs=0 HankakuK call s:ZenHanJa_to_Hankaku(<line1>, <line2>, 'K')
command! -range -nargs=0 HankakuA call s:ZenHanJa_to_Hankaku(<line1>, <line2>, 'AN')
command! -range -nargs=0 HankakuS call s:ZenHanJa_to_Hankaku(<line1>, <line2>, 'S')
command! -range -nargs=* -complete=customlist,ZenHanJa_Complete HankakuX call s:ZenHanJa_to_Hankaku(<line1>, <line2>, '<args>')

command! -range -nargs=0 Zenkaku  call s:ZenHanJa_to_Zenkaku(<line1>, <line2>, 'KANS')
command! -range -nargs=0 ZenkakuK call s:ZenHanJa_to_Zenkaku(<line1>, <line2>, 'K')
command! -range -nargs=0 ZenkakuA call s:ZenHanJa_to_Zenkaku(<line1>, <line2>, 'AN')
command! -range -nargs=0 ZenkakuS call s:ZenHanJa_to_Zenkaku(<line1>, <line2>, 'S')
command! -range -nargs=* -complete=customlist,ZenHanJa_Complete ZenkakuX call s:ZenHanJa_to_Zenkaku(<line1>, <line2>, '<args>')

