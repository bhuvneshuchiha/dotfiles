#!/usr/bin/env bash

# Exit if any command fails
set -e

# List of packages to install
PACMAN_PACKAGES=(
  btop
  brave
  gimp
  alacritty
  golang
  python
  nodejs
  reflector
  rsync
  libreoffice-still
  zathura
  jq
  fzf
  eza
  zsh
  tmux
  rofi-wayland
  nwg-look
  waybar
)

AUR_PACKAGES=(
  yay
  zen-browser
  ghostty
  go-air
  powerlevel10k
)

# Check if yay is installed, else install it via git
if ! command -v yay &> /dev/null; then
  echo "Installing yay (AUR helper)..."
  sudo pacman -S --needed git base-devel
  git clone https://aur.archlinux.org/yay.git ~/yay && cd ~/yay
  makepkg -si --noconfirm
  cd ~ && rm -rf ~/yay
fi

# Update system first
echo "Updating system..."
sudo pacman -Syu --noconfirm

# Install pacman packages
echo "Installing packages from pacman..."
for pkg in "${PACMAN_PACKAGES[@]}"; do
  if ! pacman -Qi "$pkg" &> /dev/null; then
    echo "Installing $pkg..."
    sudo pacman -S --noconfirm "$pkg"
  else
    echo "$pkg is already installed."
  fi
done

# Install AUR packages
echo "Installing packages from AUR using yay..."
for pkg in "${AUR_PACKAGES[@]}"; do
  if ! yay -Qi "$pkg" &> /dev/null; then
    echo "Installing $pkg..."
    yay -S --noconfirm "$pkg"
  else
    echo "$pkg is already installed."
  fi
done

echo "✅ All packages installed successfully!"

