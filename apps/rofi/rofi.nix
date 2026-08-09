# https://mynixos.com/home-manager/options/programs.rofi
{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.ghostty}/bin/ghostty";
    theme = ./themes/KooL_style-1.rasi;
    font = "JetBrainsMono Nerd Font 10";
    cycle = true;
    location = "center";
  };
}
