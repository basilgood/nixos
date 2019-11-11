scriptencoding utf-8

"""" large file (lifepillar)
function! functions#large_file(name) abort
  let b:large_file = 1
  syntax clear
  set eventignore+=FileType
  let &backupskip .= ',' . a:name
  setlocal foldmethod=manual nofoldenable noswapfile noundofile norelativenumber
  augroup large_buffer
    autocmd!
    autocmd BufWinEnter <buffer> call <sid>restore_eventignore()
  augroup END
endfunction

function! s:restore_eventignore() abort
  set eventignore-=FileType
  autocmd! large_buffer
  augroup! large_buffer
endfunction

"""" highlight
function! functions#hl() abort
  echo join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'), '/')
endfunction

" search highlight
function! functions#hlnext() abort
  let l:higroup = matchend(getline('.'), '\c'.@/, col('.')-1) == col('.')
        \ ? 'SpellRare' : 'IncSearch'
  let b:cur_match = matchadd(l:higroup, '\c\%#'.@/, 101)
  redraw
  augroup HLNext
    autocmd CursorMoved <buffer>
          \   execute 'silent! call matchdelete('.b:cur_match.')'
          \ | redraw
          \ | autocmd! HLNext
  augroup END
endfunction

function! s:StartHL()
  silent! if v:hlsearch && !search('\%#\zs'.@/,'cnW')
  call <SID>StopHL()
endif
endfunction

function! s:StopHL()
  if ! v:hlsearch || mode() !=? 'n'
    return
  else
    silent call feedkeys("\<Plug>(StopHL)", 'm')
  endif
endfunction

function! functions#togglehl(old, new)
  if a:old == 0 && a:new == 1
    " nohls --> hls
    "   set up
    noremap  <expr> <Plug>(StopHL) execute('nohlsearch')[-1]
    noremap! <expr> <Plug>(StopHL) execute('nohlsearch')[-1]

    autocmd hlsearch CursorMoved * call <SID>StartHL()
    autocmd hlsearch InsertEnter * call <SID>StopHL()
  elseif a:old == 1 && a:new == 0
    " hls --> nohls
    "   tear down
    nunmap <expr> <Plug>(StopHL)
    unmap! <expr> <Plug>(StopHL)

    autocmd! hlsearch CursorMoved
    autocmd! hlsearch InsertEnter
  else
    " nohls --> nohls
    "   do nothing
    return
  endif
endfunction

