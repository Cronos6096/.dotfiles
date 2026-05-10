-- Imports
require("env")
require("autostart")
require("keybinds")
require("looks")
require("monitors")

hl.config({
	-- Layouts
	scrolling = {
		fullscreen_on_one_column = true,
		focus_fit_method = 1,
		explicit_column_widths = "0.25, 0.5, 0.75, 1",
	},

	-- Misc
	misc = {
		force_default_wallpaper = 1,
		disable_hyprland_logo = true,
	},

	-- Input
	input = {
		kb_layout = "us,it",
		kb_options = "compose:ralt",
		follow_mouse = 1,
		sensitivity = 0,
		touchpad = {
			natural_scroll = false,
		},
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

-- Workspace assignments
for i = 1, 10 do
	hl.workspace_rule({ workspace = tostring(i), monitor = "eDP-1", persistent = true })
end
for i = 11, 20 do
	hl.workspace_rule({ workspace = tostring(i), monitor = "HDMI-A-1", persistent = true })
end

-- Window rules
hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

hl.window_rule({
	name = "float-qalculate",
	match = { class = "qalculate-gtk" },
	float = true,
})

hl.window_rule({
	name = "float-clipse",
	match = { class = "(clipse)" },
	float = true,
	stay_focused = true,
	size = { 622, 652 },
})

hl.window_rule({
	name = "float-dropterm",
	match = { class = "kitty-dropterm" },
	float = true,
	no_focus = true,
})

hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

-- Vicinae layer rules
hl.layer_rule({
	name = "vicinae-blur",
	match = { namespace = "vicinae" },
	blur = true,
	ignore_alpha = 0,
})

hl.layer_rule({
	name = "vicinae-no-animation",
	match = { namespace = "vicinae" },
	no_anim = true,
})
