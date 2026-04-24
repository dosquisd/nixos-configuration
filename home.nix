# https://nixos.wiki/wiki/Home_Manager
# https://nix-community.github.io/home-manager//* Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ]; */

{ config, pkgs, ... }:
{
  home.username = "juand";
  home.homeDirectory = "/home/juand";
  home.stateVersion = "25.11";
  home.packages = with pkgs; [
    # System packages
    # The desktop environment is use is Gnome 49.2
    # I had problems with right click in touchpad, it wasn't working
    # So I installed this gnome extension and run this command
    # gsettings set org.gnome.desktop.peripherals.touchpad click-method 'areas'
    # Just in case it happens again!
    gnome-tweaks

    # Apps
    alacritty-theme
    blesh
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

  programs.git = {
    enable = true;
    userName  = "dosquisd";
    userEmail = "pereznjuandiego@gmail.com";
    lfs = {
      enable = true;
    };
    settings = {
      init.defaultBranch = "main";
      alias.tree = "log --graph --oneline --all --decorate";
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
        version = "2025-03-02";  # yyyy-mm-dd

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

  programs.fastfetch = {
    enable = true;
    settings =  {
      logo = {
        padding = {
          top = 1;
        };
      };
      display = {
        separator = " 󰑃  ";
      };
      modules = [
        "break"
        {
          type = "os";
          key = " DISTRO";
          keyColor = "yellow";
        }
        {
          type = "kernel";
          key = "│ ├";
          keyColor = "yellow";
        }
        {
          type = "packages";
          key = "│ ├󰏖";
          keyColor = "yellow";
        }
        {
          type = "shell";
          key = "│ └";
          keyColor = "yellow";
        }
        {
          type = "wm";
          key = " DE/WM";
          keyColor = "blue";
        }
        {
          type = "wmtheme";
          key = "│ ├󰉼";
          keyColor = "blue";
        }
        {
          type = "icons";
          key = "│ ├󰀻";
          keyColor = "blue";
        }
        {
          type = "cursor";
          key = "│ ├";
          keyColor = "blue";
        }
        {
          type = "terminalfont";
          key = "│ ├";
          keyColor = "blue";
        }
        {
          type = "terminal";
          key = "│ └";
          keyColor = "blue";
        }
        {
          type = "host";
          key = "󰌢 SYSTEM";
          keyColor = "green";
        }
        {
          type = "cpu";
          key = "│ ├󰻠";
          keyColor = "green";
        }
        {
          type = "gpu";
          key = "│ ├󰻑";
          format = "{2}";
          keyColor = "green";
        }
        {
          type = "display";
          key = "│ ├󰍹";
          keyColor = "green";
          compactType = "original-with-refresh-rate";
        }
        {
          type = "memory";
          key = "│ ├󰾆";
          keyColor = "green";
        }
        {
          type = "swap";
          key = "│ ├󰓡";
          keyColor = "green";
        }
        {
          type = "uptime";
          key = "│ ├󰅐";
          keyColor = "green";
        }
        {
          type = "display";
          key = "│ └󰍹";
          keyColor = "green";
        }
        {
          type = "sound";
          key = " AUDIO";
          format = "{2}";
          keyColor = "magenta";
        }
        {
          type = "player";
          key = "│ ├󰥠";
          keyColor = "magenta";
        }
        {
          type = "media";
          key = "│ └󰝚";
          keyColor = "magenta";
        }
        {
          type = "custom";
          format = "{#90}{#}  {#31}{#}  {#32}{#}  {#33}{#}  {#34}{#}  {#35}{#}  {#36}{#}  {#37}{#}  {#38}{#}  {#39}    {#}  {#38}{#}  {#37}{#}  {#36}{#}  {#35}{#}  {#34}{#}  {#33}{#}  {#32}{#}  {#31}{#}  {#90}{#} ";
        }
        "break"
      ];
    };
  };
}
