{ config, lib, pkgs, stateVersion, homeDirectory, username, system, ... }:

{
  imports = [
    ./home/swayfx/default.nix
  ];

  home.stateVersion = "25.05";
  home.username = "ellie";
  home.homeDirectory = "/home/ellie";

  nixpkgs.config = {
    inherit system;
    allowUnfree = true;
    experimental-features = [ "nix-command" "flakes" ];
  };

  systemd.user.startServices = "sd-switch";

  programs.home-manager.enable = true;
}
