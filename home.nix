# https://nixos.wiki/wiki/Home_Manager
# https://nix-community.github.io/home-manager//* Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ]; */

{ config, pkgs, ... }:
{
  imports = [
    ./desktop.nix
    ./apps/btop/btop.nix
    ./apps/cava/cava.nix
    ./apps/fastfetch/fastfetch.nix
    ./apps/ghostty/ghostty.nix
    ./apps/hypr/hypr.nix
    ./apps/quickshell/quickshell.nix
    ./apps/rofi/rofi.nix
    ./apps/swaync/swaync.nix
    ./apps/wallust/wallust.nix
    ./apps/waybar/waybar.nix
  ];

  home.username = "juand";
  home.homeDirectory = "/home/juand";
  home.stateVersion = "25.11";
  home.packages = with pkgs; [
    # System packages
    # The desktop environment used is Gnome 49.2
    # I had problems with right click in touchpad, it wasn't working
    # So I installed this gnome extension and run this command
    # gsettings set org.gnome.desktop.peripherals.touchpad click-method 'areas'
    # Just in case it happens again!
    gnome-tweaks

    # Apps
    alacritty-theme
    blesh

    # Hyprland related
    quickshell
    qt6.qtwayland
  ];

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      # Initialize Zoxide
      if command -v zoxide > /dev/null 2>&1; then
        export _Z0_DOCTOR=0
        eval "$(zoxide init --cmd cd bash)"
      fi

      # Initialize blesh
      if [ -f "$(blesh-share)"/ble.sh ]; then
        [[ $- == *i* ]] && source -- "$(blesh-share)"/ble.sh --attach=none
      fi
    '';
    initExtra = ''
      fastfetch

      # Attach blesh only for interactive shells
      if [[ $- == *i* ]] && [[ -n ''${BLE_VERSION-} ]]; then
        ble-attach
      fi
    '';
    shellAliases = {
      la = "ls -a";
      ".." = "cd ..";
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd = {
      enable = true;
      variables = [ "--all" ];
    };
  };

  programs.git = {
    enable = true;
    userName = "dosquisd";
    userEmail = "pereznjuandiego@gmail.com";
    lfs = {
      enable = true;
    };
    settings = {
      init.defaultBranch = "main";
      alias.tree = "log --graph --oneline --all --decorate";
      core.editor = "vim";
      push.autoSetupRemote = true;
    };
  };

  programs.vim.enable = true;
  programs.zoxide.enable = true;

  programs.oh-my-posh = {
    enable = true;
    useTheme = "hotstick.minimal";
    enableBashIntegration = true;
  };

  # Unfortunately, Ayu-Dark isn't included
  # in the Yazi themes in this repository: https://github.com/aguirre-matteo/nix-yazi-flavors,
  # but it might still be useful!
  # This is another repo: https://github.com/yazi-rs/flavors
  programs.yazi = {
    enable = true;
    flavors = {
      ayu-dark = pkgs.stdenv.mkDerivation {
        pname = "yazi-flavor-ayu-dark";
        version = "2025-03-02"; # yyyy-mm-dd

        src = pkgs.fetchFromGitHub {
          owner = "kmlupreti";
          repo = "ayu-dark.yazi";
          rev = "1da67a8195ebd0978fadc8cb1c6c9142ce331b8a";
          hash = "sha256-Jyl4Vo7H8WXtG9o4H0SkHneBztjGLMdNgQ4GkY01a0E=";
        };

        installPhase = ''
          mkdir -p $out
          cp $src/* $out/
        '';
      };
    };
  };

  programs.alacritty = {
    enable = true;
    theme = "moonfly";
    settings = {
      window = {
        opacity = 0.9;
        decorations = "None";
        padding = {
          x = 10;
          y = 10;
        };
      };
      font = {
        size = 10.5;
        normal = {
          family = "JetBrainsMono Nerd Font Mono";
          style = "bold";
        };
        bold = {
          family = "JetBrainsMono Nerd Font Mono";
        };
        italic = {
          family = "JetBrainsMono Nerd Font Mono";
        };
        bold_italic = {
          family = "JetBrainsMono Nerd Font Mono";
        };
      };
      cursor = {
        style = {
          shape = "Beam";
          blinking = "On";
        };
      };
      scrolling.multiplier = 1;
      bell = {
        animation = "EaseOutExpo";
        duration = 0;
      };
    };
  };
}
