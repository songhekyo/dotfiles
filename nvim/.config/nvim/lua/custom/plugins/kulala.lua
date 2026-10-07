-- kulala.nvim: an HTTP/GraphQL/gRPC/Websocket client inside Neovim
-- (Jetbrains .http spec, with scripting support)
-- https://github.com/mistweaverco/kulala.nvim

vim.pack.add { 'https://github.com/mistweaverco/kulala.nvim' }

require('kulala').setup {
  -- Pull in the full <leader>R... keymap set below instead of wiring each
  -- command up by hand
  global_keymaps = true,
  global_keymaps_prefix = '<leader>R',
  ui = {
    display_mode = 'split',
    split_direction = 'right',
  },
}
