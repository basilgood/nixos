{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    core.url = "github:basilgood/nixos/apprentice";
    core.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, core }: {
    nixosConfigurations.hermes = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = (builtins.attrValues core.nixosModules) ++ [
        ./configuration.nix
        {
          home-manager.users.vasy = { ... }: {
            imports = (builtins.attrValues core.homeModules) ++ [./home.nix];
          };
        }
      ];
    };
  };
}
