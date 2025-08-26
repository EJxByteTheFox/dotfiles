{ config, pkgs, ... }:


let
  wofiStyle = ''
    
  '';
{
  programs.waybar.enable = true;
  programs.waybar.systemd.enable = true;
  programs.waybar.style = wofiStyle;

  programs.waybar.settings = {
    mainBar = {
      layer     = "top";
      position  = "bottom";
      output    = [ "eDP-1" "HDMI-A-1" ];
      reload_style_on_change  = true;

      modules-left    = [ "sway/workspaces" "sway/mode" ];
      modules-right   = [ "idle_inhibitor" "mpd" "network" "battery" "pulseaudio" "clock" ];
      modules-center  = [ "sway/window" ];

      
    };
  };
}
