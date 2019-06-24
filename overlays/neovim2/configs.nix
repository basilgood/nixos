{ ag, fzf, fd, nixfmt, python27Packages, vim-vint, editorconfig-core-c }:
# vim: set syntax=vim:
''
    " git.
    nnoremap [fugitive]  <Nop>
    nmap <space>g [fugitive]
    nnoremap <silent> [fugitive]s :<C-u>vertical Gstatus<CR>
    nnoremap <silent> [fugitive]c :<C-u>Gcommit<CR>
    nnoremap <silent> [fugitive]C :<C-u>Gcommit --amend<CR>
    nnoremap <silent> [fugitive]a :<C-u>Dispatch! git add %<CR>
    nnoremap <silent> [fugitive]r :<C-u>Dispatch! git reset %<CR>
    nnoremap <silent> [fugitive]D :<C-u>Dispatch! git checkout -- %<CR>
    nnoremap <silent> [fugitive]p :<C-u>Dispatch! git push<CR>
    nnoremap <silent> [fugitive]P :<C-u>Dispatch! git push -f<CR>
    nnoremap <silent> [fugitive]d :<C-u>Gvdiffsplit<CR>
    nnoremap <silent> [fugitive]l :<C-u>GV --all<CR>
    nnoremap <silent> [fugitive]m :<C-u>Twiggy<CR>

    function! InFugitive() abort
    nmap <buffer> zp :<c-u>Dispatch! git push<CR>
    nmap <buffer> zF :<c-u>Dispatch! git push -f<CR>
    nmap <buffer> zf :<c-u>Dispatch! git fetch --all --prune<CR>
    nmap <buffer> zr :<c-u>Dispatch! git pull --rebase --autostash<CR>
    endfunction

    autocmd vimRc FileType fugitive call InFugitive()

    " undotree.
    let g:undotree_WindowLayout = 4
    let g:undotree_SetFocusWhenToggle = 1
    let g:undotree_ShortIndicators = 1
    nnoremap <leader>u :UndotreeToggle<cr>

    " surround.
    let surround_indent=1
    nmap S ysiw

  " editorconfig.
  let g:editorconfig_root_chdir = 1
  let g:editorconfig_verbose    = 1
  let g:editorconfig_blacklist  = {
  \ 'filetype': ['git.*', 'fugitive'],
  \ 'pattern': ['\.un~$']}

  " netrw
  let g:netrw_bufsettings         = 'nomodifiable nomodified relativenumber nowrap readonly nobuflisted hidden'
  let g:netrw_sort_dotfiles_first = 1
  let g:netrw_altfile             = 1
  let g:netrw_dirhistmax          = 0

  augroup in_netrw
  autocmd!
  autocmd FileType netrw call functions#innetrw()
  augroup END

  " fzf plugin
  let $FZF_DEFAULT_COMMAND='${fd}/bin/fd --type f --hidden --follow --exclude .git'
  let $FZF_DEFAULT_OPTS = '--layout=reverse'
  let g:fzf_layout = { 'window': 'call OpenFloatingWin()' }
  function! OpenFloatingWin()
  let height = &lines - 3
  let width = float2nr(&columns - (&columns * 2 / 10))
  let col = float2nr((&columns - width) / 2)

  let opts = {
  \ 'relative': 'editor',
  \ 'row': height * 0.3,
  \ 'col': col + 30,
  \ 'width': width * 2 / 3,
  \ 'height': height / 2
  \ }

  let buf = nvim_create_buf(v:false, v:true)
  let win = nvim_open_win(buf, v:true, opts)

  hi FloatTermNormal term=None guibg=#1f292e
  call setwinvar(win, '&winhl', 'Normal:FloatTermNormal')

  setlocal
  \ buftype=nofile
  \ nobuflisted
  \ bufhidden=hide
  \ nonumber
  \ norelativenumber
  \ signcolumn=no
  endfunction

  function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
  endfunction

  let g:buffer_action = {
    \ 'ctrl-x': 'sb',
    \ 'ctrl-v': 'vsp|b',
    \ 'ctrl-w': 'bdelete'
    \}

    function! BufferSink(lines)
    if len(a:lines)<2
    return
    endif
    let key = remove(a:lines, 0)
    let Cmd = get(g:buffer_action, key,'buffer')
    for line in a:lines
    let bid = matchstr(line, '^[ 0-9]*')
    execute Cmd bid
    endfor
    endfunction

  nnoremap <silent> <C-p> :Files<CR>
  noremap <silent> <Bs> :call fzf#run(fzf#wrap({
    \ 'source':  reverse(<sid>buflist()),
    \ 'sink*':  function('BufferSink'),
    \ 'options': '-m --expect='.join(keys(buffer_action), ',')
    \ }))<CR>
    nnoremap <silent> <leader>] :History:<cr>

    " markdown
    let g:markdown_fenced_languages = ['html', 'vim', 'javascript', 'python', 'bash=sh']

    " startify
    nnoremap [Space]q :SC<cr>
    let g:startify_files_number        = 5
    let g:startify_change_to_dir       = 0
    let g:startify_enable_special      = 0
    let g:startify_update_oldfiles     = 1
    let g:startify_session_dir         = '~/.cache/nvim/session'

    if !exists('g:startify_bookmarks')
    let g:startify_bookmarks = []
    endif

  let g:startify_lists = [
  \ { 'type': 'dir',       'header': ['   Recent files'] },
  \ { 'type': 'sessions',  'header': ['   Sessions'], 'indices': ['A','B','C'] },
  \ ]

  let g:startify_custom_header = []
  function! s:save_session() abort
  if !empty(v:this_session) && get(g:, 'startify_session_persistence')
  call startify#session_write(v:this_session)
  endif
  endfunction

  augroup session_startify
  autocmd!
  autocmd BufNewFile,BufAdd,BufDelete,BufLeave * call s:save_session()
  augroup END

  " easy-align.
  nmap ga <Plug>(EasyAlign)
  xmap ga <Plug>(EasyAlign)

  " wildfire.
  let g:wildfire_objects = [ 'iw', 'il', "i'", "a'", 'i"', 'i)', 'a)', 'i]', 'a]', 'i}', 'a}', 'i<', 'a<', 'ip', 'it']
  let g:wildfire_fuel_map = '+'
  let g:wildfire_water_map = '-'
  nmap <leader>s <Plug>(wildfire-quick-select)

  " edgemotion
  map <C-j> <Plug>(edgemotion-j)
  map <C-k> <Plug>(edgemotion-k)

  " nixfmt
  command! -nargs=0 NixFormat silent! execute "!${nixfmt}/bin/nixfmt %"
''
