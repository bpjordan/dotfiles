local wezterm = require('wezterm')

local act = wezterm.action

wezterm.on(
  'update-status',
  function(window)
    window:set_left_status(wezterm.format {
      { Text = ' [' .. window:active_workspace() .. '] ' },
    })
  end
)

wezterm.on('update-right-status', function(window)
  local time = wezterm.strftime('%b %d %H:%M:%S')
  window:set_right_status(wezterm.format {
    { Text = time },
  })
end)

local function basename(path) return string.gsub(path, '(.*[/\\])(.*)[/\\]?$', '%2') end

wezterm.on('user-var-changed', function(window, pane, name, value)
  if name == 'SESSIONIZER_DIR' then
    if not value then
      wezterm.log_warn('Sessionizer called with no target directory')
      return
    end

    local basename = basename(value)

    if not basename then
      wezterm.log_error("Sessionizer couldn't get basename of dir `" .. value .. '`')
      return
    end

    wezterm.log_info('Sessionizer switching to `', basename, '`')

    window:perform_action(
      act.SwitchToWorkspace {
        name = basename,
        spawn = {
          cwd = value,
        },
      },
      pane
    )
  end
end)

return {
  window_background_opacity = 0.7,
  color_scheme = 'tokyonight_night',

  font = wezterm.font('Inconsolata Go Nerd Font', { weight = 'Medium' }),
  font_size = 20,
  warn_about_missing_glyphs = false,

  tab_bar_at_bottom = true,
  use_fancy_tab_bar = false,

  default_workspace = basename(wezterm.home_dir),

  window_padding = {
    top = 0,
    bottom = 0,
    left = 0,
    right = 0,
  },

  leader = { key = ' ', mods = 'CTRL', timeout_milliseconds = 5000 },

  keys = require('keymaps'),
}
