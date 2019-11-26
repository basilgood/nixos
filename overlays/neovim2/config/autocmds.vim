scriptencoding utf-8

"""" If a file is large, disable syntax highlighting, filetype etc
let g:LargeFile = 20*1024*1024 " 20MB
function! Large_file(name) abort
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
autocmd vimRc BufReadPre *
      \ let s = getfsize(expand("<afile>")) |
      \ if s > g:LargeFile || s == -2 |
      \   call Large_file(fnamemodify(expand("<afile>"), ":p")) |
      \ endif

"""" don't list location-list / quickfix windows
autocmd vimRc BufReadPost quickfix setlocal nobuflisted
autocmd vimRc BufReadPost quickfix nnoremap <buffer> gq :bd<CR>
autocmd vimRc FileType help nnoremap <buffer> gq :bd<CR>
autocmd vimRc CmdwinEnter * nnoremap <silent><buffer> gq :<C-u>quit<CR>

"""" qf and help keep widow full width
autocmd vimRc FileType qf wincmd J
autocmd vimRc BufWinEnter * if &ft == 'help' | wincmd J | end

"""" update diff
autocmd vimRc InsertLeave * if &l:diff | diffupdate | endif

"""" external changes
autocmd vimRc FocusGained,CursorHold * if !bufexists("[Command Line]") | checktime | endif

"""" mkdir
function! Mkdirifnotexist() abort
  let dir = expand('%:p:h')
  if dir =~# '://'
    return
  endif
  if !isdirectory(dir)
    call mkdir(dir, 'p')
    echo 'Created non-existing directory: '.dir
  endif
endfunction
autocmd vimRc BufWritePre * call Mkdirifnotexist()

"""" remember_position
autocmd vimRc BufReadPost * if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

"""" cursorline
autocmd vimRc InsertLeave,WinEnter * setlocal cursorline
autocmd vimRc InsertEnter,WinLeave * setlocal nocursorline

"""" fugitive files
autocmd vimRc FileType git setlocal nofoldenable

"""" filetype
autocmd vimRc BufNewFile,BufRead *.nix setlocal filetype=nix
autocmd vimRc BufNewFile,BufRead *.js setlocal filetype=javascript
autocmd vimRc BufNewFile,BufRead *.jsx setlocal filetype=javascript
autocmd vimRc BufNewFile,BufRead *.twig setlocal filetype=html.twig
autocmd vimRc BufNewFile,BufRead *.svelte setlocal filetype=svelte
autocmd vimRc BufRead,BufNewFile *.gitignore  setlocal filetype=gitignore
autocmd vimRc BufNewFile,BufRead *.vim setlocal filetype=vim
autocmd vimRc BufNewFile,BufRead *.html setlocal filetype=html
autocmd vimRc BufNewFile,BufRead *.yamllint setlocal filetype=yaml
autocmd vimRc BufNewFile,BufRead *.yml setlocal filetype=yaml
autocmd vimRc BufRead,BufNewFile *.md,.markdown setlocal filetype=markdown
autocmd vimRc BufReadPre,BufNewFile *.j2 setlocal filetype=jinja
autocmd vimRc BufReadPre,BufNewFile *.twig setlocal filetype=twig.html
autocmd vimRc BufReadPre,BufNewFile *.coffee setlocal filetype=coffee
autocmd vimRc BufReadPre,BufNewFile *.ts,*.tsx setlocal filetype=typescript
autocmd vimRc BufWinEnter *.json setlocal conceallevel=0 concealcursor=
autocmd vimRc BufReadPre *.json setlocal conceallevel=0 concealcursor=
autocmd vimRc BufReadPre *.json setlocal formatoptions=a2tq
autocmd vimRc FileType json syntax match Comment +\/\/.\+$+
autocmd vimRc FileType jsonc setlocal commentstring=//\ %s
