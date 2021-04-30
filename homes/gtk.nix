{ pkgs, ... }: {
  gtk = {
    enable = true;
    theme = { name = "Nordic"; package = pkgs.nordic; };
    iconTheme = {name = "Numix"; package = pkgs.numix-icon-theme;};
  };
}
