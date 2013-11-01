"-------------------------------------------------------------------------------
" NCL indent file
" Language: NCL
" Author: Hiroaki Ohtake (oahiroaki@gmail.com)
"-------------------------------------------------------------------------------

if exists("g:did_indent")
  finish
endif

setlocal autoindent
setlocal indentexpr=GetNCLIndent()
setlocal indentkeys+==end,=else

let b:undo_indent = 'setlocal '.join([
\   'autoindent<',
\   'expandtab',
\   'indentkeys<',
\   'indentexpr<',
\   'shiftwidth<',
\   'softtabstop<',
\ ])

setlocal expandtab
setlocal tabstop<
setlocal softtabstop=2
setlocal shiftwidth=2

let s:cpo_save = &cpo
set cpo&vim

function! s:isInCommentOrString(lnum, i)
  return synIDattr(synID(a:lnum, a:i + 2, 1), "name") !~ '\(NCLComment\|NCLString\)$'
endfunction

function! GetNCLIndent()
  let lnum = prevnonblank(v:lnum - 1)

  if lnum == 0
    return 0
  endif

  let ind = indent(lnum)

  " Add indent
  if getline(lnum) =~? '\v^\s*%(begin|do|if|setvalues|getvalues)'
    let ind = ind + &sw
  endif

  " obj = create obj_name
  "   resource : value
  " end craete
  if getline(lnum) =~? '\v.+create\s+'
    let ind = ind + &sw
  endif

  " Minus indent
  if getline('.') =~? '\v^\s*%(end|else)'
    let ind = ind - &sw
  endif

  return ind
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save

let b:did_indent = 1