"""" mkdir if not exists
function! functions#mkdirifnotexist() abort
  let dir = expand('%:p:h')
  if dir =~# '://'
    return
  endif
  if !isdirectory(dir)
    call mkdir(dir, 'p')
    echo 'Created non-existing directory: '.dir
  endif
endfunction

" netrw
function! functions#innetrw() abort
  nnoremap <buffer> D <Nop>
  nmap <buffer> <right> <cr>
  nmap <buffer> <left> -
  nmap <buffer> J j<cr>
  nmap <buffer> K k<cr>
  nmap <buffer> qq :bn<bar>bd#<cr>
  nmap <buffer> D !rm -rf
endfunction

"""" tabline
function! functions#tabline() abort
  let s = ''
  for i in range(tabpagenr('$'))
    let tab = i + 1
    let winnr = tabpagewinnr(tab)
    let buflist = tabpagebuflist(tab)
    let bufnr = buflist[winnr - 1]
    let bufname = bufname(bufnr)
    let bufmodified = getbufvar(bufnr, '&mod')
    let s .= '%' . tab . 'T'
    let s .= (tab == tabpagenr() ? '%#StatusLine#' : '%#StatusLineNC#')
    let s .= ' ' . tab .':'
    let s .= (bufname !=# '' ? fnamemodify(bufname, ':t') . ' ' : 'No Name ')
    if bufmodified
      let s .= '[+] '
    endif
  endfor

  let s .= '%#TabLineFill#'
  if (exists('g:tablineclosebutton'))
    let s .= '%=%999XX'
  endif
  return s
endfunction

"""" visual select star search
function! functions#get_selected_text() abort
  let tmp = @"
  normal! gvy
  normal! gv
  let [tmp, @"] = [@", tmp]
  return tmp
endfunction

function! functions#plain_text_pattern(s) abort
  return substitute(substitute('\V'.escape(a:s, '\'), '\n', '\\n', 'g'), '\t', '\\t', 'g')
endfunction

function! functions#get_search_pat() abort
  return functions#plain_text_pattern(functions#get_selected_text())
endfunction

" submode
function! SubMode()
  call submode#enter_with('resize', 'n', '', '<C-W>>', '<C-W>>')
  call submode#enter_with('resize', 'n', '', '<C-W><', '<C-W><')
  call submode#map('resize', 'n', '', '.', '<C-W>>')
  call submode#map('resize', 'n', '', ',', '<C-W><')
  call submode#enter_with('resize', 'n', '', '<C-W>-', '<C-W>-')
  call submode#enter_with('resize', 'n', '', '<C-W>+', '<C-W>+')
  call submode#map('resize', 'n', '', '-', '<C-W>-')
  call submode#map('resize', 'n', '', '=', '<C-W>+')
  call submode#leave_with('resize', 'n', '', '<Esc>')
  call submode#enter_with('scroll-h', 'n', '', 'zl', 'zl')
  call submode#enter_with('scroll-h', 'n', '', 'zh', 'zh')
  call submode#enter_with('scroll-h', 'n', '', 'zL', 'zL')
  call submode#enter_with('scroll-h', 'n', '', 'zH', 'zH')
  call submode#map('scroll-h', 'n', '', 'l', 'zl')
  call submode#map('scroll-h', 'n', '', 'h', 'zh')
  call submode#map('scroll-h', 'n', '', 'L', 'zL')
  call submode#map('scroll-h', 'n', '', 'H', 'zH')
endfunction

" lazy load plugins
function! functions#packaddhandler(timer)
  execute 'packadd coc-nvim'
  execute 'packadd neomake'
  execute 'packadd actionmenu.nvim'
  execute 'packadd vim-fugitive'
  execute 'packadd gv.vim'
  execute 'packadd vim-conflicted'
  execute 'packadd vim-vinegar'
  execute 'packadd vim-dispatch'
  execute 'packadd skim'
  execute 'packadd skim-vim'
  execute 'packadd vim-editorconfig'
  execute 'packadd vim-surround'
  execute 'packadd vim-repeat'
  execute 'packadd vim-commentary'
  execute 'packadd vim-easy-align'
  execute 'packadd vim-mergetool'
  execute 'packadd vcs-jump'
  execute 'packadd auto-git-diff'
  execute 'packadd vim-nix'
  execute 'packadd vim-javascript'
  execute 'packadd vim-jsx-pretty'
  execute 'packadd vim-html-template-literals'
  execute 'packadd vim-coffee-script'
  execute 'packadd vim-jinja'
  execute 'packadd vim-markdown'
  execute 'packadd vim-json'
  execute 'packadd jsonc.vim'
  execute 'packadd vim-go'
  execute 'packadd yats-vim'
  execute 'packadd rust-vim'
  execute 'packadd twig-vim'
  execute 'packadd undotree'
  execute 'packadd vim-indent-object'
  execute 'packadd quickfix-reflector-vim'
  execute 'packadd vim-startify'
  execute 'packadd targets.vim'
  execute 'packadd wildfire.vim'
  execute 'packadd vim-edgemotion'
  execute 'packadd vim-cool'
  execute 'packadd vim-parenmatch'
  execute 'packadd vim-submode'
  execute 'packadd vim-multiple-cursors'
  execute 'packadd vim-twiggy'
  execute 'packadd cmdline-completion'
  execute 'packadd ferret'
  doautocmd fugitive BufReadPost
  call SubMode()
endfunction
