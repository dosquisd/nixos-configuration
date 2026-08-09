#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Simple bash script to check and will try to update your system

# Local Paths
iDIR="/etc/nixos/apps/swaync/images"

launch_update_terminal() {
  local update_command="$1"

  if command -v ghostty &> /dev/null; then
    ghostty --title update -e bash -lc "$update_command"
  elif command -v kitty &> /dev/null; then
    kitty -T update bash -lc "$update_command"
  else
    notify-send -i "$iDIR/error.png" "No terminal found" "Install ghostty or kitty to run distro updates from this script."
    exit 1
  fi
}

# Detect distribution and update accordingly
if command -v nixos-rebuild &> /dev/null; then
  launch_update_terminal "sudo nixos-rebuild switch -I nixos-config=/etc/nixos/configuration.nix"
elif command -v paru &> /dev/null || command -v yay &> /dev/null; then
  # Arch-based
  if command -v paru &> /dev/null; then
    launch_update_terminal "paru -Syu"
    notify-send -i "$iDIR/ja.png" -u low 'Arch-based system' 'has been updated.'
  else
    launch_update_terminal "yay -Syu"
    notify-send -i "$iDIR/ja.png" -u low 'Arch-based system' 'has been updated.'
  fi
elif command -v dnf &> /dev/null; then
  # Fedora-based
  launch_update_terminal "sudo dnf update --refresh -y"
  notify-send -i "$iDIR/ja.png" -u low 'Fedora system' 'has been updated.'
elif command -v apt &> /dev/null; then
  # Debian-based (Debian, Ubuntu, etc.)
  launch_update_terminal "sudo apt update && sudo apt upgrade -y"
  notify-send -i "$iDIR/ja.png" -u low 'Debian/Ubuntu system' 'has been updated.'
elif command -v zypper &> /dev/null; then
  # openSUSE-based
  launch_update_terminal "sudo zypper dup -y"
  notify-send -i "$iDIR/ja.png" -u low 'openSUSE system' 'has been updated.'
else
  # Unsupported distro
  notify-send -i "$iDIR/error.png" -u critical "Unsupported system" "This script does not support your distribution."
  exit 1
fi
