-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Disable tabs since we are using zellij
config.enable_tab_bar = false
config.use_fancy_tab_bar = false

-- Disable scrollback since we are using zellij
config.scrollback_lines = 0

-- Use Ubuntu 22.04 WSL by default
-- config.default_prog = { 'ubuntu2204.exe' }

-- JetBrainsMono is the best font ever created and it is shipped with wezterm
config.font = wezterm.font('JetBrains Mono')
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

-- Just use a static title
require'wezterm'.on('format-window-title', function ()
	return 'Wezterm'
end)

-- and finally, return the configuration to wezterm
return config