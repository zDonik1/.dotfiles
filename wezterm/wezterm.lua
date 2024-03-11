local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()
local catppuccin = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]

-- plugins
local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")

wezterm.on("update-status", function(window, _)
	local status_generator = require("wez-status-generator.plugin")

	local left_status = status_generator.generate_left_status({
		sections = {
			{
				components = {
					function()
						return window:mux_window():get_workspace():gsub("(.*[/\\])(.*)", "%2")
					end,
				},
				foreground = catppuccin.background,
				background = catppuccin.ansi[5],
			},
			{
				components = {
					function()
						local active_tab_index
						for _, item in ipairs(window:mux_window():tabs_with_info()) do
							if item.is_active then
								active_tab_index = item.index
								break
							end
						end
						return "tab " .. active_tab_index + 1 .. ":" .. #window:mux_window():tabs()
					end,
				},
				foreground = catppuccin.ansi[5],
				background = "#313244",
			},
		},
		separator = status_generator.separators.ARROW,
		hide_empty_sections = true,
	})

	local right_status = status_generator.generate_right_status({
		sections = {
			{
				components = {
					function()
						return wezterm.strftime("%H:%M:%S")
					end,
				},
				foreground = catppuccin.ansi[5],
				background = "#313244",
			},
			{
				components = {
					function()
						return wezterm.strftime("%d-%b-%y")
					end,
				},
				foreground = catppuccin.background,
				background = catppuccin.ansi[5],
			},
		},
		separator = status_generator.separators.ARROW,
		hide_empty_sections = true,
	})

	window:set_left_status(left_status)
	window:set_right_status(right_status)
end)

local function tab_title(tab_info)
	local title = tab_info.tab_title
	if title and #title > 0 then
		return title
	end
	return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab)
	if not tab.is_active then
		return ""
	end
	return {
		{ Background = { Color = catppuccin.tab_bar.background } },
		{ Foreground = { Color = catppuccin.ansi[3] } },
		{ Text = " " .. tab_title(tab) .. " " },
	}
end)

-- my config
config.color_scheme = "Catppuccin Mocha"
config.colors = {
	tab_bar = {
		new_tab = {
			bg_color = catppuccin.tab_bar.background,
			fg_color = catppuccin.tab_bar.background,
		},
	},
}

config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Medium" })
config.font_size = 11

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.tab_max_width = 40
config.window_background_opacity = 0.9
config.window_decorations = "RESIZE"
config.window_close_confirmation = "NeverPrompt"
config.win32_system_backdrop = "Acrylic"
config.window_padding = { bottom = "0cell" }
config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.8,
}

config.default_prog = { "nu", "-l" }
config.set_environment_variables = {
	XDG_CONFIG_HOME = wezterm.home_dir .. "/.config",
	XDG_DATA_HOME = wezterm.home_dir .. "/.local/share",
	WEZTERM_LOG = "debug",
}

config.keys = {
	{ key = "O", mods = "SHIFT|CTRL", action = act.ShowLauncher },
	{ key = "PageUp", mods = "CTRL", action = act.ScrollByPage(-0.5) },
	{ key = "PageUp", mods = "SHIFT", action = act.ActivateTabRelative(-1) },
	{ key = "PageDown", mods = "CTRL", action = act.ScrollByPage(0.5) },
	{ key = "PageDown", mods = "SHIFT", action = act.ActivateTabRelative(1) },
	{ key = "1", mods = "CTRL", action = act.ActivateTab(0) },
	{ key = "2", mods = "CTRL", action = act.ActivateTab(1) },
	{ key = "3", mods = "CTRL", action = act.ActivateTab(2) },
	{ key = "4", mods = "CTRL", action = act.ActivateTab(3) },
	{ key = "5", mods = "CTRL", action = act.ActivateTab(4) },
	{ key = "6", mods = "CTRL", action = act.ActivateTab(5) },
	{ key = "7", mods = "CTRL", action = act.ActivateTab(6) },
	{ key = "8", mods = "CTRL", action = act.ActivateTab(7) },
	{ key = "9", mods = "CTRL", action = act.ActivateTab(-1) },

	{ key = "U", mods = "CTRL|SHIFT", action = wezterm.action_callback(wezterm.plugin.update_all) },
	{ key = "s", mods = "ALT", action = workspace_switcher.switch_workspace() },
}

local copy_mode = nil
if wezterm.gui then
	copy_mode = wezterm.gui.default_key_tables().copy_mode
	table.insert(copy_mode, { key = "w", mods = "CTRL", action = act.CopyMode({ MoveByPage = -0.5 }) })
end
config.key_tables = {
	copy_mode = copy_mode,
}

return config
