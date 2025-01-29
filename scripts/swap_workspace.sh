#!/bin/bash

# non funge

# Check if a target workspace is provided as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <target_workspace_number>"
    exit 1
fi

# Target workspace to swap with
TARGET_WORKSPACE=$1

# Ensure the target workspace is an integer
if ! [[ "$TARGET_WORKSPACE" =~ ^[0-9]+$ ]]; then
    echo "Error: Target workspace must be an integer."
    exit 1
fi

# Get the current workspace
CURRENT_WORKSPACE=$(hyprctl monitors | grep "active workspace" | awk '{print $3}'| head -n 1)

# Ensure CURRENT_WORKSPACE is not empty
if [ -z "$CURRENT_WORKSPACE" ]; then
    echo "Error: Unable to determine the current workspace."
    exit 1
fi

# Exit if the target workspace is the same as the current workspace
if [ "$CURRENT_WORKSPACE" -eq "$TARGET_WORKSPACE" ]; then
    echo "Current workspace is the same as the target workspace. No swap needed."
    exit 0
fi

# Get the list of window IDs on the current workspace
CURRENT_WS_WINDOWS=$(hyprctl clients | grep "workspace $CURRENT_WORKSPACE" | awk '{print $2}')

# Get the list of window IDs on the target workspace
TARGET_WS_WINDOWS=$(hyprctl clients | grep "workspace $TARGET_WORKSPACE" | awk '{print $2}')

# Move windows from the current workspace to the target workspace
for WIN_ID in $CURRENT_WS_WINDOWS; do
    hyprctl dispatch movetoworkspace "$TARGET_WORKSPACE" $WIN_ID
done

# Move windows from the target workspace to the current workspace
for WIN_ID in $TARGET_WS_WINDOWS; do
    hyprctl dispatch movetoworkspace "$CURRENT_WORKSPACE" $WIN_ID
done

echo "Swapped windows between workspace $CURRENT_WORKSPACE and workspace $TARGET_WORKSPACE."
