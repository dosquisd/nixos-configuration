# https://mynixos.com/home-manager/options/programs.wallust
{ config, pkgs, ... }:

{
  programs.wallust.enable = true;

  # Deploy wallust config
  xdg.configFile."wallust/wallust.toml".source = ./wallust.toml;
}
