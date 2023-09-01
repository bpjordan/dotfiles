
local wezterm = require 'wezterm'

local act = wezterm.action

wezterm.on('update-status', function(window)
    window:set_left_status(wezterm.format {
        { Text = ' [' .. window:active_workspace() .. '] ' },
    })
end)

wezterm.on('update-right-status', function(window)
    local time = wezterm.strftime '%b %d %H:%M:%S'
    window:set_right_status(wezterm.format {
        { Text = time }
    })
end)

local function basename(path)
    return string.gsub(path, '(.*[/\\])(.*)[/\\]?$', '%2')
end

wezterm.on('user-var-changed', function(window, pane, name, value)
    if name == 'SESSIONIZER_DIR' then

        if not value then
            wezterm.log_warn("Sessionizer called with no target directory")
            return
        end

        local basename = basename(value)

        if not basename then
            wezterm.log_error("Sessionizer couldn't get basename of dir `"..value.."`")
            return
        end

        wezterm.log_info("Sessionizer switching to `", basename, "`")

        window:perform_action(
            act.SwitchToWorkspace {
                name = basename,
                spawn = {
                    cwd = value
                }
            },
            pane
        )
    end
end)

local keys = {
    {
        key = '\\',
        mods = 'LEADER',
        action = act.SplitPane{
            direction = 'Right',
        }
    },
    {
        key = '-',
        mods = 'LEADER',
        action = act.SplitPane{
            direction = 'Down',
        }
    },
    {
        key = 'h',
        mods = 'ALT',
        action = act.ActivatePaneDirection 'Left',
    },
    {
        key = 'j',
        mods = 'ALT',
        action = act.ActivatePaneDirection 'Up',
    },
    {
        key = 'k',
        mods = 'ALT',
        action = act.ActivatePaneDirection 'Down',
    },
    {
        key = 'l',
        mods = 'ALT',
        action = act.ActivatePaneDirection 'Right',
    },

    -- Pane resizing binds
    {
        key = 'h',
        mods = 'ALT|SHIFT',
        action = act.AdjustPaneSize {'Left', 5},
    },
    {
        key = 'j',
        mods = 'ALT|SHIFT',
        action = act.AdjustPaneSize {'Down', 5},
    },
    {
        key = 'k',
        mods = 'ALT|SHIFT',
        action = act.AdjustPaneSize {'Up', 5},
    },
    {
        key = 'l',
        mods = 'ALT|SHIFT',
        action = act.AdjustPaneSize {'Right', 5},
    },

    {
        key = 's',
        mods = 'LEADER',
        action = act.SpawnCommandInNewTab {
            args = {wezterm.home_dir .. '/.dotfiles/scripts/wezterm-sessionizer'}
        }
    },

    {
        key = 'L',
        mods = 'LEADER',
        action = wezterm.action.ShowDebugOverlay
    },
    {
        key = 'w',
        mods = 'LEADER',
        action = act.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES|DOMAINS' }
    },
    {
        key = 'l',
        mods = 'LEADER',
        action = act.ShowLauncherArgs { flags = 'FUZZY|COMMANDS' }
    }
}

for i = 1, 8 do
    table.insert(keys, {
        key = tostring(i),
        mods = 'LEADER',
        action = act.ActivateTab(i - 1)
    })
end

return {
    window_background_opacity = 0.7,
    color_scheme = 'tokyonight_night',

    font = wezterm.font('Inconsolata Go Nerd Font', {weight = 'Medium'}),
    font_size = 20,
    warn_about_missing_glyphs = false,

    tab_bar_at_bottom = true,
    use_fancy_tab_bar = false,
    -- config.hide_tab_bar_if_only_one_tab = true

    default_workspace = basename(wezterm.home_dir),

    window_padding = {
        top = 0,
        bottom = 0,
        left = 0,
        right = 0,
    },

    leader = {key = ' ', mods = 'CTRL', timeout_milliseconds = 1000},

    keys = keys,
}
