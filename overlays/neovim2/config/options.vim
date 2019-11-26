scriptencoding utf-8

set path=.,**
set expandtab shiftwidth=2 softtabstop=-1
set fileformats=unix,dos
set termguicolors
set number
set mouse=a
set cursorline
set lazyredraw
set shortmess+=aoOtTIc
set noerrorbells
set novisualbell
set nowrap
set splitbelow
set splitright
set switchbuf=useopen,usetab
set signcolumn=yes
set tabline=%!functions#tabline()
set omnifunc=syntaxcomplete#Complete
set completefunc=syntaxcomplete#Complete
set completeopt+=menuone,noselect
set completeopt-=preview
set pumheight=12
set gdefault
set hlsearch|nohlsearch
set nostartofline
set sidescrolloff=5
set sidescroll=1
set diffopt+=context:3,indent-heuristic,algorithm:patience
set inccommand=nosplit
set timeoutlen=3000
set updatetime=100
set wildmode=longest:full,full
set helplang=en
set nospell
set spelllang=en_us
set fileformats=unix,dos,mac
set wildcharm=<C-Z>
set nobackup
set noswapfile
if !isdirectory($HOME."/.cache/undo-dir")
  call mkdir($HOME."/.cache/undo-dir", "", 0700)
endif
set undodir=~/.cache/undo-dir
set undofile
set list
set listchars=tab:›\ ,trail:•,extends:»,precedes:«,nbsp:‡
autocmd vimRc InsertEnter * set listchars-=trail:•
autocmd vimRc InsertLeave * set listchars+=trail:•

set statusline=
set statusline+=%{toupper(mode())}
set statusline+=%4c
set statusline+=\ %{expand('%:p:h:t')}/
set statusline+=%t
set statusline+=%h%r
set statusline+=\ %{exists('g:did_coc_loaded')?coc#status():''}
set statusline+=\ %m
set statusline+=%=
set statusline+=%{exists('g:loaded_conflicted')?ConflictedVersion():''}
set statusline+=\ %{exists('g:loaded_fugitive')?fugitive#head(5):''}
set statusline+=\ [%{&filetype!=#''?&filetype:''}]
