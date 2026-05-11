# https://mynixos.com/home-manager/options/programs.cava
{ config, pkgs, ... }:

{
  programs.cava.enable = true;

  # Deploy cava config
  xdg.configFile."cava/config".source = ./config;
}
