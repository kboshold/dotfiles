-- Pull in the wezterm API
local wezterm = require 'wezterm'
local mux = wezterm.mux

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.font = wezterm.font 'JetBrainsMono NL NFM'
config.enable_tab_bar = false

wezterm.on("gui-startup", function()
  local _tab, _pane, window = mux.spawn_window{}
  window:gui_window():maximize()
end)

-- and finally, return the configuration to wezterm
return config
