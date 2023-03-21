
local function keymap_open_nvim_tree()
  require('nvim-tree.api').tree.toggle({
    find_file = true
  })
end

vim.keymap.set('n', 't', keymap_open_nvim_tree, { desc = "Toggle file [T]ree" })

local function startup_open_nvim_tree(data)

  local api = require('nvim-tree.api')

  local isDirectory = vim.fn.isdirectory(data.file) == 1
  local isFile = vim.fn.filereadable(data.file) == 1
  local isEmptyBuf = data.file == "" and vim.bo[data.buf].buftype == ''

  -- For a directory, focus that directory and open the tree to it
  if isDirectory then

    vim.cmd.cd(data.file)

    api.tree.open({
      path = nil,
      current_window = true,
    })
    api.tree.expand_all()

  -- For a file, only open the tree if the screen is big enough
  elseif isFile and vim.api.nvim_win_get_width(0) > 90 then
    api.tree.toggle({
      focus = false,
    })

  -- For an empty buf (i.e., opening with just `nvim`)
  elseif isEmptyBuf then
    api.tree.open({
      path = nil,
      current_window = true,
    })
    api.tree.expand_all()

  end

end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = startup_open_nvim_tree })

