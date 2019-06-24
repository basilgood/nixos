pkgs:
# vim: set syntax=vim:
''
  " coc
  let g:coc_global_extensions = [
    \ 'coc-tsserver',
    \ 'coc-eslint',
    \ 'coc-emmet',
    \ 'coc-css',
    \ 'coc-stylelint',
    \ 'coc-html',
    \ 'coc-lit-html',
    \ 'coc-json',
    \ 'coc-go',
    \ 'coc-git',
    \ 'coc-yaml',
    \ 'coc-vimlsp',
    \ 'coc-webpack',
    \ 'coc-yank'
    \ ]

  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)
  nmap [c <Plug>(coc-git-prevchunk)
  nmap ]c <Plug>(coc-git-nextchunk)
  nmap gs <Plug>(coc-git-chunkinfo)
  nmap gm <Plug>(coc-git-commit)
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  nmap <leader>rn <Plug>(coc-rename)
  xmap <leader>f  <Plug>(coc-format-selected)
  nmap <leader>f  <Plug>(coc-format-selected)

  augroup coc_group
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  command! -nargs=0 Format :call CocAction('format')

  " completion
  inoremap <silent><expr> <Tab>
        \ pumvisible() ? "\<C-n>" :
        \ Check_back_space() ? "\<Tab>" :
        \ coc#refresh()
  inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<cr>"
  " tab completion
  function! Check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
  endfunction
''
