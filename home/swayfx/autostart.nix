{ config, lib, pkgs, ... }:

{
  wayland.windowManager.sway.config.startup = [
    { command = "systemctl --user restart waybar"; always = true; }
    { command = "systemctl --user restart mako"; always = true; }
  ];
}
