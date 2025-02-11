#!/bin/bash


set_wallpaper()
{
    local IMG="$1"
    if [ $XDG_CURRENT_DESKTOP = "ubuntu:GNOME" ]; then
        gsettings set org.gnome.desktop.background picture-uri-dark "file://$IMG"
    elif [ $XDG_CURRENT_DESKTOP = "i3" ]; then
        feh --bg-fill "$IMG"
        # copying current wallpaper to use with i3lock
        cp $IMG /tmp/i3lock.png
    fi
    echo "Wallpaper set to: $IMG"
}

WALLPAPER_PATH="$1"

WALLPAPER_PATH=$(readlink -f "$WALLPAPER_PATH")

echo $PWD

# check if wallpaper_path is not empty and a file
if [ -n "$WALLPAPER_PATH" ] && [ -f "$WALLPAPER_PATH" ]; then
    echo "Setting wallpaper: $WALLPAPER_PATH"
    set_wallpaper "$WALLPAPER_PATH"
else
    echo "Setting random wallpaper..."
    WALLPAPER_DARK="$PWD/dark"
    WALLPAPER_GRUV="$PWD/gruvbox"
    WALLPAPER_BLUE="$PWD/blue_purple"

    # get all images under wallpaper dir
    IMAGES=("$WALLPAPER_DARK"/* "$WALLPAPER_GRUV"/* "$WALLPAPER_BLUE"/*)

    RANDOM_IMAGE="${IMAGES[RANDOM % ${#IMAGES[@]}]}"
    set_wallpaper "$RANDOM_IMAGE"
fi
