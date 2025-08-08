#!/usr/bin/env bash

# Exit immediately on any error

set -e

# Ask for Git credentials

read -p "Enter your Git username: " GIT_USER

read -p "Enter your Git email: " GIT_EMAIL



echo "Configuring Git globally..."

git config --global user.name "$GIT_USER"

git config --global user.email "$GIT_EMAIL"

git config --global credential.helper store

git config --global init.defaultBranch master

echo "Git global configuration:"

git config --global --list

echo "✅ All tools installed, Git configured to use 'master' by default."
echo "✅ Git has been configured globally for user '$GIT_USER' with email '$GIT_EMAIL'."



