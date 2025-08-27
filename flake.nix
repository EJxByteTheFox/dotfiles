{
  description = "My Home-Manager Dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
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
    stateVersion = "25.05";

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
        inherit username;
        inherit stateVersion;
      };

      modules = [
        ./home.nix
      ];
    };

    homeManagerModules.${username} = import ./home.nix;
  };
}
