hl.env("XCURSOR_SIZE",  "36")
hl.env("XCURSOR_THEME", "BreezeX-Light")
hl.env("HYPRCURSOR_SIZE", "36")

-- Wayland native rendering
hl.env("MOZ_ENABLE_WAYLAND",              "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT",    "auto")
hl.env("QT_QPA_PLATFORM",                 "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
