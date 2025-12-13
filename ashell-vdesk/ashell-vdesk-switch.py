#!/usr/bin/env python3
"""
Click handler script for hyprland-virtual-desktops plugin.
Switches to the specified virtual desktop when called from ashell custom module.
"""

import subprocess
import sys


def switch_vdesk(vdesk_id):
    """Switch to the specified virtual desktop using hyprctl dispatch vdesk."""
    try:
        subprocess.run(
            ["hyprctl", "dispatch", "vdesk", str(vdesk_id)],
            check=True,
            timeout=2
        )
        return True
    except subprocess.CalledProcessError as e:
        print(f"Error switching virtual desktop: {e}", file=sys.stderr)
        return False
    except subprocess.TimeoutExpired:
        print("Timeout switching virtual desktop", file=sys.stderr)
        return False
    except Exception as e:
        print(f"Unexpected error: {e}", file=sys.stderr)
        return False


def main():
    """Main function: get virtual desktop ID from command line and switch to it."""
    if len(sys.argv) < 2:
        print("Usage: ashell-vdesk-switch.py <vdesk_id>", file=sys.stderr)
        print("Example: ashell-vdesk-switch.py 1", file=sys.stderr)
        print("Example: ashell-vdesk-switch.py coding", file=sys.stderr)
        sys.exit(1)
    
    vdesk_id = sys.argv[1]
    
    if switch_vdesk(vdesk_id):
        sys.exit(0)
    else:
        sys.exit(1)


if __name__ == "__main__":
    main()

