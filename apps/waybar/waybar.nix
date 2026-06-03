# https://mynixos.com/home-manager/options/programs.waybar
{ config, pkgs, ... }:

let
  waybarStyle = pkgs.writeText "waybar-dark-latte-wallust.css" (
    builtins.readFile "/home/juand/nixos-configuration/apps/waybar/style/[Dark] Latte-Wallust combined.css"
  );
in

{
  # This is unnecessary when using Hyprland
  # wayland.windowManager.sway.systemd.enable = true;

  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };

    # Default style is /etc/nixos/apps/waybar/style/'[Dark] Latte-Wallust combined.css'
    style = waybarStyle;

    # The default config is /etc/nixos/apps/waybar/configs/[TOP] Default
    settings = [
      {
        include = [
          "/etc/nixos/apps/waybar/Modules"
          "/etc/nixos/apps/waybar/ModulesWorkspaces"
          "/etc/nixos/apps/waybar/ModulesCustom"
          "/etc/nixos/apps/waybar/ModulesGroups"
          "/etc/nixos/apps/waybar/UserModules"
        ];
        layer = "top";
        exclusive = true;
        passthrough = false;
        position = "top";
        spacing = 3;
        "fixed-center" = true;
        ipc = true;
        "margin-top" = 3;
        "margin-left" = 8;
        "margin-right" = 8;
        "modules-left" = [
          "custom/separator#blank"
          "custom/cava_mviz"
          "custom/separator#blank"
          "custom/playerctl"
          "custom/separator#blank_2"
          "hyprland/window"
        ];
        "modules-center" = [
          "group/app_drawer"
          "custom/separator#blank"
          "group/notify"
          "custom/separator#dot-line"
          "hyprland/workspaces#rw"
          "clock"
          "custom/separator#dot-line"
          "battery"
          "custom/separator#dot-line"
          "idle_inhibitor"
          "custom/hint"
        ];
        "modules-right" = [
          "tray"
          "network#speed"
          "custom/separator#dot-line"
          "group/mobo_drawer"
          "custom/separator#line"
          "group/audio"
          "custom/separator#dot-line"
          "group/status"
        ];
      }
    ];
  };
}
