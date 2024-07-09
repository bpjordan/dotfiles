local wezterm = require('wezterm')
local act = wezterm.action

local keys = {
  {
    key = '\\',
    mods = 'LEADER',
    action = act.SplitPane {
      direction = 'Right',
    },
  },
  {
    key = '-',
    mods = 'LEADER',
    action = act.SplitPane {
      direction = 'Down',
    },
  },

  {
    key = 't',
    mods = 'LEADER',
    action = act.SpawnTab('CurrentPaneDomain'),
  },

  {
    key = 'T',
    mods = 'LEADER | SHIFT',
    action = wezterm.action_callback(function(_, pane) pane:move_to_new_tab():activate() end),
  },

  {
    key = 'x',
    mods = 'LEADER',
    action = act.CloseCurrentPane { confirm = true }
  },

  {
    key = 'r',
    mods = 'LEADER',
    action = act.PromptInputLine {
      description = 'Rename tab',
      action = wezterm.action_callback(function(window, _, line)
        if line then window:active_tab():set_title(line) end
      end),
    },
  },

  {
    key = '=',
    mods = 'ALT',
    action = act.IncreaseFontSize,
  },

  {
    key = '-',
    mods = 'ALT',
    action = act.DecreaseFontSize,
  },

  {
    key = 'h',
    mods = 'ALT',
    action = act.ActivatePaneDirection('Left'),
  },
  {
    key = 'j',
    mods = 'ALT',
    action = act.ActivatePaneDirection('Down'),
  },
  {
    key = 'k',
    mods = 'ALT',
    action = act.ActivatePaneDirection('Up'),
  },
  {
    key = 'l',
    mods = 'ALT',
    action = act.ActivatePaneDirection('Right'),
  },

  -- Pane resizing
  {
    key = 'h',
    mods = 'ALT|SHIFT',
    action = act.AdjustPaneSize { 'Left', 5 },
  },
  {
    key = 'j',
    mods = 'ALT|SHIFT',
    action = act.AdjustPaneSize { 'Down', 5 },
  },
  {
    key = 'k',
    mods = 'ALT|SHIFT',
    action = act.AdjustPaneSize { 'Up', 5 },
  },
  {
    key = 'l',
    mods = 'ALT|SHIFT',
    action = act.AdjustPaneSize { 'Right', 5 },
  },

  {
    key = 's',
    mods = 'LEADER',
    action = act.SpawnCommandInNewTab {
      args = { wezterm.home_dir .. '/.dotfiles/scripts/wezterm-sessionizer' },
    },
  },

  {
    key = 'f',
    mods = 'LEADER',
    action = act.SpawnCommandInNewTab {
      args = { 'ranger' },
    },
  },

  {
    key = 'L',
    mods = 'LEADER',
    action = wezterm.action.ShowDebugOverlay,
  },

  {
    key = 'L',
    mods = 'LEADER|CTRL',
    action = wezterm.action.ReloadConfiguration,
  },
  {
    key = 'w',
    mods = 'LEADER',
    action = act.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES|DOMAINS' },
  },
  {
    key = 'l',
    mods = 'LEADER',
    action = act.ShowLauncherArgs { flags = 'FUZZY|COMMANDS' },
  },
  {
    key = 'w',
    mods = 'SUPER',
    action = act.DisableDefaultAssignment
  }
}

for i = 1, 8 do
  table.insert(keys, {
    key = tostring(i),
    mods = 'LEADER',
    action = act.ActivateTab(i - 1),
  })
end

return keys
