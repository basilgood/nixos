{ vim_configurable
, vimPlugins
, vimUtils
, python3
, fetchFromGitHub
, lib
, nodejs
, nodePackages
, nixpkgs-fmt
, vim-vint
, shfmt
, wl-clipboard
, fzf
, fd
, ripgrep
, git
, buildEnv
}:
let
  cfgConcat = builtins.concatStringsSep "\n\"\"\" Section\n\n";

  baseCfg = ''
    unlet! skip_defaults_vim
    silent! source $VIMRUNTIME/defaults.vim

    if &encoding !=? 'utf-8'
      let &termencoding = &encoding
      setglobal encoding=utf-8
    endif

    scriptencoding utf-8

    augroup vimRc
      autocmd!
    augroup END
  '';

  optionsCfg = ''
    set nobackup
    set noswapfile

    set undodir=/tmp,.
    set undofile

    if exists('$TMUX')
      set term=xterm-256color
    endif
    set t_Co=256
    set t_ut=
    set t_md=

    let &t_SI.="\e[5 q"
    let &t_SR.="\e[4 q"
    let &t_EI.="\e[1 q"

    set viminfo=!,'300,<50,s10,h,n~/.cache/viminfo
    set path& | let &path .= '**'
    set nostartofline
    set nowrap
    set virtualedit=block
    set synmaxcol=200
    set sidescrolloff=10
    set sidescroll=1
    let &showbreak = '↳ '
    set breakat=\ \ ;:,!?
    set breakindent
    set breakindentopt=sbr
    set display=lastline
    set incsearch
    set hlsearch|nohlsearch
    set gdefault
    set switchbuf+=useopen,usetab
    set splitright
    set splitbelow
    set completeopt-=preview
    set completeopt+=menuone,noselect,noinsert
    set complete=.,w,b,u,U,t,i,d,k
    set pumheight=10
    set diffopt+=vertical,context:3,indent-heuristic,algorithm:patience
    set nrformats-=octal
    set number
    set mouse=a
    set ttymouse=sgr
    set backspace=indent,eol,start
    set history=200
    set list
    set listchars=tab:›\ ,trail:•,extends:»,precedes:«,nbsp:⣿
    autocmd vimRc InsertEnter * set listchars-=trail:•
    autocmd vimRc InsertLeave * set listchars+=trail:•
    set confirm
    set shortmess+=IOF
    set autoindent
    set copyindent
    set preserveindent
    set softtabstop=2
    set tabstop=2
    set shiftwidth=2
    set expandtab
    set autoread
    set autowrite
    set helplang=en
    set spelllang=en_us
    set history=1000
    set wildmenu
    set wildmode=longest:list,full
    set wildoptions=tagfile
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
    set ttimeout
    set ttimeoutlen=100
    set lazyredraw
    set updatetime=50
    if executable('rg')
      set grepprg=rg\ --vimgrep\ --no-heading
    endif
    set grepformat^=%f:%l:%c:%m
    set laststatus=2
    set statusline=%<%f\ %h%#error#%m%*%r%=%-14.(%l\:%c%)%{&filetype}
  '';

  mappingsCfg = ''
    nnoremap <leader><leader> :update<cr>
    nnoremap <silent> j gj
    nnoremap <silent> k gk
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

    " paste from clipboard
    xmap <space>y "+y
    xnoremap "+y y:call system("wl-copy", @")<cr>
    nnoremap <space>p :let @"=substitute(system("wl-paste -n"), '<C-v><C-m>', ''', 'g')<cr>:put<cr>
    nnoremap <space>P :let @"=substitute(system("wl-paste -n"), '<C-v><C-m>', ''', 'g')<cr>:put!<cr>
    nnoremap <space>w diw:let @"=substitute(system("wl-paste -n"), '<C-v><C-m>', ''', 'g')<cr>P
    xnoremap <space>p d:let @"=substitute(system("wl-paste -n"), '<C-v><C-m>', ''', 'g')<cr>P

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
    xnoremap * "*y<Esc>/<c-r>=substitute(escape(@*, '\/.*$^~[]'), "\n", '\\n', "g")<cr><cr>N

    " CTRL-L to fix syntax highlight
    nnoremap <silent><expr> <C-l> empty(get(b:, 'current_syntax'))
          \ ? "\<C-l>"
          \ : "\<C-l>:syntax sync fromstart\<cr>:nohlsearch<cr>"

    " find conflict markers
    nnoremap <silent> ]m /^\(<\{7\}\\|>\{7\}\\|=\{7\}\\|\|\{7\}\)\( \\|$\)<cr>
  '';

  extraPlugins = with vimUtils; {
    altscreen = buildVimPluginFrom2Nix {
      name = "altscreen";
      src = fetchFromGitHub {
        owner = "fcpg";
        repo = "vim-altscreen";
        rev = "127fc8ec2b450fe41ee207c06b126ebedcbbbf3e";
        hash = "sha256-NH7Vt5yTxOKC9dQkeg/joFYUq0IMZd1BOvX3nN7wjps=";
      };
    };

    diffconflicts = buildVimPluginFrom2Nix {
      name = "diffconflicts";
      src = fetchFromGitHub {
        owner = "whiteinge";
        repo = "diffconflicts";
        rev = "205e0e09ee0ae859590f846ea921c8d7f1d4e91d";
        hash = "sha256-SnhogtLBv/KIJc3aKBV0B2BMV0m10piRO6p0q1/NZT0=";
      };
    };

    hlyank = buildVimPluginFrom2Nix {
      name = "hlyank";
      src = fetchFromGitHub {
        owner = "markonm";
        repo = "hlyank.vim";
        rev = "39e52017f53344a4fbdac00a9153a8ca32017f43";
        hash = "sha256-B5PZfZBHWWARnNLty+IV2VFLAbOga5opnt0uBwUUMrw=";
      };
    };

    cmdline-completion = buildVimPluginFrom2Nix {
      name = "cmdline-completion";
      src = fetchFromGitHub {
        owner = "vim-scripts";
        repo = "cmdline-completion";
        rev = "8a7d0820e69c06710ef239f0ddb645ac9d328f85";
        hash = "sha256-ZzaTpIKEr6hw/oFXjT3SyhOpfmFZRK9ZlFuuo1mnDzw=";
      };
    };

    min = buildVimPluginFrom2Nix {
      name = "min";
      src = fetchFromGitHub {
        owner = "basilgood";
        repo = "min.vim";
        rev = "61eacb680dadb764a98222baef244bed002ae6e6";
        hash = "sha256-9pzwXpnezn2Js78JJSYitF5ofmLlrpk3Ws4ch3IBLLU=";
      };
    };
  };

  vinegarCfg = ''
    autocmd vimRc BufEnter * execute 'packadd vim-vinegar'
    let g:netrw_bufsettings = 'nomodifiable nomodified relativenumber nowrap readonly nobuflisted'
    let g:netrw_altfile = 1
    let g:netrw_altv = 1
    let g:netrw_preview = 1
    let g:netrw_alto = 0
    let g:netrw_use_errorwindow = 0
    function! Innetrw() abort
      nmap <buffer> <right> <cr>
      nmap <buffer> <left> -
    endfunction
    autocmd vimRc FileType netrw call Innetrw()
  '';

  fzfCfg = ''
    autocmd vimRc BufReadPost *
          \ execute 'packadd fzfWrapper'

    let g:fzf_buffers_jump = 1
    nnoremap <silent> <c-p> :call fzf#run(fzf#vim#with_preview({
      \ 'source': 'fd --type f --hidden --follow --exclude ".git"',
      \ 'sink': 'e',
      \ 'down': '~30%',
      \ 'options': '-m --bind=ctrl-a:select-all,ctrl-d:deselect-all'
      \ }))<cr>
    nnoremap <silent> <bs> :Buffers<cr>

    function! RipgrepFzf(query, fullscreen)
      let command_fmt = 'rg --column --line-number --no-heading --color=always --hidden --smart-case -g "!.git" %s || true'
      let initial_command = printf(command_fmt, shellescape(a:query))
      let reload_command = printf(command_fmt, '{q}')
      let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
      call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
    endfunction

    command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)
  '';

  fugitiveCfg = ''
    autocmd vimRc CmdlineEnter *
          \ execute 'packadd vim-fugitive'
    nnoremap [git]  <Nop>
    nmap <space>g [git]
    nnoremap <silent> [git]s :<C-u>vertical Gstatus<cr>
    nnoremap <silent> [git]d :<C-u>Gvdiffsplit!<cr>gg
    nnoremap <silent> [git]l :<C-u>vertical Git --paginate log --oneline --graph --decorate --all<cr>
  '';

  gitgutterCfg = ''
    let g:gitgutter_sign_priority = 8
    let g:gitgutter_override_sign_column_highlight = 0
    nmap ghs <Plug>(GitGutterStageHunk)
    nmap ghu <Plug>(GitGutterUndoHunk)
    nmap ghp <Plug>(GitGutterPreviewHunk)
  '';

  merginalCfg = ''
    nnoremap <space>m :packadd vim-merginal<cr>:MerginalToggle<cr>
  '';

  gitCfg = ''
    autocmd vimRc CmdlineEnter *
          \ execute 'packadd diffconflicts'

    autocmd vimRc FileType gitrebase
          \ execute 'packadd auto-git-diff'
  '';

  editorconfigCfg = ''
    autocmd vimRc BufReadPre *
          \ execute 'packadd editorconfig-vim'
    let g:EditorConfig_exclude_patterns = ['fugitive://.*']
  '';

  completeCfg = ''
    let g:ycm_show_diagnostics_ui = 0
    let g:ycm_complete_in_comments = 1
    let g:ycm_collect_identifiers_from_comments_and_strings = 1
    let g:ycm_seed_identifiers_with_syntax = 1
    let g:ycm_key_list_stop_completion = ['<Enter>']
    let g:ycm_auto_hover='''
    autocmd vimRc Filetype javascript,typescript nmap <leader>h <plug>(YCMHover)
  '';

  aleCfg = ''
    let g:ale_lint_on_text_changed = 'normal'
    let g:ale_lint_on_insert_leave = 1
    let g:ale_lint_delay = 0
    let g:ale_set_highlights = 0
    let g:ale_sign_info = 'i'
    let g:ale_sign_error = '!'
    let g:ale_sign_warning = '?'
    let g:ale_echo_msg_format = '%linter%: %s %severity%'

    let g:ale_linters = {
          \   'jsx': ['eslint'],
          \   'javascript': ['eslint'],
          \   'typescript': ['eslint']
          \}

    let g:ale_fixers = {
          \   'jsx': ['eslint'],
          \   'javascript': ['eslint'],
          \   'typescript': ['eslint'],
          \   'nix': ['nixpkgs-fmt']
          \}

    let g:ale_pattern_options = {
    \ '\.min\.js$': {'ale_linters': [], 'ale_fixers': []},
    \ '\.min\.css$': {'ale_linters': [], 'ale_fixers': []},
    \}

    nnoremap [a :ALEPreviousWrap<CR>
    nnoremap ]a :ALENextWrap<CR>
    autocmd vimRc BufReadPost *
          \ execute 'packadd ale'
  '';

  tracesCfg = ''
    autocmd vimRc BufReadPost *
          \ execute 'packadd traces-vim'
  '';

  hlyankCfg = ''
    autocmd vimRc BufReadPost *
          \ execute 'packadd hlyank'
  '';

  commentCfg = ''
    autocmd vimRc BufReadPost *
          \ execute 'packadd tcomment_vim'
  '';

  textobjCfg = ''
    autocmd vimRc BufReadPost *
          \ execute 'packadd targets-vim'

    autocmd vimRc BufReadPost *
          \ execute 'packadd vim-indent-object'

    autocmd vimRc CmdlineEnter *
          \ execute 'packadd cmdline-completion'

    autocmd vimRc BufReadPost *
          \ execute 'packadd vim-surround'
    let surround_indent=1
    nmap S ysiw
  '';

  undoCfg = ''
    let g:undotree_CustomUndotreeCmd = 'vertical 30 new'
    let g:undotree_CustomDiffpanelCmd= 'botright 10 new'
    let g:undotree_HighlightChangedText = 1
    let g:undotree_SetFocusWhenToggle = 1
    let g:undotree_ShortIndicators = 1
    command! UT packadd undotree | UndotreeToggle
  '';

  ackCfg = ''
    autocmd vimRc CmdlineEnter *
          \ execute 'packadd ack-vim'
    let g:ackprg = 'rg --vimgrep --no-heading'
    let g:ackhighlight = 1
    cnoreabbrev Ack Ack!
    autocmd vimRc FileType qf packadd cfilter
  '';

  langsCfg = ''
    autocmd vimRc BufReadPre *.js,*.jsx
          \ execute 'packadd vim-javascript'
    let g:javascript_plugin_jsdoc = 1
    autocmd vimRc BufReadPre *.js,*.jsx
          \ execute 'packadd vim-html-template-literals'
    let g:htl_all_templates = 1
    let g:htl_css_templates = 1
    autocmd vimRc BufReadPre *.md
          \ execute 'packadd vim-markdown'
    autocmd vimRc FileType markdown setlocal conceallevel=2
    let g:vim_markdown_folding_disabled = 1
    autocmd vimRc BufReadPre *.jinja
          \ execute 'packadd vim-jinja'
    autocmd vimRc BufReadPre *.twig
          \ execute 'packadd vim-twig'
    autocmd vimRc BufReadPre *.coffee
          \ execute 'packadd vim-coffee-script'
  '';

  autocmdsCfg = ''
    " format
    autocmd vimRc FileType nix setlocal makeprg=nix-instantiate\ --parse
    autocmd vimRc FileType nix setlocal formatprg=nixpkgs-fmt
    autocmd vimRc BufRead,BufNewFile *.nix command! F silent call system('nixpkgs-fmt ' . expand('%'))
    autocmd vimRc BufRead,BufNewFile *.js,*.jsx,*.ts,*.tsx command! F silent call system('prettier --single-quote --no-bracket-spacing --write ' . expand('%'))
    autocmd vimRc BufRead,BufNewFile *.js,*.jsx command! Fix silent call system('eslint --fix ' . expand('%'))
    autocmd vimRc FileType yaml command! F silent call system('prettier --write ' . expand('%'))
    autocmd vimRc FileType sh command! F silent call system('shfmt -i 2 -ci -w ' . expand('%'))

    " qf and help keep widow full width
    autocmd vimRc FileType qf wincmd J
    autocmd vimRc BufWinEnter * if &ft == 'help' | wincmd J | end

    " update diff
    autocmd vimRc InsertLeave * if &l:diff | diffupdate | endif

    " sync syntax
    autocmd vimRc BufEnter * :syntax sync fromstart

    " detect filetype on save
    autocmd vimRc BufWritePost * if &filetype ==# ''' | filetype detect | endif

    " external changes
    autocmd vimRc FocusGained,CursorHold * if !bufexists("[Command Line]") | checktime | GitGutter | endif

    " omnicomplete
    autocmd vimRc Filetype *
          \ if &omnifunc == "" |
          \   setlocal omnifunc=syntaxcomplete#Complete |
          \ endif

    " mkdir
    autocmd vimRc BufWritePre *
          \\ if !isdirectory(expand('%:h', v:true)) |
          \\   call mkdir(expand('%:h', v:true), 'p') |
          \\ endif

    " filetypes
    autocmd vimRc BufNewFile,BufRead *.gitignore  setfiletype gitignore
    autocmd vimRc BufNewFile,BufRead *.twig       setfiletype twig.html
    autocmd vimRc BufNewFile,BufRead config       setfiletype config
    autocmd vimRc BufNewFile,BufRead *.lock       setfiletype config
    autocmd vimRc BufNewFile,BufRead .babelrc     setfiletype json
    autocmd vimRc BufNewFile,BufRead *.txt        setfiletype markdown
    autocmd vimRc BufWinEnter *.json setlocal conceallevel=0 concealcursor=
    autocmd vimRc BufReadPre *.json  setlocal conceallevel=0 concealcursor=
    autocmd vimRc BufReadPre *.json  setlocal formatoptions=
    autocmd vimRc FileType git       setlocal nofoldenable
  '';

  commandsCfg = ''
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
    command! NT execute 'Files ~/.notes'
  '';

  functionsCfg = ''
    " undo without cursor jump
    function! s:safeundo()
      let s:pos = getpos( '. ')
      let s:view = winsaveview()
      undo
      call setpos( '.', s:pos )
      call winrestview( s:view )
    endfunc

    function! s:saferedo()
      let s:pos = getpos( '.' )
      let s:view = winsaveview()
      redo
      call setpos( '.', s:pos )
      call winrestview( s:view )
    endfunc

    nnoremap u :call <sid>safeundo() <CR>
    nnoremap <C-r> :call <sid>saferedo() <CR>
  '';

  endCfg = ''
    syntax enable

    silent! colorscheme min

    set secure
  '';

  vim_configured = ((vim_configurable.overrideAttrs (oldAttrs: rec {
    version = "8.2.1709";
    src = fetchFromGitHub {
      owner = "vim";
      repo = "vim";
      rev = "v${version}";
      hash = "sha256-mtgjPzeFgxJVAauyeQukYvmADNNgN5SmbM/3PivskSA=";
    };
  })).override {
    python = python3;
  }).customize {
    name = "vim";
    vimrcConfig.customRC = cfgConcat [
      baseCfg
      optionsCfg
      mappingsCfg
      vinegarCfg
      fzfCfg
      fugitiveCfg
      merginalCfg
      gitgutterCfg
      gitCfg
      editorconfigCfg
      completeCfg
      aleCfg
      commandsCfg
      tracesCfg
      hlyankCfg
      commentCfg
      textobjCfg
      undoCfg
      ackCfg
      autocmdsCfg
      functionsCfg
      langsCfg
      endCfg
    ];
    vimrcConfig.packages.myplugins = with vimPlugins // extraPlugins; {
      start = [
        vim-nix
        repeat
        gitgutter
        altscreen
        quickfix-reflector-vim
        fzf-vim
        YouCompleteMe
      ];

      opt = [
        vinegar
        fzfWrapper
        fugitive
        vim-merginal
        editorconfig-vim
        ack-vim
        traces-vim
        auto-git-diff
        diffconflicts
        ale
        surround
        tcomment_vim
        targets-vim
        vim-indent-object
        cmdline-completion
        hlyank
        undotree
        vim-html-template-literals
        vim-javascript
        vim-coffee-script
        vim-jinja
        vim-twig
        vim-markdown
        min
      ];
    };
  };

in
buildEnv {
  name = "_vim";
  paths = [
    vim_configured
    wl-clipboard
    fzf
    fd
    ripgrep
    git
    nodejs
    nodePackages.eslint
    nodePackages.prettier
    nodePackages.typescript
    nodePackages.typescript-language-server
    nixpkgs-fmt
    shfmt
    vim-vint
  ];
}
