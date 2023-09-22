local api = require('nvim-tree.api')

local function keymap_open_nvim_tree()
  api.tree.find_file()
  api.tree.focus()
end

vim.keymap.set('n', '<leader>t', keymap_open_nvim_tree, { desc = 'Focus file [T]ree' })
