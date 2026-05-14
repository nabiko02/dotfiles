-- Above monitor
hl.monitor({ output = "DP-3",     mode = "1920x1080@60", position = "0x-1080", scale = 1 })
-- Meeting room monitors
hl.monitor({ output = "DVI-I-1",  mode = "1920x1080@60", position = "0x-1080", scale = 1 })
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60", position = "0x-1080", scale = 1 })
-- Primary
hl.monitor({ output = "eDP-1",    mode = "preferred",    position = "0x0",     scale = 1 })
-- Fallback for any unrecognized monitor
hl.monitor({ output = "",         mode = "preferred",    position = "auto",    scale = 1 })
-- Left
hl.monitor({ output = "desc:Fujitsu Siemens Computers GmbH P22W-5 ECO YE7G213311",           mode = "1920x1080@60", position = "-1920x0", scale = 1 })
-- Right (tv)
hl.monitor({ output = "desc:Philips Consumer Electronics Company Philips FTV 0x01010101",     mode = "1920x1080@60", position = "1920x0",  scale = 1 })
