if exists("g:loaded_edot") || &cp
  finish
endif
let g:loaded_edot = 1

command! -complete=customlist,edot#list -nargs=? EdotEdit   call edot#edit(<f-args>)
command! -complete=customlist,edot#list -nargs=? EdotSource call edot#source(<f-args>)

nnoremap <silent> <Plug>(edot_edit)    :EdotEdit 
nnoremap <silent> <Plug>(edot_edit!)   :EdotEdit<CR>
nnoremap <silent> <Plug>(edot_source)  :EdotSource 
nnoremap <silent> <Plug>(edot_source!) :EdotSource<CR>
