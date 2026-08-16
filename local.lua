-- =============================================================================
-- Machine-specific Hyprland config (migrated 2026-08-16 from local.conf)
-- =============================================================================

-- GPU render order: chosen automatically at login by
-- ~/.config/hypr/scripts/start-hyprland-auto.sh (ly session "Hyprland (GPU auto)"):
-- dGPU-first when an external monitor is on a dGPU connector, iGPU-first otherwise.
-- Manual override: echo dgpu > ~/.config/hypr/gpu-order (or igpu); rm to go back to auto.
--
-- Do NOT add hl.env("AQ_DRM_DEVICES", ...) here: config env is applied at config
-- parse (pre-backend) and would override the wrapper's export, freezing the order.
--
-- AQ_NO_MODIFIERS=1 was tried for iGPU stutter, but it breaks the iGPU-to-NVIDIA
-- DMA-BUF blit needed for Reverse PRIME (external screens on dGPU connectors).
-- Symptom: "EGL (verifyDestinationDMABUF): FAIL, format is external-only" + black externals.

-- Monitor configuration is managed by raybar (~/oss/py-dbar) via hyprctl;
-- do not add static hl.monitor() lines here or they'll fight raybar's profile apply.

-- NVIDIA needs a CPU/dumb cursor buffer to use its hardware cursor plane.
-- Hyprland's auto mode disables hardware cursors whenever NVIDIA and multiple
-- DRM devices are present, even when both active outputs use the dGPU.
-- Force hardware cursors to avoid full 4K redraws for every pointer movement.
hl.config({
    cursor   = { no_hardware_cursors = 0, use_cpu_buffer = true },
    xwayland = { force_zero_scaling = true },
})

-- Toolkit scaling for GTK/Qt apps under XWayland
hl.env("GDK_SCALE", "1.25")
hl.env("QT_SCALE_FACTOR", "1.25")

-- Steam UI scaling
hl.env("STEAM_FORCE_DESKTOPUI_SCALING", "1.25")
