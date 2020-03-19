{ lib, callPackage, vimPlugins }:
let
  extraPlugins = callPackage ./plugins.nix { };
  neovimConfig = {
    customRC = ''
      ${builtins.readFile ./init.vim};
      silent! colorscheme min
      set secure
    '';
    plugins = with vimPlugins // extraPlugins; [
      {
        start = gitgutter;
        config = ''
          let g:gitgutter_override_sign_column_highlight = 0
          let g:gitgutter_sign_added='┃'
          let g:gitgutter_sign_modified='┃'
          let g:gitgutter_sign_removed='◢'
          let g:gitgutter_sign_removed_first_line='◥'
          let g:gitgutter_sign_modified_removed='◢'
          nmap ghs <Plug>(GitGutterStageHunk)
          nmap ghu <Plug>(GitGutterUndoHunk)
          nmap ghp <Plug>(GitGutterPreviewHunk)
        '';
      }
      {
        start = repeat;
        config = "";
      }
      {
        start = deoplete-nvim;
        config = ''
          autocmd FileType css,sass,scss setlocal omnifunc=csscomplete#CompleteCSS
          let g:deoplete#enable_at_startup = 1
        '';
      }
      {
        opt = deoplete-lsp;
        config = ''
          autocmd vimRc BufReadPost *
                \ execute 'packadd deoplete-lsp'
        '';
      }
      {
        opt = nvim-lsp;
        config = ''
          autocmd vimRc BufReadPost *
                \ execute 'packadd nvim-lsp'
          lua << EOF
          if not package.loaded.nvim_lsp then
            vim.cmd 'packadd nvim-lsp'
            vim._update_package_paths()
          end
          local nvim_lsp = require'nvim_lsp'
          nvim_lsp.tsserver.setup {
            cmd = {'typescript-language-server', '--stdio'},
            filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" }
          }
          nvim_lsp.vimls.setup {
            cmd = {'vim-language-server', '--stdio'},
            filetypes = { 'vim' }
          }
          nvim_lsp.rnix.setup {
            cmd = {'rnix-lsp'},
            filetypes = { 'nix' },
            init_options = {}
          }
          EOF
        '';
      }
      {
        start = vim-enmasse;
        config = "";
      }
      {
        start = fzf-vim;
        config = ''
          let $FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
          let g:fzf_layout = { 'down': '~25%' }
          let g:fzf_action = {
                \ 'ctrl-t': 'tab split',
                \ 'ctrl-s': 'split',
                \ 'ctrl-v': 'vsplit',
                \ 'ctrl-w': 'bdelete'}
          nnoremap <c-p> :Files<cr>
          nnoremap <bs> :Buffers<cr>
          function! RipgrepFzf(query, fullscreen)
            let command_fmt = 'rg --column --line-number --no-heading --color=always --hidden --smart-case -g "!.git" %s || true'
            let initial_command = printf(command_fmt, shellescape(a:query))
            let reload_command = printf(command_fmt, '{q}')
            let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
            call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
          endfunction

          command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)
        '';
      }
      {
        opt = fzfWrapper;
        config = ''
          autocmd vimRc BufReadPost *
                \ execute 'packadd fzfWrapper'
        '';
      }
      {
        opt = vinegar;
        config = ''
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
      }
      {
        opt = ale;
        config = ''
         autocmd vimRc BufReadPost *
               \ execute 'packadd ale'
         let g:ale_lint_on_text_changed = 'normal'
         let g:ale_lint_on_insert_leave = 1
         let g:ale_lint_delay = 0
         let g:ale_sign_info = '_i'
         let g:ale_sign_error = '_e'
         let g:ale_sign_warning = '_w'
         let g:ale_echo_msg_format = '%linter%: %s %severity%'
         let g:ale_linters = {
               \   'jsx': ['eslint'],
               \   'javascript': ['eslint'],
               \   'typescript': ['eslint']
               \}

         nnoremap [a :ALEPreviousWrap<CR>
         nnoremap ]a :ALENextWrap<CR>
        '';
      }
      {
        opt = vim-fugitive;
        config = ''
          autocmd vimRc CmdlineEnter *
                \ execute 'packadd vim-fugitive'
          nnoremap [git]  <Nop>
          nmap <space>g [git]
          nnoremap <silent> [git]s :<C-u>vertical Gstatus<CR>
          nnoremap <silent> [git]d :<C-u>Gvdiffsplit!<CR>gg
          nnoremap <silent> [git]l :<C-u>vertical Git --paginate log --oneline --graph --decorate --all<CR>
          cnoreabbrev Gg Gg!
        '';
      }
      {
        opt = editorconfig-vim;
        config = ''
          autocmd vimRc BufReadPre *
                \ execute 'packadd editorconfig-vim'
          let g:EditorConfig_exclude_patterns = ['fugitive://.*']
        '';
      }
      {
        opt = easy-align;
        config = ''
          autocmd vimRc BufReadPost *
                \ execute 'packadd vim-easy-align'
          nmap ga <Plug>(EasyAlign)
          xmap ga <Plug>(EasyAlign)
        '';
      }
      {
        opt = vim-surround;
        config = ''
          autocmd vimRc BufReadPost *
                \ execute 'packadd vim-surround'
          let surround_indent=1
          nmap S ysiw
        '';
      }
      {
        opt = tcomment_vim;
        config = ''
          autocmd vimRc BufReadPost *
                \ execute 'packadd tcomment_vim'
        '';
      }
      {
        opt = targets-vim;
        config = ''
          autocmd vimRc BufReadPost *
                \ execute 'packadd targets-vim'
        '';
      }
      {
        opt = traces-vim;
        config = ''
          autocmd vimRc BufReadPost *
                \ execute 'packadd traces-vim'
        '';
      }
      {
        opt = ack-vim;
        config = ''
          autocmd vimRc CmdlineEnter *
                \ execute 'packadd ack-vim'
          let g:ackprg = 'rg --vimgrep --no-heading'
          let g:ackhighlight = 1
          cnoreabbrev Ack Ack!
        '';
      }
      {
        opt = vim-visual-multi;
        config = ''
          autocmd vimRc BufReadPost *
                \ execute 'packadd vim-visual-multi'
        '';
      }
      {
        opt = vim-indent-object;
        config = ''
          autocmd vimRc BufReadPost *
                \ execute 'packadd vim-indent-object'
        '';
      }
      {
        opt = undotree;
        config = ''
          let g:undotree_CustomUndotreeCmd = 'vertical 50 new'
          let g:undotree_CustomDiffpanelCmd= 'belowright 12 new'
          let g:undotree_SetFocusWhenToggle = 1
          let g:undotree_ShortIndicators = 1
          command! UT packadd undotree | UndotreeToggle
        '';
      }
      {
        opt = auto-git-diff;
        config = ''
          autocmd vimRc FileType gitrebase
                \ execute 'packadd auto-git-diff'
        '';
      }
      {
        opt = gv-vim;
        config = ''
          command! GV packadd gv-vim | GV
        '';
      }
      {
        opt = diffconflicts;
        config = ''
          autocmd vimRc CmdlineEnter *
                \ execute 'packadd diffconflicts'
        '';
      }
      {
        opt = vim-javascript;
        config = ''
          autocmd vimRc BufReadPre *.js,*.jsx
                \ execute 'packadd vim-javascript'
        '';
      }
      {
        opt = vim-html-template-literals;
        config = ''
          autocmd vimRc BufReadPre *.js,*.jsx
                \ execute 'packadd vim-html-template-literals'
          let g:htl_all_templates = 1
          let g:htl_css_templates = 1
        '';
      }
      {
        opt = vim-coffee-script;
        config = ''
          autocmd vimRc BufReadPre *.coffee
                \ execute 'packadd vim-coffee-script'
        '';
      }
      {
        opt = vim-markdown;
        config = ''
          autocmd vimRc BufReadPre *.md
                \ execute 'packadd vim-markdown'
        '';
      }
      {
        opt = vim-jinja;
        config = ''
          autocmd vimRc BufReadPre *.jinja
                \ execute 'packadd vim-jinja'
        '';
      }
      {
        opt = vim-twig;
        config = ''
          autocmd vimRc BufReadPre *.twig
                \ execute 'packadd vim-twig'
        '';
      }
      {
        opt = vim-fixjson;
        config = ''
          autocmd vimRc BufReadPre *.json
                \ execute 'packadd vim-fixjson'
          let g:fixjson_fix_on_save = 0
        '';
      }
      {
        start = vim-nix;
        config = "";
      }
      {
        opt = min;
        config = "";
      }
    ];
  };

  # fun neovimConfig
  fun = cfg: {
    packages.myVimPackage = {
      start = map (item: item.start) (builtins.filter (check: check ? "start") cfg.plugins);
      opt = map (item: item.opt) (builtins.filter (check: check ? "opt") cfg.plugins);
    };
    customRC = cfg.customRC + "\n" + lib.concatMapStringsSep "\n" (plug: plug.config) cfg.plugins;
  };
in
{ configure = fun neovimConfig; }
