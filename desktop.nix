{ config, pkgs, ... }:

let
  hyprlandConfig =
    builtins.replaceStrings
      [
        "source= $UserConfigs/Startup_Apps.conf # put your start-up packages on this file"
        "source= $UserConfigs/ENVariables.conf # Environment variables to load"
      ]
      [
        ''
        # startup apps are managed by Home Manager services
        # -- but these still need to run inside Hyprland's own exec-once context --

        # Import env vars into systemd/dbus user session (needed by nm-applet, blueman-applet, etc.)
        exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE
        exec-once = systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE

        # Clipboard manager watchers (must run here, not via systemd,
        # to avoid the data-control protocol timing issue)
        exec-once = ${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store
        exec-once = ${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store

        # Idle daemon
        exec-once = ${pkgs.hypridle}/bin/hypridle

        # Quickshell (desktop overview - Windows+A)
        exec-once = ${pkgs.quickshell}/bin/qs -c overview
        ''
        "# environment variables are managed by Home Manager"
      ]
      (builtins.readFile ./apps/hypr/hyprland.conf);
in
{
  home.sessionVariables = {
    EDITOR = "vim";
    GDK_BACKEND = "wayland,x11,*";
    QT_QPA_PLATFORM = "wayland;xcb";
    CLUTTER_BACKEND = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_QPA_PLATFORMTHEME = "qt6ct";
    QT_QUICK_CONTROLS_STYLE = "org.hyprland.style";
    GDK_SCALE = "1";
    QT_SCALE_FACTOR = "1";
    HYPRCURSOR_THEME = "Bibata-Modern-Ice";
    HYPRCURSOR_SIZE = "24";
    MOZ_ENABLE_WAYLAND = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NVD_BACKEND = "direct";
    GSK_RENDERER = "ngl";
  };

  xdg.configFile = {
    "hypr/hyprland.conf".text = hyprlandConfig;
    "hypr/UserConfigs".source = ./apps/hypr/UserConfigs;
    "hypr/configs".source = ./apps/hypr/configs;
    "hypr/scripts".source = ./apps/hypr/scripts;
    "hypr/UserScripts".source = ./apps/hypr/UserScripts;
    "hypr/animations".source = ./apps/hypr/animations;
    "hypr/wallust".source = ./apps/hypr/wallust;
    "hypr/application-style.conf".source = ./apps/hypr/application-style.conf;
    "hypr/hypridle.conf".source = ./apps/hypr/hypridle.conf;
    "hypr/hyprlock-2k.conf".source = ./apps/hypr/hyprlock-2k.conf;
    "hypr/initial-boot.sh".source = ./apps/hypr/initial-boot.sh;
    "hypr/monitors.conf".source = ./apps/hypr/monitors.conf;
    "hypr/workspaces.conf".source = ./apps/hypr/workspaces.conf;
    # "waybar".source = ./apps/waybar;
  };

  systemd.user.services = {
    # waybar = {
    #   Unit = {
    #     Description = "Waybar";
    #     PartOf = [ "graphical-session.target" ];
    #     After = [ "graphical-session.target" ];
    #   };
    #   Service = {
    #     ExecStart = "${pkgs.waybar}/bin/waybar";
    #     Restart = "on-failure";
    #     RestartSec = 2;
    #   };
    #   Install = {
    #     WantedBy = [ "graphical-session.target" ];
    #   };
    # };

    # hypridle = {
    #   Unit = {
    #     Description = "Hypridle";
    #     PartOf = [ "graphical-session.target" ];
    #     After = [ "graphical-session.target" ];
    #   };
    #   Service = {
    #     ExecStart = "${pkgs.hypridle}/bin/hypridle";
    #     Restart = "on-failure";
    #     RestartSec = 2;
    #   };
    #   Install = {
    #     WantedBy = [ "graphical-session.target" ];
    #   };
    # };

    nm-applet = {
      Unit = {
        Description = "NetworkManager Applet";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.networkmanagerapplet}/bin/nm-applet --indicator";
        Restart = "on-failure";
        RestartSec = 2;
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };

    blueman-applet = {
      Unit = {
        Description = "Blueman Applet";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.blueman}/bin/blueman-applet";
        Restart = "on-failure";
        RestartSec = 2;
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };

    # swaync = {
    #   Unit = {
    #     Description = "Sway Notification Center";
    #     PartOf = [ "graphical-session.target" ];
    #     After = [ "graphical-session.target" ];
    #   };
    #   Service = {
    #     ExecStart = "${pkgs.swaynotificationcenter}/bin/swaync";
    #     Restart = "on-failure";
    #     RestartSec = 2;
    #   };
    #   Install = {
    #     WantedBy = [ "graphical-session.target" ];
    #   };
    # };

    swww-daemon = {
      Unit = {
        Description = "Swww wallpaper daemon";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.swww}/bin/swww-daemon --format xrgb";
        Restart = "on-failure";
        RestartSec = 2;
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };

    # DISABLED: cliphist services fail at startup due to data-control protocol timing.
    # These will be started manually from Hyprland if needed.
    # cliphist-text = {
    #   Unit = {
    #     Description = "Cliphist text watcher";
    #     PartOf = [ "graphical-session.target" ];
    #     After = [ "graphical-session.target" ];
    #   };
    #   Service = {
    #     ExecStart = "${pkgs.writeShellScript "cliphist-text-watcher" ''exec ${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store''}";
    #     Restart = "on-failure";
    #     RestartSec = 2;
    #   };
    #   Install = {
    #     WantedBy = [ "graphical-session.target" ];
    #   };
    # };
    #
    # cliphist-image = {
    #   Unit = {
    #     Description = "Cliphist image watcher";
    #     PartOf = [ "graphical-session.target" ];
    #     After = [ "graphical-session.target" ];
    #   };
    #   Service = {
    #     ExecStart = "${pkgs.writeShellScript "cliphist-image-watcher" ''exec ${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store''}";
    #     Restart = "on-failure";
    #     RestartSec = 2;
    #   };
    #   Install = {
    #     WantedBy = [ "graphical-session.target" ];
    #   };
    # };

    polkit-gnome-authentication-agent-1 = {
      Unit = {
        Description = "Polkit GNOME Authentication Agent";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 2;
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
