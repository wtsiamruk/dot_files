-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 210
config.initial_rows = 65
config.max_fps = 120

-- or, changing the font size and color scheme.
config.font_size = 14
config.font = wezterm.font('JetBrains Mono')
config.color_scheme = 'Catppuccin Latte (Gogh)'
-- Finally, return the configuration to wezterm:
return config
