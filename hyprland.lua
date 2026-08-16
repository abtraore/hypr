-- =============================================================================
-- Hyprland main config (Lua; migrated 2026-08-16 from hyprland.conf)
-- Legacy backup: hyprland.conf.pre-lua.bak
-- Machine-specific overrides: local.lua (required below)
-- Wiki: https://wiki.hypr.land/Configuring/Start/
-- =============================================================================

require("./local")

------------------
---- MY PROGRAMS ----
------------------

local terminal    = "kitty"
local fileManager = "nautilus --new-window"
local menu        = 'rofi -modes "run" -show drun'
local mainMod     = "SUPER"
local home        = os.getenv("HOME") or ""

-------------------
---- AUTOSTART ----
-------------------
-- Replaces the old `exec-once = ...` lines (run once per session start).

hl.on("hyprland.start", function ()
    hl.exec_cmd("gsettings set org.gnome.desktop.wm.preferences button-layout ':'")
    hl.exec_cmd('element-desktop --password-store="gnome-libsecret"')
    hl.exec_cmd('signal-desktop --password-store="gnome-libsecret"')
    hl.exec_cmd("thunderbird")
    hl.exec_cmd("claude-desktop")
    hl.exec_cmd("firefox")
    hl.exec_cmd("lm-studio")
    hl.exec_cmd("nm-applet &")
    hl.exec_cmd("raybar")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("sleep 1 && awww restore")
    hl.exec_cmd("udiskie")
    hl.exec_cmd("hyprsunset")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("gnome-keyring-daemon --start --components=secrets,ssh")
    hl.exec_cmd("dunst")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("kdeconnect-indicator")
    hl.exec_cmd("tudo")
    hl.exec_cmd("ablife")
    -- hl.exec_cmd("hyprpm reload -n")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Sweet-cursors")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("SSH_AUTH_SOCK", os.getenv("XDG_RUNTIME_DIR") .. "/gcr/ssh")
-- hl.env("SSH_ASKPASS", "/usr/lib/seahorse/ssh-askpass")
-- hl.env("SSH_ASKPASS_REQUIRE", "prefer")

-------------------
---- PERMISSIONS ----
-------------------
-- Restart required to apply; kept commented as before.
-- hl.config({ ecosystem = { enforce_permissions = true } })
-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")

-----------------
---- LOOK & FEEL ----
-----------------

hl.config({
    general = {
        gaps_in     = 5,
        gaps_out    = 8,
        border_size = 2,
        col = {
            active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },
        resize_on_border = true,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding         = 10,
        rounding_power   = 2,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled      = false,
            range        = 4,
            render_power = 3,
            color        = "rgba(1a1a1aee)",
        },
        blur = {
            -- keep disabled: blur is the biggest iGPU compositor cost
            enabled  = false,
            size     = 3,
            passes   = 1,
            vibrancy = 0.1696,
        },
    },

    animations = { enabled = true },

    dwindle = { preserve_split = true },
    master  = { new_status = "master" },

    misc = {
        force_default_wallpaper  = -1,
        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
    },

    input = {
        kb_layout    = "us",
        kb_variant   = "intl",
        follow_mouse = 1,
        sensitivity  = 0,
        touchpad     = { natural_scroll = false },
    },
})

-- Default curves and animations (same values as the legacy config).
-- Note: the built-in "default" bezier comes from hyprutils; custom curves
-- must be defined before the hl.animation calls that use them.

hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1} } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1} } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1} } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1} } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1} } })

hl.animation({ leaf = "global",        enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true, speed = 7,    bezier = "quick" })

-- Smart gaps / "no gaps when only" (uncomment to use, as before)
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({ name = "no-borders-w1", match = { float = false, workspace = "w[tv1]" }, border_size = 0, rounding = 0 })
-- hl.window_rule({ name = "no-borders-f1", match = { float = false, workspace = "f[1]" },   border_size = 0, rounding = 0 })

--------------
---- INPUT ----
--------------

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

hl.device({ name = "epic-mouse-v1", sensitivity = -0.5 })

-----------------
---- KEYBINDS ----
-----------------

-- caps_lock sends escape to the active window
hl.bind("Caps_Lock", hl.dsp.send_shortcut({ mods = "", key = "escape" }))

hl.bind(mainMod .. " + F",            hl.dsp.window.fullscreen({ mode = "maximized" })) -- legacy arg 1 = maximized
hl.bind(mainMod .. " + C",            hl.dsp.exec_cmd(terminal .. " claude"))
hl.bind(mainMod .. " + A",            hl.dsp.exec_cmd("ablife --quick")) -- summon Hadrien compact quick-chat
hl.bind(mainMod .. " + M",            hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + SHIFT + M",    hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/restore-edp.sh"))

hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + W", hl.dsp.window.close())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + B", hl.dsp.layout("togglesplit"))

hl.bind(mainMod .. " + l",  hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + h",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + k",  hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J",  hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through workspaces (kept commented, as before)
-- hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
-- hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),       { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),       { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/brightness.sh up"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/brightness.sh down"), { locked = true, repeating = true })

hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- raybar's capture-first screenshooter (FIFO trigger: no click, overlays survive)
hl.bind("F12",   hl.dsp.exec_cmd("sh -c 'echo screenshot > $XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/rail.fifo'"))
hl.bind("Print", hl.dsp.exec_cmd("sh -c 'echo screenshot > $XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/rail.fifo'"))
hl.bind("F5",    hl.dsp.exec_cmd("grim - | wl-copy"))

----------------------------
-- WINDOWS & WORKSPACES ----
----------------------------
-- Examples (kept commented, as before)
-- hl.window_rule({ name = "suppress-maximize", match = { class = ".*" }, suppress_event = "maximize" })
-- hl.window_rule({ name = "fix-xwayland-drags", match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false }, no_focus = true })

--------------
---- PLUGINS ----
--------------
-- Plugin config values are registered at plugin load; example kept as before:
-- hl.load("virtual-desktops") -- or hyprpm; then hl.config({ ... plugin values ... })
