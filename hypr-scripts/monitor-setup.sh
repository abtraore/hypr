#!/bin/bash
HOSTNAME=$(hostname)
MONITOR_CONFIG="$HOME/.config/hypr/monitors/${HOSTNAME}.conf"

if [ -f "$MONITOR_CONFIG" ]; then
    while IFS= read -r line; do
        [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]] && continue
        
        if [[ "$line" =~ ^monitor ]]; then
            # Remove "monitor = " or "monitor=" and pass the rest
            monitor_params=$(echo "$line" | sed 's/^monitor[[:space:]]*=[[:space:]]*//')
            hyprctl keyword monitor "$monitor_params"
        fi
    done < "$MONITOR_CONFIG"
else
    hyprctl keyword monitor ,preferred,auto,1
fi
