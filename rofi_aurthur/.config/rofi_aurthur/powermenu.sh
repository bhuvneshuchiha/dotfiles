#!/bin/bash

# Power Menu Options with Icons (Nerd Fonts or Font Awesome)
options="⏻  Power Off\n  Reboot\n󰤄  Suspend\n  Logout\n  Lock"

# Rofi command
selected=$(echo -e "$options" | rofi -dmenu -i -p "Power Menu")

# Action handler
case "$selected" in
    *"Power Off"*) systemctl poweroff ;;
    *"Reboot"*) systemctl reboot ;;
    *"Suspend"*) systemctl suspend ;;
    *"Logout"*) hyprctl dispatch exit ;;
    *"Lock"*) ~/.config/hypr/scripts/lock.sh ;;  # Or swaylock, etc.
esac

