{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = pkgs.nvim;
    configure = {
      customRC = ''
        source ~/.config/nvim/init.vim";
      '';
      # packages.myVimPackage.start = with pkgs.vimPlugins; [
      #   fzf-vim
      #   nvim-lspconfig
      # ];
    };
  };
}
