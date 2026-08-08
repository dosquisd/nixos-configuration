{
  programs.fastfetch = {
    enable = true;
    settings = {
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
