#!/usr/bin/env bash

set -euo pipefail

# List of directories to sync
REPOS=(
  "$HOME/dotfiles"
  "$HOME/.local/scripts"
  "$HOME/personal/dev"
)

COMMIT_MESSAGE="automated dev commit"

echo "[INFO] Starting automated git commit and push..."

for dir in "${REPOS[@]}"; do
  echo -e "\n[INFO] Processing: $dir"

  if [ ! -d "$dir" ]; then
    echo "[SKIP] Directory does not exist: $dir"
    continue
  fi

  pushd "$dir" > /dev/null

  # Initialize Git if not already a repo
  if [ ! -d ".git" ]; then
    echo "[INIT] Git not initialized. Running git init..."
    git init
    git branch -M master 2>/dev/null || true
    echo "[INFO] Initialized empty Git repository in $dir"
    echo "[SKIP] No remote configured yet. Skipping push."
    popd > /dev/null
    continue
  fi

  # Check if remote is set
  if ! git remote get-url origin &> /dev/null; then
    echo "[WARN] No remote origin set. Skipping push for $dir"
    popd > /dev/null
    continue
  fi

  # Check if there's anything to commit
  if git status --porcelain | grep . > /dev/null; then
    git add .
    git commit -m "$COMMIT_MESSAGE"
    git push origin master
    echo "[DONE] Changes pushed in $dir"
  else
    echo "[SKIP] No changes to commit in $dir"
  fi

  popd > /dev/null
done

echo -e "\n[INFO] All done ✅"

