local modicator = require "modicator"

-- NOTE: Modicator requires line_numbers and cursorline to be enabled
modicator.setup {
    show_warnings = true,
    highlights = {
        defaults = {
            bold = true
        }
    }
}

local function set_mode_hls_from_lualine()
    vim.api.nvim_set_hl(
        0,
        "InsertMode",
        {
            fg = "#f8f8f8",
            bold = true
        }
    )
    local modes = {
        "Insert",
        "Visual",
        "Command",
        "Replace",
        "Select",
        "Terminal",
        "TerminalNormal"
    }

    for _, mode in pairs(modes) do
        local hl = vim.api.nvim_get_hl(0, {name = "St_" .. mode .. "Mode", link = false})
        vim.api.nvim_set_hl(
            0,
            mode .. "Mode",
            {
                fg = hl.bg,
                bold = true
            }
        )
    end
end

set_mode_hls_from_lualine()
