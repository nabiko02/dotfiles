local cfg      = require("hyprland.config")
local terminal = cfg.terminal
local menu     = cfg.menu
local mainMod  = cfg.mainMod
local win      = cfg.win
local home     = cfg.home

-- Core
hl.bind(mainMod .. " + RETURN",    hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd('zenity --question --text="Are you sure you want to quit Hyprland?" && hyprctl dispatch exit'))
hl.bind(win .. " + SPACE",         hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + C",         hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P",         hl.dsp.window.pseudo())
hl.bind(mainMod .. " + E",         hl.dsp.layout("togglesplit"))

-- Move focus — hjkl
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Move focus — arrow keys
hl.bind(mainMod .. " + LEFT",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + RIGHT", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + UP",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + DOWN",  hl.dsp.focus({ direction = "down" }))

-- Move window — hjkl
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.group.move_window({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.group.move_window({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.group.move_window({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.group.move_window({ direction = "down" }))

-- Move window — arrow keys
hl.bind(mainMod .. " + SHIFT + LEFT",  hl.dsp.group.move_window({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + RIGHT", hl.dsp.group.move_window({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + UP",    hl.dsp.group.move_window({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + DOWN",  hl.dsp.group.move_window({ direction = "down" }))

-- Switch workspaces — FR keyboard layout (code:10=&, code:11=é, ..., code:19=à)
for i = 1, 10 do
    hl.bind(mainMod .. " + code:" .. (9 + i),         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + code:" .. (9 + i), hl.dsp.window.move({ workspace = i }))
end

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through workspaces with mouse wheel
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(win .. " + mouse:272",     hl.dsp.window.drag(),   { mouse = true })
hl.bind(win .. " + mouse:273",     hl.dsp.window.resize(), { mouse = true })

-- Volume and brightness
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+"),   { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"),   { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),  { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),{ locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl s 10%+"),                        { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"),                        { locked = true, repeating = true })

-- Playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),        { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),    { locked = true })

-- Extra keyboard media keys
hl.bind("XF86Tools",   hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
hl.bind("XF86Launch5", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86Launch6", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86Launch7", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+"))
hl.bind("XF86Launch8", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"))

-- Screenshot
hl.bind("Print",               hl.dsp.exec_cmd(home .. "/.local/bin/screenshot"))
hl.bind("SHIFT + Print",       hl.dsp.exec_cmd(home .. "/.local/bin/screenshot window"))
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd(home .. "/.local/bin/screenshot output"))

-- Lock screen
hl.bind(win .. " + L", hl.dsp.exec_cmd("loginctl lock-session"))

-- Fullscreen
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())

-- Group / tab view
hl.bind(mainMod .. " + Z",                    hl.dsp.group.toggle())
hl.bind("CTRL + " .. mainMod .. " + H",       hl.dsp.group.prev())
hl.bind("CTRL + " .. mainMod .. " + L",       hl.dsp.group.next())

-- Submap: obs (move/resize windows for OBS scene setup)
hl.bind(mainMod .. " + O", hl.dsp.submap("obs"))
hl.define_submap("obs", function()
    hl.bind(win .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
    hl.bind(win .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
    hl.bind("ESCAPE",              hl.dsp.submap("reset"))
end)
