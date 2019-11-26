scriptencoding utf-8

"""" coc
let g:coc_global_extensions = [
      \ 'coc-tabnine',
      \ 'coc-word',
      \ 'coc-emmet',
      \ 'coc-yank',
      \ 'coc-tsserver',
      \ 'coc-css',
      \ 'coc-stylelint',
      \ 'coc-html',
      \ 'coc-lit-html',
      \ 'coc-json',
      \ 'coc-go',
      \ 'coc-git',
      \ 'coc-eslint',
      \ 'coc-prettier',
      \ 'coc-yaml',
      \ 'coc-vimlsp'
      \ ]

nmap <silent> [[ <Plug>(coc-diagnostic-prev)
nmap <silent> ]] <Plug>(coc-diagnostic-next)
nmap <silent> [h <Plug>(coc-git-prevchunk)
nmap <silent> ]h <Plug>(coc-git-nextchunk)
nmap <silent> gs <Plug>(coc-git-chunkinfo)
nmap <silent> gm <Plug>(coc-git-commit)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gI <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gQ <Plug>(coc-format-selected)
vmap <silent> gQ <Plug>(coc-format-selected)
nmap <silent> <F2> <Plug>(coc-rename)
imap <silent> <C-l> <Plug>(coc-snippets-expand)
imap <silent> <C-j> <Plug>(coc-snippets-expand-jump)
vmap <silent> <C-j> <Plug>(coc-snippets-select)
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

augroup coc_group
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

command! -nargs=0 Format :call CocAction('format')

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "<C-n>" :
      \ Check_back_space() ? "<Tab>" :
      \ coc#refresh()
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<cr>"

function! Check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

"""" actionmenu
let s:code_actions = []

func! ActionMenuCodeActions() abort
  let s:code_actions = CocAction('codeActions')
  let l:menu_items = map(copy(s:code_actions), { index, item -> item['title'] })
  call actionmenu#open(l:menu_items, 'ActionMenuCodeActionsCallback')
endfunc

func! ActionMenuCodeActionsCallback(index, item) abort
  if a:index >= 0
    let l:selected_code_action = s:code_actions[a:index]
    let l:response = CocAction('doCodeAction', l:selected_code_action)
  endif
endfunc
nnoremap <silent> <Leader>z :call ActionMenuCodeActions()<CR>
