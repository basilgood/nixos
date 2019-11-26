scriptencoding utf-8

"""" highlight
function! functions#hl() abort
  echo join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'), '/')
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

" lazy load plugins
function! functions#packaddhandler(timer)
  execute 'packadd coc-nvim'
  execute 'packadd actionmenu.nvim'
  execute 'packadd vim-fugitive'
  execute 'packadd vim-conflicted'
  execute 'packadd vim-vinegar'
  execute 'packadd vim-renamer'
  execute 'packadd vim-dispatch'
  execute 'packadd skim'
  execute 'packadd skim-vim'
  execute 'packadd vim-editorconfig'
  execute 'packadd vim-surround'
  execute 'packadd vim-repeat'
  execute 'packadd tcomment_vim'
  execute 'packadd vim-easy-align'
  execute 'packadd vim-multiple-cursors'
  execute 'packadd vim-mergetool'
  execute 'packadd vcs-jump'
  execute 'packadd conflict-marker.vim'
  execute 'packadd auto-git-diff'
  execute 'packadd vim-html-template-literals'
  execute 'packadd undotree'
  execute 'packadd vim-indent-object'
  execute 'packadd quickfix-reflector-vim'
  execute 'packadd targets.vim'
  execute 'packadd wildfire.vim'
  execute 'packadd vim-edgemotion'
  execute 'packadd vim-cool'
  execute 'packadd vim-parenmatch'
  execute 'packadd vim-submode'
  execute 'packadd cmdline-completion'
  execute 'packadd ferret'
  doautocmd fugitive BufReadPost
  doautocmd plugin-editorconfig BufReadPost
endfunction
