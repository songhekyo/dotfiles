-- Neorg: organized notes and tasks in the .norg format
-- https://github.com/nvim-neorg/neorg
--
-- Neorg v9 declares its dependencies as luarocks, but this config uses `vim.pack`
-- (no luarocks), so every dependency is installed as a git plugin pinned to the
-- version listed in neorg's rockspec (neorg-scm-1.rockspec).

-- norg_meta is not in nvim-treesitter's parser list, so register it as a custom parser.
-- See "Adding custom languages" in the nvim-treesitter README.
-- Assigned right away because the `parsers` module is already loaded (see the treesitter section
-- of init.lua), and again on `User TSUpdate` so it survives `:TSUpdate` reloading the parser list.
local function register_norg_meta_parser()
  require('nvim-treesitter.parsers').norg_meta = {
    install_info = {
      url = 'https://github.com/nvim-neorg/tree-sitter-norg-meta',
      revision = '6f0510cc516a3af3396a682fbd6655486c2c9d2d', -- v0.1.0
      queries = 'queries',
    },
  }
end

register_norg_meta_parser()
vim.api.nvim_create_autocmd('User', { pattern = 'TSUpdate', callback = register_norg_meta_parser })
require('nvim-treesitter').install { 'norg_meta' }

-- The norg parser has a C++ external scanner (src/scanner.cc). `tree-sitter build` (which nvim-treesitter
-- uses) fails to link it with tree-sitter CLI 0.26.9, so norg cannot be a nvim-treesitter custom parser.
-- Instead, install the repo with `vim.pack` and compile it with g++ into the same parser directory
-- nvim-treesitter uses. This mirrors the build hooks in init.lua (see `:help vim.pack-events`).
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.spec.name ~= 'tree-sitter-norg' then return end
    if ev.data.kind ~= 'install' and ev.data.kind ~= 'update' then return end

    local src = vim.fs.joinpath(ev.data.path, 'src')
    local parser_dir = vim.fs.joinpath(vim.fn.stdpath 'data', 'site', 'parser')
    vim.fn.mkdir(parser_dir, 'p')

    local result = vim
      .system({
        'g++',
        '-shared',
        '-fPIC',
        '-O2',
        '-I',
        src,
        '-x',
        'c',
        vim.fs.joinpath(src, 'parser.c'),
        '-x',
        'c++',
        vim.fs.joinpath(src, 'scanner.cc'),
        '-o',
        vim.fs.joinpath(parser_dir, 'norg.so'),
      })
      :wait()
    if result.code ~= 0 then vim.notify(('Build failed for tree-sitter-norg:\n%s'):format(result.stderr or ''), vim.log.levels.ERROR) end
  end,
})

vim.pack.add {
  -- plenary.nvim is already installed as a telescope dependency
  { src = 'https://github.com/nvim-neotest/nvim-nio', version = vim.version.range '1.*' },
  { src = 'https://github.com/nvim-neorg/lua-utils.nvim', version = 'v1.0.2' },
  { src = 'https://github.com/MunifTanjim/nui.nvim', version = '0.3.0' },
  { src = 'https://github.com/pysan3/pathlib.nvim', version = vim.version.range '2.2.*' },
  { src = 'https://github.com/nvim-neorg/tree-sitter-norg', version = 'v0.2.4' },
  { src = 'https://github.com/nvim-neorg/neorg', version = vim.version.range '9.*' },
}

-- Notes live in one global workspace so they are reachable from any project.
-- Keep this OUTSIDE the dotfiles repo: it holds personal content, not config.
local notes_dir = vim.fn.expand '~/notes'

require('neorg').setup {
  load = {
    ['core.defaults'] = {},
    ['core.concealer'] = {},
    ['core.dirman'] = {
      config = {
        workspaces = { notes = notes_dir },
        default_workspace = 'notes',
      },
    },
  },
}

-- core.concealer needs conceallevel to be set in norg buffers
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'norg',
  callback = function() vim.opt_local.conceallevel = 2 end,
})

-- Not <leader>nn: it clashes with neorg's buffer-local <localleader>nn (localleader is also <space>).
-- Not <leader>sn: kickstart already uses it for "Search Neovim files".
vim.keymap.set('n', '<leader>on', '<cmd>Neorg workspace notes<CR>', { desc = '[O]pen [N]otes (Neorg)' })
vim.keymap.set(
  'n',
  '<leader>of',
  function() require('telescope.builtin').find_files { cwd = notes_dir, prompt_title = 'Find Notes' } end,
  { desc = '[O]pen notes: [F]ind file' }
)
vim.keymap.set(
  'n',
  '<leader>og',
  function() require('telescope.builtin').live_grep { cwd = notes_dir, prompt_title = 'Grep Notes' } end,
  { desc = '[O]pen notes: [G]rep' }
)
