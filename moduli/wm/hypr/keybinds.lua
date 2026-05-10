local terminal = "kitty"
local fileManager = "dolphin"
local menu = "vicinae toggle"
local mainMod = "SUPER"

-- Switch workspace
for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + " .. key, function()
		local mon = hl.get_active_monitor()
		local ws = i
		if mon and mon.name == "HDMI-A-1" then
			ws = i + 10
		end
		hl.dispatch(hl.dsp.focus({ workspace = ws }))
	end)
	hl.bind(mainMod .. " + SHIFT + " .. key, function()
		local mon = hl.get_active_monitor()
		local ws = i
		if mon and mon.name == "HDMI-A-1" then
			ws = i + 10
		end
		hl.dispatch(hl.dsp.window.move({ workspace = ws }))
	end)
end

hl.bind(mainMod .. "+" .. "B", hl.dsp.exec_cmd("zen-beta"))
hl.bind(mainMod .. "+" .. "E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. "+" .. "M", hl.dsp.exec_cmd("noctalia-shell ipc call sessionMenu toggle"))
hl.bind(mainMod .. "+" .. "P", hl.dsp.exec_cmd("prismlauncher"))
hl.bind(mainMod .. "+" .. "Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. "+" .. "R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. "+" .. "SHIFT + D", hl.dsp.exec_cmd("vesktop"))
hl.bind(mainMod .. "+" .. "SHIFT + S", hl.dsp.exec_cmd("steam"))
hl.bind(mainMod .. "+" .. "T", hl.dsp.exec_cmd("noctalia-shell ipc call bar toggle"))
hl.bind(mainMod .. "+" .. "V", hl.dsp.exec_cmd(terminal .. [[ -e "clipse"]]))
hl.bind(mainMod .. "+" .. "SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))

-- Scratchpad
hl.bind(mainMod .. "+" .. "W", hl.dsp.exec_cmd("pypr toggle term"))

-- Media keys
hl.bind("XF86Calculator", hl.dsp.exec_cmd("qalculate-gtk"))
hl.bind("XF86Launch2", hl.dsp.exec_cmd(terminal .. [[ -e "btop"]]))
hl.bind(mainMod .. "+" .. "Escape", hl.dsp.exec_cmd(terminal .. [[ -e "btop"]]))

-- Window management
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. "+ SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. "+ SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. "+ SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. "+ SHIFT + J", hl.dsp.window.move({ direction = "down" }))

hl.bind(mainMod .. "+ CTRL + L", hl.dsp.exec_cmd("hyprctl dispatch resizeactive 50 0"))
hl.bind(mainMod .. "+ CTRL + H", hl.dsp.exec_cmd("hyprctl dispatch resizeactive -50 0"))
hl.bind(mainMod .. "+ CTRL + K", hl.dsp.exec_cmd("hyprctl dispatch resizeactive 0 -50"))
hl.bind(mainMod .. "+ CTRL + J", hl.dsp.exec_cmd("hyprctl dispatch resizeactive 0 50"))

hl.bind(mainMod .. "+ F", hl.dsp.window.fullscreen({ "fullscreen" }))
hl.bind(mainMod .. "+ SHIFT + F", hl.dsp.window.fullscreen({ "maximised" }))

hl.bind(mainMod .. "+" .. "C", hl.dsp.window.center())
hl.bind(mainMod .. "+" .. "Z", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. "+" .. "Y", hl.dsp.window.kill())

-- Scrolling layout
hl.bind(mainMod .. "+" .. "X", function()
	local current = hl.get_config("general.layout")
	local next_layout = (current == "dwindle") and "scrolling" or "dwindle"
	hl.config({ general = { layout = next_layout } })
end)
hl.bind(mainMod .. "+" .. "period", hl.dsp.layout("consume_or_expel next"))
hl.bind(mainMod .. "+" .. "comma", hl.dsp.layout("consume_or_expel prev"))
hl.bind(mainMod .. "+" .. "C", hl.dsp.layout("colresize +conf"))

-- Cycle windows
hl.bind("SUPER + Tab", function()
	hl.dispatch(hl.dsp.window.cycle_next())
	hl.dispatch(hl.dsp.exec_cmd("hyprctl dispatch bringactivetotop"))
end)

-- Screenshots
hl.bind(mainMod .. "+ CTRL + S", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind(mainMod .. "+ ALT + S", hl.dsp.exec_cmd("hyprshot -m output"))
hl.bind(mainMod .. "+ CTRL + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region"))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "m-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Function keys
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })
