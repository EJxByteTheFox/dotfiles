{ config, lib, pkgs, ... }:


{
  services.mako.enable = true;

  services.mako.settings = {
    actions       = true;
    anchor        = "top-center";
    border-radius = 10;

    background-color  = "#24273a";
    text-color        = "#cad3f5";
    border-color      = "#f5a97f";
    progress-color    = "#363a4f";

    "urgency=high" = {
      border-color = "#f5a97f";
    };
  };
}
