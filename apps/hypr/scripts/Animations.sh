#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# For applying Animations from different users

# Check if rofi is already running
if pidof rofi > /dev/null; then
  pkill rofi
fi

# Variables
iDIR="/etc/nixos/apps/swaync/images"
SCRIPTSDIR="/etc/nixos/apps/hypr/scripts"
animations_dir="/etc/nixos/apps/hypr/animations"
UserConfigs="/etc/nixos/apps/hypr/UserConfigs"
rofi_theme="/etc/nixos/apps/rofi/config-Animations.rasi"
msg='❗NOTE:❗ This will copy animations into UserAnimations.conf'
# list of animation files, sorted alphabetically with numbers first
animations_list=$(find -L "$animations_dir" -maxdepth 1 -type f | sed 's/.*\///' | sed 's/\.conf$//' | sort -V)

# Rofi Menu
chosen_file=$(echo "$animations_list" | rofi -i -dmenu -config $rofi_theme -mesg "$msg")

# Check if a file was selected
if [[ -n "$chosen_file" ]]; then
    full_path="$animations_dir/$chosen_file.conf"    
    cp "$full_path" "$UserConfigs/UserAnimations.conf"    
    notify-send -u low -i "$iDIR/ja.png" "$chosen_file" "Hyprland Animation Loaded"
fi

sleep 1
"$SCRIPTSDIR/RefreshNoWaybar.sh"
