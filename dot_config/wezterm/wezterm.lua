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

-- Catppuccin Mocha
config.color_scheme = 'Catppuccin Mocha'	

-- JetBrainsMono is the best font ever created and it is shipped with wezterm
config.font = wezterm.font_with_fallback {
	'JetBrainsMono Nerd Font', -- try to use installed fonts over builtin to use the latest font
	'Jetbrains Mono'
}
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

config.window_padding = {
	left = 2,
	right = 2,
	top = 0,
	bottom = 0,
  }

-- Just use a static title
require'wezterm'.on('format-window-title', function ()
	return 'Wezterm'
end)

-- and finally, return the configuration to wezterm
return config
