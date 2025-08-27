{ config, lib, pkgs, ... }:

{
  wayland.windowManager.sway.extraConfig = ''
    blur enable
    blur passes 3
    blur radius 7
    blur noise 0.07
  '';
}
