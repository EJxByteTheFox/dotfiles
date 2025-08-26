{ config, lib, pkgs, ... }:

let
  super = "Mod4";
  pwr_mode = "Power: (l)ock (e)xit (s)uspend (H)ibernate (S)hutdown (r)eboot (U)EFI";
in
{
  wayland.windowManager.sway = {
    config = {
      keybindings = {
        "${super}+Return"   = "exec ${pkgs.alacritty}/bin/alacritty";
        "${super}+Shift+q"  = "kill";
        "${super}+d"        = "exec ${pkgs.wofi}/bin/wofi --show drun";

        "${super}+Shift+e"  = "mode \"${pwr_mode}\""
        "${super}+r"        = "mode \"resize\"";
      };


      modes = {
        ${pwr_mode} = {
          "l" = "exec swaylock -fF";
          "e" = "exit";
          "s" = "exec systemctl suspend";
          "Shift+h" = "exec systemctl hibernate";
          "Shift+s" = "exec systemctl poweroff";
          "r" = "exec systemctl reboot";
          "Shift+u" = "exec systemctl reboot --firmware-setup";

          "Return" = "mode \"default\"";
          "Escape" = "mode \"default\"";
        };
      };
    };
  };
}
