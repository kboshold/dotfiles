-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
    defaults = {
      mappings = {
        i = {
          ['<C-u>'] = false,
          ['<C-d>'] = false,
        },
      },
    },
  }
  
-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')


-- See `:help telescope.builtin`
set_key('n', '<leader>?', require('telescope.builtin').oldfiles, '[?] Find recently opened files')
set_key('n', '<leader><space>', require('telescope.builtin').buffers, '[ ] Find existing buffers')
set_key('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, '[/] Fuzzily search in current buffer')

set_key('n', '<leader>gf', require('telescope.builtin').git_files, 'Search [G]it [F]iles')
set_key('n', '<leader>sf', require('telescope.builtin').find_files, '[S]earch [F]iles')
set_key('n', '<leader>sh', require('telescope.builtin').help_tags, '[S]earch [H]elp')
set_key('n', '<leader>sw', require('telescope.builtin').grep_string, '[S]earch current [W]ord')
set_key('n', '<leader>sg', require('telescope.builtin').live_grep, '[S]earch by [G]rep')
set_key('n', '<leader>sd', require('telescope.builtin').diagnostics, '[S]earch [D]iagnostics')

set_key('n', '<leader>ps', function()
	require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") })
end, 'Telescope [S]earch')