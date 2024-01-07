function! s:Vimrc_HighlightPlus() abort
  " ime
  hi CursorIM gui=NONE guifg=#FFFFFF guibg=#8000FF ctermbg=White ctermbg=Red

  if !has('gui_running')
    hi clear CursorLine
    hi CursorLine term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE
  endif

  " statusline
  hi StatusLine_Modes      guifg=#030303 guibg=#FFFFFF ctermfg=Black ctermbg=White
  hi StatusLine_CursorPos  guifg=#FFFFFF guibg=#333399 ctermfg=White ctermbg=DarkBlue

  hi StatusLine_Normal     guifg=#FFFFFF guibg=#0000FF ctermfg=White ctermbg=Blue
  hi StatusLine_Insert     guifg=#FFFFFF guibg=#009944 ctermfg=White ctermbg=Green
  hi StatusLine_Replace    guifg=#FFFFFF guibg=#9933A3 ctermfg=White ctermbg=Cyan
  hi StatusLine_Visual     guifg=#FFFFFF guibg=#F20000 ctermfg=White ctermbg=Red
  hi StatusLine_Select     guifg=#030303 guibg=#F2F200 ctermfg=Black ctermbg=Yellow

  "
  hi link TrailingSpace NonText

  if &g:background ==# 'dark'
    hi clear SpecialKey
    hi SpecialKey   guifg=#808080  guibg=NONE    gui=NONE       ctermfg=grey
    hi ZenkakuSpace guifg=darkgrey               gui=underline  ctermfg=darkgrey cterm=underline
    hi Normal       guifg=#f0f0f0  guibg=#404042 gui=NONE
    hi NormalNC     guifg=#808080  guibg=#606060
    hi Comment      guifg=#cccccc  guibg=NONE    gui=italic     ctermfg=grey

  else
    hi clear SpecialKey
    hi SpecialKey   guifg=#cccccc  guibg=NONE    gui=NONE       ctermfg=grey
    hi ZenkakuSpace guifg=grey                   gui=underline  ctermfg=grey cterm=underline
    hi Normal       guifg=#030303  guibg=#f0f0f0 gui=NONE
    hi NormalNC     guifg=#cccccc  guibg=#dddddd
    hi Comment      guifg=#808080  guibg=NONE    gui=italic     ctermfg=darkgrey

    " based vim-kalisi
    if has('gui_running')
      hi Constant         guifg=#0000af guibg=NONE    gui=bold
      hi String           guifg=#0060a0 guibg=NONE
      hi Character        guifg=#9054c7 guibg=NONE    gui=bold
      hi Number           guifg=#0070c0 guibg=NONE
      hi Boolean          guifg=#66b600 guibg=NONE    gui=none
      hi Float            guifg=#00a0a0 guibg=NONE

      hi Identifier       guifg=#202090 guibg=NONE    gui=none
      hi Function         guifg=#1177dd               gui=none

      hi Statement        guifg=#66b600 guibg=NONE    gui=bold
      hi Conditional      guifg=#1177dd guibg=NONE    gui=bold
      hi Repeat           guifg=#1177dd guibg=NONE    gui=none
      hi Label            guifg=#007700               gui=bold
      hi Operator         guifg=#274aac guibg=NONE    gui=none
      hi Exception        guifg=#005090 guibg=NONE    gui=bold

      hi PreProc          guifg=#d80050 guibg=NONE    gui=bold
      hi Include          guifg=#d80050 guibg=NONE    gui=none
      hi Define           guifg=#d80050 guibg=NONE    gui=bold
      hi Macro            guifg=#d80000 guibg=NONE    gui=none
      hi PreCondit        guifg=#1177dd               gui=none

      hi Type             guifg=#f47300 guibg=NONE    gui=none

      hi StorageClass     guifg=#0000d7               gui=italic
      hi Structure        guifg=#274aac guibg=NONE    gui=none
      hi Typedef          guifg=#274aac               gui=italic

      hi Special          guifg=#ffaf00 guibg=NONE    gui=bold
      hi SpecialChar      guifg=#F92672               gui=bold
      hi Tag              guifg=#0010ff               gui=underline
      hi Delimiter        guifg=#d80050 guibg=NONE    gui=none
      hi Debug            guifg=#ddb800 guibg=NONE    gui=bold

      hi Underlined       guifg=#202020 guibg=NONE    gui=underline

      hi Error            guifg=#d80000 guibg=#ffff00 gui=bold,underline
      hi ErrorMsg         guifg=#d80000 guibg=#ffff00 gui=bold

      " Misc syntax ###############################################################
      hi Todo             guifg=#ff0000 guibg=#eeee00 gui=bold

      hi Directory        guifg=#0060a0 guibg=NONE    gui=NONE
      hi Keyword          guifg=#66b600               gui=none
      hi Title            guifg=#1060a0 guibg=NONE    gui=bold
      hi NonText          guifg=#000000 guibg=#e6e6e6 gui=none

      hi Conceal          guifg=#acacac

      hi DiffAdd                        guibg=#ddffdd 
      hi DiffChange                     guibg=#ffdddd 
      hi DiffText         guifg=#000055 guibg=#ddddff
      hi DiffDelete       guifg=#6c6c6c guibg=#cccccc

      hi SpellBad         guisp=#d80000 gui=undercurl
      hi SpellCap         guisp=#274aac gui=undercurl
      hi SpellLocal       guisp=#006600 gui=undercurl
      hi SpellRare        guisp=#a7a755 gui=undercurl

      " User interface ############################################################
      hi Visual                         guibg=#d0eeff gui=NONE
      hi VisualNOS                      guibg=#d8d8d8 gui=none

      hi Cursor           guifg=#f0f0f0 guibg=#ff0000 gui=bold
      hi CursorLineNr     guifg=#606060 guibg=#fc8484 gui=bold
      hi Cursorline                     guibg=#eaeaea
      hi CursorColumn                   guibg=#eaeaea
      hi MatchParen       guifg=#ffffff guibg=#ffd030 gui=none

      hi Search           guifg=#303030 guibg=#b8ea00 gui=bold
      hi IncSearch        guifg=#f8cf00 guibg=#303030

      hi LineNr           guifg=#606060 guibg=#c0c0c0 gui=NONE

      hi VertSplit        guifg=#a0a0a0 guibg=#a0a0a0 gui=NONE
      hi Folded           guifg=#606060 guibg=#d8d8d8 gui=NONE
      hi FoldColumn       guifg=#707070 guibg=#b0b0b0 gui=bold

      hi WildMenu         guifg=#000000 guibg=#b6eB39 gui=none
      hi Question         guifg=#000000 guibg=#b6eB39 gui=none
      hi MoreMsg          guifg=#000000 guibg=#b6eB39 gui=none

      hi ModeMsg          guifg=#000000 guibg=#A6DB29
      hi WarningMsg       guifg=#d82020 guibg=NONE    gui=bold

      hi TabLine          guifg=#afd700 guibg=#005f00 gui=none
      hi TabLineSel       guifg=#005f00 guibg=#afd700 gui=none
      hi TabLineFill      guifg=#303030 guibg=#a0a0a0 gui=none

      hi SignColumn       guifg=#A6E22E guibg=#c9c4c4

      hi Pmenu            guifg=#303030 guibg=#c6db29 gui=NONE
      hi PmenuSel         guifg=#d0d0d0 guibg=#638514 gui=bold
      hi PmenuSbar                      guibg=#a0a0a0
      hi PmenuThumb                     guibg=#555555
    endif
  endif

  "
  call matchadd('ZenkakuSpace', '　')
  call matchadd('TrailingSpace', '\s\{2,\}$')
endfunction

augroup vimrc_autocmd_colors_highlight
  autocmd!
  autocmd VimEnter,WinEnter,ColorScheme * call <SID>Vimrc_HighlightPlus()
augroup END

