-- Default workspace per monitor
hl.workspace_rule({ workspace = "1", monitor = "eDP-1", default = true })
hl.workspace_rule({ workspace = "2", monitor = "DP-2",  default = true })
hl.workspace_rule({ workspace = "3", monitor = "DP-1",  default = true })

-- Ignore maximize requests from apps
hl.window_rule({
    name          = "suppress-maximize-events",
    match         = { class = ".*" },
    suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

-- Float by default for specific applications
hl.window_rule({ match = { class = "^(.*dialog.*)$" },                                  float = true })
hl.window_rule({ match = { class = "org.gnome.Calculator", title = "Calculator" },       float = true, center = true })
hl.window_rule({ match = { class = "nm-connection-editor" },                             float = true })
hl.window_rule({ match = { class = "lxappearance" },                                     float = true })
hl.window_rule({ match = { class = "org.pulseaudio.pavucontrol" },                       float = true, size = "1600 500", center = true })
hl.window_rule({ match = { class = "com.gabm.satty" },                                   float = true, center = true })

-- Inhibit idle for Teams on workspace 4
hl.window_rule({ match = { class = "teams-for-linux", workspace = "4" }, idle_inhibit = "always" })

-- Send apps to specific workspaces
hl.window_rule({ match = { class = "Brave-browser" }, workspace = "2" })
hl.window_rule({ match = { class = "zen" },           workspace = "2" })
hl.window_rule({ match = { class = "Google-chrome" }, workspace = "2" })
hl.window_rule({ match = { class = "discord*" },      workspace = "3" })
hl.window_rule({ match = { class = "Bitwarden" },     workspace = "4" })

-- IntelliJ (native Wayland 2026.1+)
hl.window_rule({ match = { class = "^jetbrains-(?!toolbox)", float = true }, no_initial_focus = true })

-- Float popups and dialogs by title
hl.window_rule({ match = { title = "^(.*popup.*|.*dialog.*|find.*|search.*)$" }, float = true, center = true })
