
#
# #!/bin/bash
#
# # Wait a moment for monitors to be recognized
# sleep 1
#
# # Get connected monitors
# MONITORS=$(hyprctl monitors | grep "Monitor" | awk '{print $2}')
#
# if echo "$MONITORS" | grep -q "HDMI-A-1"; then
#     # External monitor is connected: use it, disable laptop
#     hyprctl keyword monitor "HDMI-A-1,preferred,auto,1.6"
#     hyprctl keyword monitor "eDP-1,disable"
# else
#     # External monitor not connected: use laptop
#     hyprctl keyword monitor "eDP-1,preferred,auto,1"
# fi


#!/bin/bash

# Function to apply layout based on connected monitors
apply_layout() {
    # Wait briefly for monitors to settle
    sleep 1

    # Get connected monitor list
    MONITORS=$(hyprctl monitors | grep "Monitor" | awk '{print $2}')

    if echo "$MONITORS" | grep -q "HDMI-A-1"; then
        echo "External monitor connected. Enabling HDMI-A-1 and disabling eDP-1"
        hyprctl keyword monitor "HDMI-A-1,preferred,auto,1.6"
        hyprctl keyword monitor "eDP-1,disable"
    else
        echo "External monitor disconnected. Enabling eDP-1"
        hyprctl keyword monitor "eDP-1,preferred,auto,1"
    fi
}

# Initial run
apply_layout

# Watch for monitor plug/unplug via udev
udevadm monitor --subsystem-match=drm | while read -r line; do
    if echo "$line" | grep -q "change"; then
        apply_layout
    fi
done

