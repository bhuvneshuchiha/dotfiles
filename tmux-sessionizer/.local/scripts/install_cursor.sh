#!/bin/bash

installCursor() {
if ! [ -f /opt/cursor.appimage ]; then
echo "Installing Cursor AI IDE..."

    # URLs for Cursor AppImage and Icon
    CURSOR_URL="https://downloads.cursor.com/production/8ea935e79a50a02da912a034bbeda84a6d3d355d/linux/x64/Cursor-0.50.4-x86_64.AppImage"
    ICON_URL="https://us1.discourse-cdn.com/flex020/uploads/cursor1/original/2X/a/a4f78589d63edd61a2843306f8e11bad9590f0ca.png"

    # Paths for installation
    APPIMAGE_PATH="/opt/cursor.appimage"
    ICON_PATH="/opt/cursor.png"
    DESKTOP_ENTRY_PATH="/usr/share/applications/cursor.desktop"

    # Install curl if not installed
    if ! command -v curl &> /dev/null; then
        echo "curl is not installed. Installing..."
        sudo apt-get update
        sudo apt-get install -y curl
    fi

    # Download Cursor AppImage
    echo "Downloading Cursor AppImage..."
    sudo curl -L $CURSOR_URL -o $APPIMAGE_PATH
    sudo chmod +x $APPIMAGE_PATH

    # Download Cursor icon
    echo "Downloading Cursor icon..."
    sudo curl -L $ICON_URL -o $ICON_PATH

    # Create a .desktop entry for Cursor
    echo "Creating .desktop entry for Cursor..."
    sudo bash -c "cat > $DESKTOP_ENTRY_PATH" <<EOL
[Desktop Entry]
Name=Cursor AI IDE
Exec=$APPIMAGE_PATH --no-sandbox
Icon=$ICON_PATH
Type=Application
Categories=Development;
EOL

    echo "Adding cursor alias to .bashrc..."
    bash -c "cat >> $HOME/.bashrc" <<EOL

# Cursor alias
function cursor() {
    /opt/cursor.appimage --no-sandbox "${@}" > /dev/null 2>&1 & disown
}
EOL

    source $HOME/.bashrc

    echo "Cursor AI IDE installation complete. You can find it in your application menu."
else
    echo "Cursor AI IDE is already installed."
fi
}

installCursor
