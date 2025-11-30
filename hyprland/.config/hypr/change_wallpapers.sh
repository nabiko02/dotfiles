#!/usr/bin/env bash

# Wait until hyprpaper socket is available
SOCKET_PATH=$(find /run/user/$(id -u)/hypr/ -name ".hyprpaper.sock" 2>/dev/null)
while [ ! -S "$SOCKET_PATH" ]; do
    sleep 0.5
    SOCKET_PATH=$(find /run/user/$(id -u)/hypr/ -name ".hyprpaper.sock" 2>/dev/null)
done

WALLPAPER_DIR="$HOME/.config/hypr/wallpapers/"
CURRENT_WALL=$(hyprctl hyprpaper listloaded)

WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)

hyprctl hyprpaper reload ,"$WALLPAPER"

HYPRLOCK_BACKGROUND="$HOME/.config/hypr/hyprlock-resources/hyprlock.png"
ln -s -f $WALLPAPER $HYPRLOCK_BACKGROUND
