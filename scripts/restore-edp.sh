#!/usr/bin/env bash
# Force the internal laptop display back on after a hotplug glitch.
# Bound to SUPER+SHIFT+M in hyprland.lua; can also be run from a TTY:
#   HYPRLAND_INSTANCE_SIGNATURE=$(ls /run/user/$(id -u)/hypr | head -1) ~/.config/hypr/scripts/restore-edp.sh

# A Lua-config session refuses `hyprctl keyword`, so the monitor rule goes
# through hyprctl eval (hl.monitor) instead; the immediate refresh call
# applies it without re-running the whole config. Legacy sessions keep the
# keyword + reload path.
if [ "$(hyprctl eval 'return 1' 2>/dev/null)" = "ok" ]; then
    hyprctl eval 'hl.monitor({ output = "eDP-1", mode = "preferred", position = "0x0", scale = "1.25" })
hl.exec_scheduled_prop_refresh_immediately()
return 1'
else
    hyprctl keyword monitor "eDP-1, preferred, 0x0, 1.25"
    hyprctl reload
fi
notify-send "Display" "eDP-1 restored" 2>/dev/null
