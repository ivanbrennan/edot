if exists("g:autoloaded_edot") || &cp
  finish
endif
let g:autoloaded_edot = 1

if !exists('g:edot_vimrc')
  let g:edot_vimrc = resolve($MYVIMRC)
  if empty(glob(g:edot_vimrc))
    let g:edot_vimrc = resolve($HOME . '/.vim/vimrc')
  endif
endif

if !exists('g:edot_vimdir')
  let g:edot_vimdir = resolve($HOME . '/.vim')
endif

func! edot#edit(...) abort
  call s:exec('edit %s', a:000)
endf

func! edot#source(...) abort
  call s:exec('source %s | filetype detect', a:000)
endf

func! s:exec(cmd, args) abort
  let file = len(a:args) ? s:path(a:args[0]) : g:edot_vimrc
  if empty(glob(file))
    call s:echoerr_novimrc()
  else
    exec printf(a:cmd, file)
  endif
endf

func! s:path(subpath) abort
  return g:edot_vimdir . '/' . a:subpath
endf

func! edot#list(arglead, _cmdline, _cursorpos) abort
  return map(globpath(g:edot_vimdir, a:arglead.'*', 0, 1), s:relative_path)
endf

let s:relative_path = { _idx, val -> fnamemodify(val,':p')[(s:prefix_len):] }
let s:prefix_len = len(g:edot_vimdir) + 1

func! s:echoerr_novimrc() abort
  echoerr 'Cannot infer vimrc location because $MYVIMRC was not set.'
        \ 'This happens when Vim was started with the `-u` option.'
        \ 'You can set g:edot_vimrc to fix this error.'
endf
