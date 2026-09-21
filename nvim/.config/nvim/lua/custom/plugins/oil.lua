-- oil.nvim: edit your filesystem like a normal Neovim buffer
-- https://github.com/stevearc/oil.nvim

-- Disabling netrw is recommended by oil.nvim, and must happen before it loads.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.pack.add { 'https://github.com/stevearc/oil.nvim' }

require('oil').setup {
  default_file_explorer = true,
  view_options = {
    show_hidden = true,
  },
}

vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
