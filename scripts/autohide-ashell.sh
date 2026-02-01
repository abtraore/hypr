#!/bin/bash
# save as ~/.config/hypr/scripts/autohide-ashell.sh

IDLE_TIME=30  # seconds before hiding

while true; do
    idle=$(hyprctl activeworkspace -j | jq '.hasfullscreen')
    if [ "$idle" = "true" ]; then
        pkill ashell
    else
        pgrep ashell || ashell &
    fi
    sleep 5
done
