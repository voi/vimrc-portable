augroup vimrc_autocmd_user_syntax
  autocmd!
  autocmd VimEnter,WinEnter * hi def Bold gui=bold
      \ | hi def DateTime gui=bold,underline
      \ | call matchadd('DateTime', '[12]0\d\{2}-\%(1[0-2]\|0[1-9]\)-\%(3[01]\|[12][0-9]\|0[1-9]\)')
      \ | call matchadd('DateTime', '[12]0\d\{2}\/\%(1[0-2]\|0[1-9]\)\/\%(3[01]\|[12][0-9]\|0[1-9]\)')
      \ | call matchadd('DateTime', '\%(2[0-3]\|[0-1][0-9]\):\%([0-5][0-9]\)\%(:\%([0-5][0-9]\)\%(\.\d\{1,3}\)\?\)\?')

  autocmd FileType c,cpp
      \   syn keyword Type __int16 __int32 __int64 __fastcall
      \ | syn keyword Type int16_t uint16_t int32_t uint32_t int64_t uint64_t
      \ | syn keyword Typedef BYTE WORD DWORD SHORT USHORT LONG ULONG LONGLONG ULONGLONG
      \ | syn keyword Typedef WPARAM LPARAM WINAPI UINT_PTR
      \ | syn keyword Boolean BOOL TRUE FALSE

  autocmd FileType c,cpp,cs,java,javascript 
      \   syn match Operator /\s\zs[+\-\*\/<>=|&]\ze\s/
      \ | syn match Operator /;/
      \ | syn match Operator /[<>!=~+\-\*\/]=/
      \ | syn match Operator /||\|&&\|++\|--/
      \ | syn match Operator /::\ze\w/
      \ | syn match Operator /\>[\*&]/
      \ | syn match Operator /\*\</
      \ | syn match Operator /[!&]\s*\</
      \ | syn match Operator /[!&]\s*\ze(/
      \ | syn match Operator /\%(->\|\.\)\</
      " \ | syn match Bold /[{}]/

  autocmd FileType log 
      \ | syn match LogDumpNonZero /\<\%([13-9A-F]0\|\x[1-9A-F]\)\>/
      \ | syn match LogDumpZero    /\<00\>/
      \ | syn match LogDumpSpace   /\<20\>/
      \ | syn match LogErrWord     /\cERR\%[OR]/
      \ | hi def link LogDumpZero    SpecialKey
      \ | hi def link LogDumpNonZero String
      \ | hi def link LogDumpSpace   Comment
      \ | hi def link LogErrWord     Error

augroup END

