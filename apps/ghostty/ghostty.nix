{ config, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;

    enableBashIntegration = true;

    installVimSyntax = true;

    settings = {
      adjust-cell-height = "10%";
      background-blur-radius = 60;
      background-opacity = 1.00;
      bold-is-bright = false;
      confirm-close-surface = false;
      cursor-style = "bar";
      font-family = "FantasqueSansM Nerd Font Mono";
      font-size = 12;
      gtk-single-instance = true;
      mouse-hide-while-typing = true;
      quick-terminal-position = "center";
      selection-background = "#2d3f76";
      selection-foreground = "#c8d3f5";
      shell-integration = "detect";
      shell-integration-features = "cursor,sudo,ssh-env,ssh-terminfo";

      # OSC 52 clipboard
      clipboard-read = "allow";
      clipboard-write = "allow";
      clipboard-trim-trailing-spaces = true;
      clipboard-paste-protection = true; # confirm before pasting multiline "dangerous" text
      copy-on-select = "clipboard"; # copy on select, and also to the system clipboard
      term = "xterm-256color";
      title = "GhosTTY";
      unfocused-split-opacity = 0.5;
      wait-after-command = false;
      window-height = 32;
      window-save-state = "always";
      window-theme = "dark";
      window-width = 110;
      theme = "Floraverse";

      # Theme switching (optional): handled by your theme changer (symlink or generated file).
      # Wallust (optional): the wallust template should write the Ghostty colors here;
      # this will override the theme colors.
      # NOTE: "config-file" is repeated in your original .config -> represented as a list.
      config-file = [
        "?~/.config/ghostty/theme.conf"
        "?~/.config/ghostty/wallust.conf"
      ];
    };
  };
}
