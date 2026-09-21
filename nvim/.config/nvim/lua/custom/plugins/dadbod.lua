-- vim-dadbod / vim-dadbod-ui: a SQL database client inside Neovim
-- https://github.com/tpope/vim-dadbod
-- https://github.com/kristijanhusak/vim-dadbod-ui
-- https://github.com/kristijanhusak/vim-dadbod-completion (blink.cmp source config lives in init.lua)

vim.pack.add {
  'https://github.com/tpope/vim-dadbod',
  'https://github.com/kristijanhusak/vim-dadbod-ui',
  'https://github.com/kristijanhusak/vim-dadbod-completion',
}

-- Disable Vim's built-in SQL omni-completion so it doesn't fight with blink.cmp
vim.g.omni_sql_default_compl_type = 'syntax'
vim.g.loaded_sql_completion = true

vim.g.db_ui_save_location = vim.fn.stdpath 'data' .. '/dadbod_ui'
vim.g.db_ui_use_nerd_fonts = true
vim.g.db_ui_execute_on_save = false

vim.keymap.set('n', '<leader>D', '<cmd>DBUIToggle<CR>', { desc = 'Toggle [D]atabase UI' })
