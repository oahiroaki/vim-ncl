"-------------------------------------------------------------------------------
"NCL indent file
"Language: NCL
"Author: Hiroaki Ohtake (oahiroaki@gmail.com)
"        University of AIZU
"-------------------------------------------------------------------------------
if exists("g:did_indent")
  finish
endif

setlocal autoindent
setlocal indentexpr=NCLIndent()
setlocal indentkeys=!^F,o,O

setlocal expandtab
setlocal tabstop<
setlocal softtabstop=2
setlocal shiftwidth=2

function! NCLIndent()
  let plnum = prevnonblank(v:lnum - 1)
  if getline(plnum) =~# '\v^\s*<begin>'
    return indent(plnum) + &l:shiftwidth
  endif
endfunction

let b:did_indent = 1
