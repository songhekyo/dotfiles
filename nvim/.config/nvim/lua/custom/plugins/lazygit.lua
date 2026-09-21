-- lazygit.nvim: open lazygit inside a floating Neovim terminal
-- https://github.com/kdheepak/lazygit.nvim
-- Requires the `lazygit` binary to be installed and on your PATH.

vim.pack.add { 'https://github.com/kdheepak/lazygit.nvim' }

vim.keymap.set('n', '<leader>lg', '<CMD>LazyGit<CR>', { desc = '[G]it: open lazy[g]it' })
