#!/usr/bin/env python3
"""
Query script for hyprland-virtual-desktops plugin.
Outputs current virtual desktop state in Waybar JSON format for ashell custom module.
"""

import json
import subprocess
import sys
import time


def get_current_vdesk():
    """Query the current virtual desktop using hyprctl printdesk."""
    try:
        result = subprocess.run(
            ["hyprctl", "printdesk"],
            capture_output=True,
            text=True,
            check=True,
            timeout=1
        )
        # Strip whitespace and newlines from output
        output = result.stdout.strip()
        
        # Parse output - it may be:
        # - Just a number: "1"
        # - A name: "coding"
        # - Formatted: "Virtual desk 1: 1" or similar
        # Try to extract just the desktop identifier
        if ":" in output:
            # Format like "Virtual desk 1: 1" - extract the part after the colon
            parts = output.split(":", 1)
            if len(parts) > 1:
                vdesk = parts[1].strip()
            else:
                vdesk = output
        else:
            vdesk = output
        
        return vdesk
    except subprocess.CalledProcessError as e:
        # If command fails, return empty string or default
        print(f"Error running hyprctl printdesk: {e}", file=sys.stderr)
        return ""
    except subprocess.TimeoutExpired:
        print("Timeout running hyprctl printdesk", file=sys.stderr)
        return ""
    except Exception as e:
        print(f"Unexpected error: {e}", file=sys.stderr)
        return ""


def output_json(vdesk):
    """Output virtual desktop state as JSON in Waybar format."""
    output = {
        "text": vdesk,
        "alt": f"vdesk_{vdesk}"
    }
    print(json.dumps(output))
    sys.stdout.flush()


def main():
    """Main loop: poll for virtual desktop changes and output JSON."""
    last_vdesk = None
    
    while True:
        try:
            current_vdesk = get_current_vdesk()
            
            # Only output if the virtual desktop has changed
            if current_vdesk != last_vdesk:
                output_json(current_vdesk)
                last_vdesk = current_vdesk
            
            # Poll every 0.5 seconds
            time.sleep(0.5)
            
        except KeyboardInterrupt:
            # Graceful shutdown on Ctrl+C
            break
        except Exception as e:
            print(f"Error in main loop: {e}", file=sys.stderr)
            time.sleep(1)  # Wait a bit longer on error before retrying


if __name__ == "__main__":
    main()

