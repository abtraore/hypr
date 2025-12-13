HOSTNAME=$(hostname)
MONITOR_CONFIG="$HOME/.config/hypr/monitors/${HOSTNAME}.conf"

if [ -f "$MONITOR_CONFIG" ]; then
    # Apply each line from the config
    while IFS= read -r line; do
        # Skip empty lines and comments
        [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]] && continue
        
        # Extract monitor keyword and apply
        if [[ "$line" =~ ^monitor ]]; then
            hyprctl keyword $line
        fi
    done < "$MONITOR_CONFIG"
else
    echo "No monitor config found for $HOSTNAME, using auto"
    hyprctl keyword monitor ,preferred,auto,1
fi
