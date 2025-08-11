-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- the initial geometry for new windows:
config.initial_cols = 80
config.initial_rows = 24

-- font and color scheme.
config.font_size = 12
config.color_scheme = 'Bamboo Multiplex'

-- scroll setting
config.scrollback_lines = 1500
config.enable_scroll_bar = true

-- tab bar and title bar setting
	-- apperence and color
		config.window_frame = {
			-- The overall background color of the tab bar when
			-- the window is focused
			active_titlebar_bg = '#2C2C2C',

			-- The overall background color of the tab bar when
			-- the window is not focused
			inactive_titlebar_bg = '#333333',
		}
	-- to be done

	-- bahavior
	config.hide_tab_bar_if_only_one_tab = true
	enable_scroll_bar = true

-- window setting
config.window_background_opacity = 0.85
config.window_padding = { 
	left = 5,
	right = 10,
	top = 5,
	bottom = 3,
}

-- tabs and panes management with keys
	-- set leader key(or prefix key in Tmux)
	config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }

	-- key binding for panes
		config.keys = {
			-- split panes
			{
				key = '\\',
				mods = 'LEADER',
				action = wezterm.action.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
			},

			{
				key = '-',
				mods = 'LEADER',
				action = wezterm.action.SplitVertical({domain = "CurrentPaneDomain"}),
			},

			-- kill current panes
			{	key="x", mods="LEADER", action = wezterm.action{CloseCurrentPane={confirm=true}}},

			-- navigate between panes
			{ key = "h", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Left") },
			{ key = "j", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Down") },
			{ key = "k", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Up") },
			{ key = "l", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Right") },	
			
			-- resize the panes
			{ key = "H", mods = "LEADER|SHIFT", action = wezterm.action.AdjustPaneSize({ "Left", 5 }) },
			{ key = "J", mods = "LEADER|SHIFT", action = wezterm.action.AdjustPaneSize({ "Down", 5 }) },
			{ key = "K", mods = "LEADER|SHIFT", action = wezterm.action.AdjustPaneSize({ "Up", 5 }) },
			{ key = "L", mods = "LEADER|SHIFT", action = wezterm.action.AdjustPaneSize({ "Right", 5 }) },
			{ key = "z", mods = "LEADER", action = wezterm.action.TogglePaneZoomState },
			
			-- tabs control
			{ key = "c", mods = "LEADER", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
			{ key = "p", mods = "LEADER", action = wezterm.action.ActivateTabRelative(-1) },
			{ key = "n", mods = "LEADER", action = wezterm.action.ActivateTabRelative(1) },

			-- scroll tabs control
			{ key = 'PageUp', mods = 'SHIFT', action = wezterm.action.ScrollByPage(-0.3) },
		  { key = 'PageDown', mods = 'SHIFT', action = wezterm.action.ScrollByPage(0.3) },

			-- enter copymode
				-- some explanation about copy mode:
				-- when I want to config the keys for copy mode, 
				-- as I surf the origin keys, I found it better than tmux,
				-- so I just decided to use what is original.
				-- check out https://wezterm.org/copymode.html for details
			{ key = "C", mods = "CTRL|SHIFT", action = wezterm.action.ActivateCopyMode },
		}

			-- tabs create and jump with numbers
			for i=1,9 do
				table.insert(config.keys, {
					key=tostring(i),
					mods="LEADER",
					action=wezterm.action.ActivateTab(i-1),
				})
			end

-- Finally, return the configuration to wezterm:
return config
