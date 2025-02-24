#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "SCRIPT RUNNING FROM ${SCRIPT_DIR}"

# Set the directories for the new and old configurations
NEW_CONFIGS=$SCRIPT_DIR
OLD_CONFIGS=~/.config

# Function to replace a config:
# - Backs up the old config (if it exists and hasn't been backed up already)
# - Creates a symbolic link in OLD_CONFIGS pointing to the NEW_CONFIGS version
replace_config() {
  local config="$1"
  local new_config="${NEW_CONFIGS}/${config}"
  local old_config="${OLD_CONFIGS}/${config}"
  local backup_config="${old_config}_bak"

  echo "Processing ${config} config..."

  # Ensure the new config directory exists
  if [ ! -d "$new_config" ]; then
    echo "New config for ${config} not found at ${new_config}. Skipping."
    return 1
  fi

  # If an old config exists, back it up
  if [ -e "$old_config" ]; then
    # If it's a directory (and not already a symlink), move it to backup
    if [ -d "$old_config" ] && [ ! -L "$old_config" ]; then
      if [ -d "$backup_config" ]; then
        echo "Backup for ${config} already exists at ${backup_config}. Skipping backup."
      else
        echo "Old config found at ${old_config}. Moving to backup..."
        mv "$old_config" "$backup_config" || { echo "Failed to move ${old_config} to ${backup_config}"; return 1; }
      fi
    else
      # If it exists but isn't a plain directory (could be an old symlink or file), remove it first
      echo "${old_config} exists but is not a directory. Removing it..."
      rm -rf "$old_config" || { echo "Failed to remove ${old_config}"; return 1; }
    fi
  fi

  # Create a symbolic link in OLD_CONFIGS to point to the NEW_CONFIGS version
  ln -s "$new_config" "$old_config" && \
    echo "Created symbolic link: ${old_config} -> ${new_config}" || \
    { echo "Failed to create symbolic link for ${config}"; return 1; }
}

# List of configuration names to process (directories in NEW_CONFIGS)
configs=("ghostty" "fish" "tmux")

# Loop over each configuration and replace it
for config in "${configs[@]}"; do
  replace_config "$config"
done
