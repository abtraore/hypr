#!/bin/bash
BRIGHTNESS_FILE="/tmp/hypr_brightness"
[ ! -f "$BRIGHTNESS_FILE" ] && echo "100" > "$BRIGHTNESS_FILE"

CURRENT=$(cat "$BRIGHTNESS_FILE")

if [ "$1" = "up" ]; then
    NEW=$((CURRENT + 10))
    [ $NEW -gt 100 ] && NEW=100
elif [ "$1" = "down" ]; then
    NEW=$((CURRENT - 10))
    [ $NEW -lt 20 ] && NEW=20
else
    NEW=$1
fi

echo "$NEW" > "$BRIGHTNESS_FILE"

# Reset to identity (normal colors) then set gamma
hyprctl hyprsunset identity
hyprctl hyprsunset gamma $NEW
