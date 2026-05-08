#!/bin/bash

# Folder containing wallpapers
WALLPAPER_DIR="$HOME/Pictures/wallpapers"

# Find image files
selected=$(find "$WALLPAPER_DIR" \
  \( -iname "*.jpg" -o \
     -iname "*.jpeg" -o \
     -iname "*.png" -o \
     -iname "*.webp" \) | fzf)

# Exit if nothing selected
[ -z "$selected" ] && exit 0

# Set wallpaper for all desktops
osascript <<EOF
tell application "System Events"
    tell every desktop
        set picture to "$selected"
    end tell
end tell
EOF

echo "Wallpaper changed to:"
echo "$selected"
