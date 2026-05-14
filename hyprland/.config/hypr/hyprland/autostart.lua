local cfg = require("hyprland.config")

local startup_apps = {
    "waybar",
    "nm-applet --indicator",
    "hypridle",
    "hyprctl setcursor BreezeX-Light 36",
    "discord",
    "zen-browser",
    "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1",
    "vicinae server",
    "python " .. cfg.home .. "/.local/bin/razer_keyboard.py",
    "hyprpaper",
    cfg.home .. "/.config/hypr/change_wallpapers.sh",
    "/opt/teams-for-linux/teams-for-linux",
}

hl.on("hyprland.start", function()
    for _, app in ipairs(startup_apps) do
        hl.exec_cmd(app)
    end
end)
