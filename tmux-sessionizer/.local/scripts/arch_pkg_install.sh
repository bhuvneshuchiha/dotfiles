#!/usr/bin/env bash

# Exit immediately on any error

set -e

# Ask for Git credentials

read -p "Enter your Git username: " GIT_USER

read -p "Enter your Git email: " GIT_EMAIL

echo "Updating system..."

sudo pacman -Syu --noconfirm

echo "Installing base packages from pacman..."

sudo pacman -S --noconfirm \

  neovim \

  jq \

  gimp \

  alacritty \

  go \

  python \

  nodejs \

  npm \

  git \

  base-devel \

  tldr \

  eza \

  zsh \

  tmux

# Install yay if not already installed

if ! command -v yay &> /dev/null; then

  echo "Installing yay..."

  cd /tmp

  git clone https://aur.archlinux.org/yay.git

  cd yay

  makepkg -si --noconfirm

fi

echo "Installing AUR packages with yay..."

yay -S --noconfirm \

  brave-bin \

  ghostty-git \

  zenity

echo "Configuring Git globally..."

git config --global user.name "$GIT_USER"

git config --global user.email "$GIT_EMAIL"

git config --global credential.helper store

git config --global init.defaultBranch master

echo "Git global configuration:"

git config --global --list

echo "✅ All tools installed, Git configured to use 'master' by default."


