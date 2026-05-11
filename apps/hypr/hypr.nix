# https://mynixos.com/home-manager/options/programs.hyprshot
# https://mynixos.com/home-manager/options/programs.hyprlock
# https://mynixos.com/home-manager/options/services.hypridle
# https://mynixos.com/home-manager/options/services.hyprsunset
{ config, pkgs, ... }:

{
  # Hyprshot for screenshots
  programs.hyprshot.enable = true;

  # Hyprlock for screen locking
  programs.hyprlock.enable = true;

  # Hypridle for idle detection (auto-lock after timeout)
  services.hypridle.enable = true;

  # Hyprsunset to adjust screen temperature
  services.hyprsunset.enable = true;
}
