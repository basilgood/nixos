set encoding=utf-8
scriptencoding utf-8

augroup vimRc
  autocmd!
augroup END

" better defaults
set path& | let &path .= '**'
set gdefault
set autowrite
set copyindent
set preserveindent
set expandtab
set smarttab
set softtabstop=2
set tabstop=2
set shiftwidth=2
set shiftround
set noswapfile
set nobackup
set undofile
set number
set mouse=a
set shortmess+=IOF
set sidescrolloff=10
set sidescroll=1
set switchbuf+=useopen,usetab
set splitbelow
set splitright
set nowrap
set completeopt-=preview
set completeopt+=menuone,noselect,noinsert
set complete=.,w,b,u,U,t,i,d,k
set pumheight=10
set diffopt+=context:3,indent-heuristic,algorithm:patience,iwhite
set timeoutlen=3000
set updatetime=50
set wildmode=longest:full,full
set wildignorecase
set wildignore=
      \*/node_modules/*,
      \*/bower_components/*,
      \*/vendor/*,
      \*/plugged/*,
      \*/.gem/*,
      \*/.git/*,
      \*/.hg/*,
      \*/.svn/*
set wildcharm=<C-Z>
set list
set listchars=tab:›\ ,trail:•,extends:»,precedes:«,nbsp:‡
autocmd vimRc InsertEnter * set listchars-=trail:•
autocmd vimRc InsertLeave * set listchars+=trail:•

" grep
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading
endif
set grepformat^=%f:%l:%c:%m

" statusline
set statusline=%<%f\ %h%#error#%m%*%r%=%-14.(%l\:%c%)%{&filetype}

" mappings
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <esc><esc> :update<cr>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
inoremap <C-a> <Home>
inoremap <C-e> <End>
nnoremap } }zz
nnoremap { {zz
nnoremap vv viw

" tab complete
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR>    pumvisible() ? "\<C-Y>" : "\<CR>"

" lists
nnoremap ]l :lnext<cr>
nnoremap [l :lprevious<cr>
nnoremap ]q :cnext<cr>
nnoremap [q :cprevious<cr>
nnoremap ]Q :clast<cr>
nnoremap [Q :cfirst<cr>
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

" niceblock
xnoremap <expr> I (mode()=~#'[vV]'?'<C-v>^o^I':'I')
xnoremap <expr> A (mode()=~#'[vV]'?'<C-v>0o$A':'A')

" innerline
xnoremap <silent> il <Esc>^vg_
onoremap <silent> il :<C-U>normal! ^vg_<cr>

" entire
xnoremap <silent> ie gg0oG$
onoremap <silent> ie :<C-U>execute "normal! m`"<Bar>keepjumps normal! ggVG<cr>

" disable EX-mode
nnoremap Q <Nop>

" execute macro
nnoremap Q @q

" Run macro on selected lines
vnoremap Q :norm Q<cr>

" yank to clipboard
vnoremap <space>y "+y

" yank and keep cursor position
vnoremap <expr>y "my\"" . v:register . "y`y"

" paste from clipboard
nnoremap [Space] <Nop>
xnoremap [Space] <Nop>
onoremap [Space] <Nop>
nmap     <Space> [Space]
xmap     <Space> [Space]
omap     <Space> [Space]
nnoremap [Space]p :put+<cr>
vnoremap [Space]p "+p
nnoremap [Space]P :put!+<cr>
vnoremap [Space]P "+P
nnoremap [Space]w viw"+p

" Paste continuously.
nnoremap ]p viw"0p
vnoremap P "0p

" substitute.
nnoremap [subst] <Nop>
nmap   s [subst]
xmap   s [subst]
nnoremap [subst]s :%s/
nnoremap [subst]l :s/
xnoremap [subst]  :s/
nnoremap [subst]a :<c-u>%s/\C\<<c-r><c-w>\>/<c-r><c-w>
nnoremap [subst]w :<C-u>%s/\C\<<C-R><C-w>\>//g<Left><Left>
nnoremap [subst]n *``cgn

" git commands
nnoremap <silent> <expr> <space>dt ":\<C-u>"."windo ".(&diff?"diffoff":"diffthis")."\<CR>"

" enhanced <c-g>
nnoremap <silent> <C-g> :file<Bar>echon ' ' system("git rev-parse --abbrev-ref HEAD 2>/dev/null \| tr -d '\n'")<CR>

" hlsearch
nnoremap <silent>n n
nnoremap <silent>N N

" vim-visual-star-search
nnoremap <silent> * *``
xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>``
function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

" CTRL-L to fix syntax highlight
nnoremap <silent><expr> <C-l> empty(get(b:, 'current_syntax'))
      \ ? "\<C-l>"
      \ : "\<C-l>:syntax sync fromstart\<cr>:nohlsearch<cr>"

" find conflict markers
nnoremap <silent> ]m /^\(<\{7\}\\|>\{7\}\\|=\{7\}\\|\|\{7\}\)\( \\|$\)<cr>

"" autocmds
" hlyank
autocmd vimRc TextYankPost * silent! lua require'vim.highlight'.on_yank('Visual', 200)
" format
autocmd vimRc BufRead,BufNewFile *.js,*.jsx,*.ts,*.tsx command! F silent call system('prettier --trailing-comma all --single-quote --write ' . expand('%:h'))
autocmd vimRc BufRead,BufNewFile *.nix command! F silent call system('nixpkgs-fmt ' . expand('%:h'))

" large files
let g:large_file = 10485760 " 10MB
autocmd vimRc BufReadPre *
      \ let f=expand("<afile>") |
      \ if getfsize(f) > g:large_file |
      \ set eventignore+=FileType |
      \ setlocal noswapfile bufhidden=unload buftype=nowrite undolevels=-1 |
      \ else |
      \ set eventignore-=FileType |
      \ endif

" qf and help keep widow full width
autocmd vimRc FileType qf wincmd J
autocmd vimRc BufWinEnter * if &ft == 'help' | wincmd J | end

" update diff
autocmd vimRc InsertLeave * if &l:diff | diffupdate | endif

" detect filetype on save
autocmd vimRc BufWritePost * if &filetype ==# '' | filetype detect | endif

" external changes
autocmd vimRc FocusGained,CursorHold * if !bufexists("[Command Line]") | checktime | GitGutter | endif

" omnicomplete
autocmd vimRc Filetype *
      \ if &omnifunc == "" |
      \   setlocal omnifunc=syntaxcomplete#Complete |
      \ endif

" mkdir
autocmd vimRc BufWritePre *
      \ if !isdirectory(expand('%:h', v:true)) |
      \   call mkdir(expand('%:h', v:true), 'p') |
      \ endif

" jump to last known position
autocmd vimRc BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif

autocmd vimRc BufNewFile,BufRead *.nix        setfiletype nix
autocmd vimRc BufNewFile,BufRead *.jsx        setfiletype javascript
autocmd vimRc BufNewFile,BufRead *.js         setfiletype javascript
autocmd vimRc BufNewFile,BufRead *.tsx        setfiletype typescript
autocmd vimRc BufNewFile,BufRead *.ts         setfiletype typescript
autocmd vimRc BufNewFile,BufRead *.gitignore  setfiletype gitignore
autocmd vimRc BufNewFile,BufRead *.twig       setfiletype twig.html
autocmd vimRc BufNewFile,BufRead config       setfiletype config
autocmd vimRc BufNewFile,BufRead *.less       setfiletype less
autocmd vimRc BufNewFile,BufRead *.sass       setfiletype sass
autocmd vimRc BufNewFile,BufRead *.scss       setfiletype scss
autocmd vimRc BufNewFile,BufRead *.toml       setfiletype toml
autocmd vimRc BufNewFile,BufRead *.coffee     setfiletype coffeescript
autocmd vimRc BufNewFile,BufRead .babelrc     setfiletype json
autocmd vimRc BufNewFile,BufRead *.json       setfiletype json
autocmd vimRc BufNewFile,BufRead Dockerfile.* setfiletype Dockerfile
autocmd vimRc BufNewFile,BufRead *.txt        setfiletype markdown
autocmd vimRc BufNewFile,BufRead *.md         setfiletype markdown
autocmd vimRc BufNewFile,BufRead *.mkd        setfiletype markdown
autocmd vimRc BufNewFile,BufRead *.markdown   setfiletype markdown
autocmd vimRc BufWinEnter *.json setlocal conceallevel=0 concealcursor=
autocmd vimRc BufReadPre *.json  setlocal conceallevel=0 concealcursor=
autocmd vimRc BufReadPre *.json  setlocal formatoptions=
autocmd vimRc FileType git       setlocal nofoldenable
autocmd vimRc BufNewFile,BufRead *.lock   setfiletype config

" commands
command! -nargs=0 WS %s/\s\+$// | normal! ``
function! Hlgroup() abort
  echo join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'), '/')
endfunction
command! HL call Hlgroup()
command! -nargs=1 TV
      \ call system('tmux split-window -h '.<q-args>)
command! -nargs=1 TN
      \ call system('tmux new-window '.<q-args>)
command! TA TV tig --all
command! TS TV tig status

autocmd vimRc BufRead,BufNewFile *.nix command! F silent call system('nixpkgs-fmt ' . expand('%'))
autocmd vimRc BufRead,BufNewFile *.js,*.jsx,*.ts,*.tsx command! F silent call system('prettier --single-quote --write ' . expand('%'))
autocmd vimRc FileType yaml command! F silent call system('prettier --write ' . expand('%'))
autocmd vimRc FileType sh command! F silent call system('shfmt -i 2 -ci -w ' . expand('%'))
autocmd vimRc FileType json command! F silent FixJson
