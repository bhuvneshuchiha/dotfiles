# # #!/bin/bash
# #
# # # List available Wi-Fi networks and pass them to rofi/dmenu
# # SSID=$(nmcli device wifi list | awk '{print $2}' | tail -n +2 | rofi -dmenu -i -p "Select Wi-Fi")
# #
# # if [ -n "$SSID" ]; then
# #     # Prompt for the password
# #     PASSWORD=$(rofi -dmenu -password -p "Password" )
# #     nmcli device wifi connect "$SSID" password "$PASSWORD"
# # fi
#
# #!/bin/bash
#
# # List available Wi-Fi networks without trimming SSID names and pass them to rofi/dmenu
# SSID=$(nmcli -f SSID device wifi list | tail -n +2 | rofi -dmenu -i -p "Select Wi-Fi")
#
# if [ -n "$SSID" ]; then
#     # Prompt for the password
#     PASSWORD=$(rofi -dmenu -password -p "Password")
#     nmcli device wifi connect "$SSID" password "$PASSWORD"
# fi
#

#!/bin/bash

# Get list of available Wi-Fi networks
networks=$(nmcli -t -f SSID dev wifi)

# Use Rofi to display the list of networks and select one
selected=$(echo "$networks" | rofi -dmenu -p "Select Wi-Fi" -i)

# If a network is selected, connect to it
if [ -n "$selected" ]; then
    # Connect to the selected network
    nmcli dev wifi connect "$selected"
fi
