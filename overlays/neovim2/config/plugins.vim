scriptencoding utf-8

"""" neomake
let g:neomake_warning_sign = {
      \ 'text': '_w',
      \ }
let g:neomake_error_sign = {
      \ 'text': '_e',
      \ }
augroup my_neomake
  au!
  autocmd FileType nix call neomake#configure#automake_for_buffer('nw', 1000)
augroup END

"""" git.
nnoremap [git]  <Nop>
nmap <space>g [git]
nnoremap <silent> [git]s :<C-u>vertical Gstatus<CR>
nnoremap <silent> [git]d :<C-u>Gvdiffsplit!<CR>

function! InFugitive() abort
  nmap <buffer> zp :<c-u>Dispatch! git push<CR>
  nmap <buffer> zF :<c-u>Dispatch! git push -f<CR>
endfunction

autocmd vimRc FileType fugitive call InFugitive()

"""" mergetool
let g:mergetool_layout = 'bmr'
nmap [git]m <plug>(MergetoolToggle)
nmap <expr> <C-Left> &diff? '<Plug>(MergetoolDiffExchangeLeft)' : '<C-Left>'
nmap <expr> <C-Right> &diff? '<Plug>(MergetoolDiffExchangeRight)' : '<C-Right>'
nmap <expr> <C-Down> &diff? '<Plug>(MergetoolDiffExchangeDown)' : '<C-Down>'
nmap <expr> <C-Up> &diff? '<Plug>(MergetoolDiffExchangeUp)' : '<C-Up>'
if &diff == 1
  vmap <silent> <buffer> dg :diffget<CR>
  vmap <silent> <buffer> dp :diffput<CR>
  nmap <silent> <buffer> dg V:diffget<CR>
  nmap <silent> <buffer> dp V:diffput<CR>
endif

"""" undotree.
let g:undotree_WindowLayout = 4
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1
nnoremap <leader>u :UndotreeToggle<cr>

"""" surround.
let surround_indent=1
nmap S ysiw

"""" editorconfig.
let g:editorconfig_root_chdir = 1
let g:editorconfig_verbose    = 1
let g:editorconfig_blacklist  = {
      \ 'filetype': ['git.*', 'fugitive'],
      \ 'pattern': ['\.un~$']}

"""" netrw
let g:netrw_bufsettings         = 'nomodifiable nomodified relativenumber nowrap readonly nobuflisted hidden'
let g:netrw_sort_dotfiles_first = 1
let g:netrw_altfile             = 1
let g:netrw_dirhistmax          = 0

function! s:innetrw() abort
  nnoremap <buffer> D <Nop>
  nmap <buffer> <right> <cr>
  nmap <buffer> <left> -
  nmap <buffer> J j<cr>
  nmap <buffer> K k<cr>
  nmap <buffer> qq :bn<bar>bd#<cr>
  nmap <buffer> D !rm -rf
endfunction

augroup in_netrw
  autocmd!
  autocmd FileType netrw call s:innetrw()
augroup END

"""" skim(fzf)
let $SKIM_DEFAULT_COMMAND = 'fd --type f --hidden --follow --exclude .git'
let $SKIM_DEFAULT_OPTS = '--bind ctrl-f:toggle'

nnoremap <C-p> :Files<CR>
nnoremap <C-t> :Files %:h<CR>
nnoremap <silent> <leader>] :History:<cr>

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

noremap <silent> <Bs> :call skim#run(skim#wrap({
      \ 'source':  reverse(<sid>buflist()),
      \ 'sink*':  function('BufferSink'),
      \ 'options': '-m --expect='.join(keys(buffer_action), ',')
      \ }))<CR>

command! -bang -nargs=* Ag call fzf#vim#ag_interactive(<q-args>, fzf#vim#with_preview('down:50%', 'alt-h'))

"""" markdown
let g:markdown_fenced_languages = ['html', 'vim', 'javascript', 'python', 'bash=sh']

"""" easy-align.
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

"""" wildfire.
let g:wildfire_objects = [ 'iw', 'il', "i'", "a'", 'i"', 'i)', 'a)', 'i]', 'a]', 'i}', 'a}', 'i<', 'a<', 'ip', 'it']
let g:wildfire_fuel_map = '+'
let g:wildfire_water_map = '-'
nmap <leader>s <Plug>(wildfire-quick-select)

"""" edgemotion
map <C-j> <Plug>(edgemotion-j)
map <C-k> <Plug>(edgemotion-k)

"""" cool
let g:CoolTotalMatches = 1
