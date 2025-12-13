# Source this from your shell configs (.bashrc, .zshrc, etc)
# Just add: [ -f ~/.config/hypr/shell-integration.sh ] && source ~/.config/hypr/shell-integration.sh

HYPR_DIR="$HOME/.config/hypr"
HYPR_SCRIPTS="$HYPR_DIR/hypr-scripts"

# Aliases
alias hyprpush='$HYPR_SCRIPTS/hypr_git_push.sh'
alias hyprpull='$HYPR_SCRIPTS/hypr_git_pull.sh'
alias hyprconf='nano ~/.config/hypr/hyprland.conf'
alias hyprreload='hyprctl reload'
