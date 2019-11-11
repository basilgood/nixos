{ ag, fzf, fd, nixfmt, python27Packages, vim-vint, editorconfig-core-c }:
# vim: set syntax=vim:
''
    set encoding=utf-8
    scriptencoding utf-8

    augroup vimRc
      autocmd!
    augroup END

    if has('vim_starting')
      let g:startuptime = reltime()
      autocmd vimRc VimEnter * let g:startuptime = reltime(g:startuptime) | redraw
      \ | echomsg 'startuptime: ' . reltimestr(g:startuptime)
    endif

    let g:loaded_matchparen         = 1
    let g:loaded_rrhelper           = 1
    let g:did_install_default_menus = 1
    let g:is_bash                   = 1
    let g:sh_noisk                  = 1
    let g:loaded_vimball            = 1
    let g:loaded_vimballPlugin      = 1
    let g:loaded_getscript          = 1
    let g:loaded_getscriptPlugin    = 1
    let g:loaded_logipat            = 1
    let g:loaded_man                = 1

    let s:mkdir = function('mkdir')
    let $CACHE      = expand('$HOME/.cache/')
    let $CACHE_NVIM = expand('$CACHE/nvim')

    """" after vim start
    if has('vim_starting') && has('timers')
      autocmd vimRc VimEnter * call timer_start(1, 'functions#packaddhandler', {'repeat': 0})
    endif

    """" plugins configs
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

    """" git.
    nnoremap [fugitive]  <Nop>
    nmap <space>g [fugitive]
    nnoremap <silent> [fugitive]s :<C-u>vertical Gstatus<CR>
    nnoremap <silent> [fugitive]d :<C-u>Gvdiffsplit<CR>
    nnoremap <silent> [fugitive]l :<C-u>GV --all<CR>

    function! InFugitive() abort
      nmap <buffer> zp :<c-u>Dispatch! git push<CR>
      nmap <buffer> zF :<c-u>Dispatch! git push -f<CR>
      nmap <buffer> zf :<c-u>Dispatch! git fetch --all --prune<CR>
      nmap <buffer> zr :<c-u>Dispatch! git pull --rebase --autostash<CR>
    endfunction

    autocmd vimRc FileType fugitive call InFugitive()

    """" mergetool
    let g:mergetool_layout = 'bmr'
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

    augroup in_netrw
      autocmd!
      autocmd FileType netrw call functions#innetrw()
    augroup END

    """" skim(fzf)
    let $SKIM_DEFAULT_COMMAND = '${fd}/bin/fd --type f --hidden --follow --exclude .git'
    let $SKIM_DEFAULT_OPTS = '--bind ctrl-f:toggle'

    nnoremap <C-p> :Files<CR>
    nnoremap <C-a> :Files %:h<CR>
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

    """" startify
    nnoremap <space>q :SC<cr>
    let g:startify_disable_at_vimenter = 1
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

    """" nixfmt
    command! -nargs=0 NixFormat silent! execute "!${nixfmt}/bin/nixfmt %"

    """" better defaults
    set path=.,**
    set undofile
    set nobackup
    set noswapfile
    set expandtab shiftwidth=2 softtabstop=-1
    set fileformats=unix,dos
    set termguicolors
    set number
    set mouse=a
    set cursorline
    set noswapfile
    set shortmess+=IFcm
    set nowrap
    set switchbuf=useopen,usetab
    set splitright
    set splitbelow
    set signcolumn=auto
    set completeopt+=menuone,noselect
    set completeopt-=preview
    set complete=.,w,b,u,U,t,i,d,k
    set pumheight=12
    set gdefault
    set hlsearch|nohlsearch
    set nostartofline
    set sidescrolloff=5
    set sidescroll=1
    set expandtab
    set softtabstop=2
    set tabstop=2
    set shiftwidth=2
    set shiftround
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
    set undodir=~/.cache/nvim/undo
    call s:mkdir(&undodir, 'p')
    set undofile
    set list
    set listchars=tab:▸\ ,trail:•,extends:❯,precedes:❮,nbsp:⦸
    autocmd vimRc InsertEnter * set listchars-=trail:•
    autocmd vimRc InsertLeave * set listchars+=trail:•

    let &g:statusline='''
    let &g:statusline.='%{expand("%:p:h:t")}/%t'
    let &g:statusline.='%8c:%l'
    let &g:statusline.=' %h%r'
    let &g:statusline.='%{exists("g:did_coc_loaded")?coc#status():""}'
    let &g:statusline.=' %#incsearch#%{&mod?" ✚✚✚ ":""}'
    let &g:statusline.='%*'
    let &g:statusline.='%='
    let &g:statusline.='%{exists("g:loaded_conflicted")?ConflictedVersion():""} '
    let &g:statusline.='%{exists("g:loaded_fugitive")?fugitive#head(5):""} '
    let &g:statusline.='[%{&filetype!=#""?&filetype:""}]'

    """" mappings
    nmap  <Space>   [Space]
    nnoremap  [Space]   <Nop>
    nnoremap j gj
    nnoremap k gk
    nnoremap > >>
    nnoremap < <<
    vnoremap > >gv
    vnoremap < <gv
    nnoremap <C-s> :<c-u>update<cr>
    inoremap <C-s> <esc>:update<cr>
    xnoremap <C-s> <esc>:<C-u>update<cr>
    nnoremap <expr> 0 virtcol('.') - 1 <= indent('.') && col('.') > 1 ? '0' : '_'
    cnoremap <C-a> <Home>
    cnoremap <C-e> <End>
    inoremap <C-a> <Home>
    inoremap <C-e> <End>
    inoremap <C-Del> <C-o>dw
    nnoremap } }zz
    nnoremap { {zz

    " Smart <C-f>, <C-b>.
    noremap <expr> <C-f> max([winheight(0) - 2, 1])
          \ . "\<C-d>" . (line('w$') >= line('$') ? "L" : "M")
    noremap <expr> <C-b> max([winheight(0) - 2, 1])
          \ . "\<C-u>" . (line('w0') <= 1 ? "H" : "M")

    """" windows
    nnoremap <silent> <space>v  :<c-u>vsplit<cr>
    nnoremap <silent> <space>s  :<c-u>split<cr>
    nnoremap <silent> <space>o  :<c-u>only<cr>
    nnoremap <silent> <space>q  :<c-u>close<cr>
    nnoremap <silent> <Tab> :wincmd w<CR>
    nnoremap <silent> <S-Tab> :wincmd W<CR>

    """" prev and next buffer
    nnoremap ]b :bnext<cr>
    nnoremap [b :bprev<cr>

    """" lists
    nnoremap ]l :lnext<cr>
    nnoremap [l :lprevious<cr>
    nnoremap ]q :cnext<cr>
    nnoremap [q :cprevious<cr>
    nnoremap ]Q :clast<cr>
    nnoremap [Q :cfirst<cr>

    """" niceblock
    xnoremap <expr> I (mode()=~#'[vV]'?'<C-v>^o^I':'I')
    xnoremap <expr> A (mode()=~#'[vV]'?'<C-v>0o$A':'A')

    """" innerline
    xnoremap <silent> il <Esc>^vg_
    onoremap <silent> il :<C-U>normal! ^vg_<cr>

    """" entire
    xnoremap <silent> ie gg0oG$
    onoremap <silent> ie :<C-U>execute "normal! m`"<Bar>keepjumps normal! ggVG<cr>

    """" disable EX-mode
    nnoremap Q <Nop>
    nnoremap gQ <Nop>

    """" execute macro
    nnoremap Q @q
    """" Run macro on selected lines
    vnoremap Q :norm Q<cr>

    """" yank to clipboard
    vnoremap <space>y "+y

    """" yank and keep cursor position
    vnoremap <expr>y "my\"" . v:register . "y`y"

    """" paste from clipboard
    nnoremap <space>p :put+<cr>
    vnoremap <space>p "+p
    nnoremap <space>P :put!+<cr>
    vnoremap <space>P "+P

    """" Paste continuously.
    nnoremap [p "0p
    nnoremap ]p viw"0p
    vnoremap P "0p

    """" replace a word with clipboard
    nnoremap <space>w viw"+p

    """" switch buffers
    nnoremap <space>1 1<c-w>w
    nnoremap <space>2 2<c-w>w
    nnoremap <space>3 3<c-w>w
    nnoremap <space>4 4<c-w>w
    nnoremap <space>5 5<c-w>w
    nnoremap <space>6 6<c-w>w
    nnoremap <space>7 7<c-w>w
    nnoremap <space>8 8<c-w>w
    nnoremap <space>9 9<c-w>w

    """" substitute.
    nnoremap [subst]   <Nop>
    nmap   s [subst]
    xmap   s [subst]
    nnoremap [subst]s :%s/
    nnoremap [subst]l :s/
    xnoremap [subst]  :s/
    nnoremap [subst]a :<c-u>%s/\C\<<c-r><c-w>\>/<c-r><c-w>
    nnoremap [subst]p vip :<c-u>s/
    nnoremap [subst]w :<C-u>%s/\C\<<C-R><C-w>\>//g<Left><Left>

    """" zoom
    nnoremap <C-w>t :tabedit %<cr>
    nnoremap <C-w>z :tabclose<cr>

    """" git commands
    nnoremap <silent> <expr> <space>dt ":\<C-u>"."windo ".(&diff?"diffoff":"diffthis")."\<CR>"

    """" hlsearch hlnext
    nnoremap <silent> <space>n :nohlsearch<CR>

    " CTRL-L to fix syntax highlight
    nnoremap <silent><expr> <C-l> empty(get(b:, 'current_syntax'))
          \ ? "\<C-l>"
          \ : "\<C-l>:syntax sync fromstart\<CR>"

    """" commands
    command! -nargs=0 BO silent! execute "%bd|e#|bd#"
    command! Bd setlocal bufhidden=delete | bnext
    command! -nargs=0 WS %s/\s\+$// | normal! ``
    command! -nargs=0 HL call functions#hl()
    command! -range GB echo join(systemlist("git blame -L <line1>,<line2> " . expand('%')), "\n")
    command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
    command! -nargs=0 Prettier :CocCommand prettier.formatFile
    command! -nargs=0 OrganiseImports :CocCommand tsserver.organizeImports
    command! -nargs=0 FixAllImports :CocCommand tsserver.executeAutoFix

    """" autocmds
    """" If a file is large, disable syntax highlighting, filetype etc
    let g:LargeFile = 20*1024*1024 " 20MB
    autocmd vimRc BufReadPre *
          \ let s = getfsize(expand("<afile>")) |
          \ if s > g:LargeFile || s == -2 |
          \   call functions#large_file(fnamemodify(expand("<afile>"), ":p")) |
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
    autocmd vimRc BufWritePre * call functions#mkdirifnotexist()

    """" remember_position
    autocmd vimRc BufReadPost * if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

    """" cursorline
    autocmd vimRc InsertLeave,WinEnter * setlocal cursorline
    autocmd vimRc InsertEnter,WinLeave * setlocal nocursorline

    """" hlsearch
    augroup hlsearch
      autocmd!
      autocmd OptionSet hlsearch call functions#togglehl(v:option_old, v:option_new)
    augroup END
    autocmd vimRc BufRead * call functions#togglehl(0, &hlsearch)

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

    colorscheme nordish
    hi! Comment      guifg=#5c6370 guibg=NONE gui=italic cterm=italic
    hi! ParenMatch   guifg=#85EB6A guibg=#135B00 gui=NONE cterm=NONE term=reverse ctermbg=11
    set secure
''
