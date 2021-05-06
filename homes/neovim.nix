{ pkgs, ... }:
with pkgs;
{
  programs.neovim = {
    enable = true;
    package = neovim-nightly;
    extraConfig = ''
      lua require "init"
    '';
    extraPackages = [
      nixpkgs-fmt
      nodePackages.typescript-language-server
      efm-langserver
      nodePackages.prettier
      vim-vint
      luajitPackages.luacheck
      glow
    ];
  };
}
