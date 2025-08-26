{ config, lib, pkgs, ... }:

{
  imports = [
    ./keybinds.nix
    ./autostart.nix
    ./fx.nix
  ];

  wayland.windowManager.sway.enable = true;
}
