# Ashell Virtual Desktop Module

A custom module for [ashell](https://github.com/MalpenZibo/ashell) that displays virtual desktops from the [hyprland-virtual-desktops](https://github.com/levnikmyskin/hyprland-virtual-desktops) plugin.

## Overview

This project provides Python scripts that integrate with ashell's custom module system to display and switch between virtual desktops managed by the hyprland-virtual-desktops plugin.

## Requirements

- Python 3
- Hyprland compositor
- [hyprland-virtual-desktops](https://github.com/levnikmyskin/hyprland-virtual-desktops) plugin installed and configured
- [ashell](https://github.com/MalpenZibo/ashell) status bar

## Files

- `ashell-vdesk.py` - Main script that queries and outputs virtual desktop state
- `ashell-vdesk-switch.py` - Script that handles virtual desktop switching on click

## Installation

1. Ensure the scripts are executable:
   ```bash
   chmod +x ashell-vdesk.py ashell-vdesk-switch.py
   ```

2. Add the custom module configuration to your ashell config file (`~/.config/ashell/config.toml`):

   ```toml
   [[CustomModule]]
   name = "VirtualDesktops"
   icon = "󰨳"  # Desktop icon (you can change this)
   command = "python3 /home/prof/oss/ashell-vdesk/ashell-vdesk-switch.py"
   listen_cmd = "python3 /home/prof/oss/ashell-vdesk/ashell-vdesk.py"
   ```

3. Update the paths in the config to match your installation location.

4. Restart ashell or reload the configuration.

## How It Works

### Query Script (`ashell-vdesk.py`)

- Polls `hyprctl printdesk` every 0.5 seconds to get the current virtual desktop
- Parses the output (handles formats like "Virtual desk 1: 1" or just "1" or named desktops like "coding")
- Outputs JSON in Waybar format: `{"text": "<vdesk>", "alt": "vdesk_<vdesk>"}`
- Only outputs when the virtual desktop changes to reduce overhead

### Switch Script (`ashell-vdesk-switch.py`)

- Accepts a virtual desktop ID or name as a command-line argument
- Calls `hyprctl dispatch vdesk <id>` to switch to the specified virtual desktop
- Used by ashell when you click on the virtual desktop module

## Configuration

The virtual desktop names/IDs displayed depend on your hyprland-virtual-desktops plugin configuration. If you have named virtual desktops (e.g., "1:coding, 2:internet"), the script will display those names. Otherwise, it will show numeric IDs.

## Troubleshooting

### Script doesn't output anything

- Verify `hyprctl printdesk` works: `hyprctl printdesk`
- Check that the hyprland-virtual-desktops plugin is loaded in your Hyprland config
- Ensure Python 3 is installed: `python3 --version`

### Clicking doesn't switch virtual desktops

- Test the switch script manually: `python3 ashell-vdesk-switch.py 1`
- Verify `hyprctl dispatch vdesk 1` works in your terminal
- Check that the command path in your ashell config is correct

### Module not appearing in ashell

- Verify the CustomModule configuration is correct in `~/.config/ashell/config.toml`
- Check that the module name is included in your modules list (e.g., in `modules.left`, `modules.center`, or `modules.right`)
- Restart ashell after configuration changes

## License

This project is provided as-is for use with ashell and hyprland-virtual-desktops.

