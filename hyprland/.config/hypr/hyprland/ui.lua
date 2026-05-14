hl.config({
    general = {
        gaps_in     = 0,
        gaps_out    = 0,
        border_size = 1,
        col = {
            active_border   = "rgb(f1c41e)",
            inactive_border = "rgba(595959aa)",
        },
        resize_on_border = true,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        blur = {
            enabled = false,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    group = {
        col = {
            border_active   = 0xff4c7899,
            border_inactive = 0xff333333,
        },
        groupbar = {
            col = {
                active   = 0xff285577,
                inactive = 0xff222222,
            },
            text_color = 0xffffffff,
            font_size  = 16,
        },
    },
})

hl.animation({ leaf = "global", enabled = true, speed = 1, bezier = "default" })
