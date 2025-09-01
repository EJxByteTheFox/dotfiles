{
  description = "My Home-Manager Dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixvim } @inputs:
  let
    username = "ellie";
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;

      config.allowUnfree = true;
    };
  in
  {
    homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      extraSpecialArgs = {
        inherit inputs;
      };

      modules = [
        ./home.nix
      ];
    };

    homeManagerModules.${username} = import ./home.nix;
  };
}
