self: super:
with super;

let
  plugins = callPackage ./plugins/default.nix { };
  customNeovim = neovim.override {
    withNodeJs = true;
    configure = {
      customRC = ''
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

        """" lazy load plugins
        if has('vim_starting') && has('timers')
          autocmd vimRc VimEnter * call timer_start(1, 'functions#packaddhandler', {'repeat': 0})
        endif

        ${callPackage ./coc.nix { }}
        ${callPackage ./configs.nix { }}
        ${callPackage ./options.nix { }}
        ${callPackage ./mappings.nix { }}
        ${callPackage ./autocmds.nix { }}
        ${callPackage ./commands.nix { }}

        colorscheme theonlyone
        hi! Comment      guifg=#5c6370 guibg=NONE gui=italic cterm=italic
        hi! ParenMatch   guifg=#85EB6A guibg=#135B00 gui=NONE cterm=NONE term=reverse ctermbg=11

        set secure
      '';

      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [ ] ++ (with plugins; [ vim-startify all-func ]);
        opt = [
          vinegar
          coc-nvim
          surround
          repeat
          vim-nix
          vim-javascript
          vim-html-template-literals
          vim-coffee-script
          vim-jinja
          vim-markdown
          vim-json
          vim-go
          undotree
          vim-indent-object
          quickfix-reflector-vim
          vim-easy-align
          auto-git-diff
          ferret
          fzfWrapper
        ] ++ (with plugins; [
          vim-fugitive
          fzf-vim
          vim-dispatch
          tcomment
          targets
          wildfire
          gv
          conflict3
          vcs-jump
          vim-edgemotion
          vim-editorconfig
          vim-parenmatch
          vim-submode
          vim-twiggy
          cmdline
          vim-jsx-pretty
          jsonc
          yats
          twig
          apprentice
          theonlyone
        ]);
      };
    };
  };
in {
  neovim2 = stdenv.mkDerivation {
    name = "neovim2";
    buildCommand = ''
      mkdir -p $out/bin
      ln -s ${customNeovim}/bin/nvim $out/bin/nvm
    '';

  };
}
