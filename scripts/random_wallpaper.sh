#!/bin/bash

# Directory containing wallpapers
WALLPAPER_DIR="/home/fed/Pictures/wallpapers"

# Log file
LOG_FILE="/home/fed/.config/hypr/scripts/wallpaper_changer.log"
# Start logging
exec >> "$LOG_FILE" 2>&1
echo "-------------------------------------"
echo "$(date): Starting wallpaper changer script."

# Pick a random wallpaper
if [ -d "$WALLPAPER_DIR" ]; then
    RANDOM_WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
    echo "Random wallpaper selected: $RANDOM_WALLPAPER"
else
    echo "Error: Wallpaper directory does not exist: $WALLPAPER_DIR"
    exit 1
fi

# Generate Hyprpaper config
echo "Generating Hyprpaper configuration..."
{
    echo "[wallpaper]"
    echo "monitor=*,${RANDOM_WALLPAPER}"
} > ~/.config/hypr/hyprpaper.conf
echo "Hyprpaper configuration generated at ~/.config/hypr/hyprpaper.conf."

# Start Hyprpaper
#hyprpaper &  
waypaper --wallpaper $RANDOM_WALLPAPER