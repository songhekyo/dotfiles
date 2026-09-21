-- toggleterm.nvim: a persistent, toggleable floating/split terminal
-- https://github.com/akinsho/toggleterm.nvim

vim.pack.add { 'https://github.com/akinsho/toggleterm.nvim' }

require('toggleterm').setup {
  open_mapping = [[<c-\>]],
}

vim.keymap.set('n', '<leader>tt', '<CMD>ToggleTerm<CR>', { desc = '[T]oggle [T]erminal' })
