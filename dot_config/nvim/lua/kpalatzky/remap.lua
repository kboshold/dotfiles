
set_key("n", "<leader>pv", vim.cmd.Ex, "Open [p]arent [v]iew")

-- Diagnostic keymaps
set_key('n', '[d', vim.diagnostic.goto_prev, 'Go to previous [d]iagnostic message')
set_key('n', ']d', vim.diagnostic.goto_next, 'Go to next [d]iagnostic message')
set_key('n', '<leader>e', vim.diagnostic.open_float, 'Open floating diagnostic message')
set_key('n', '<leader>q', vim.diagnostic.setloclist, 'Open diagnostics list')
