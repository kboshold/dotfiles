local modicator = require "modicator"

-- NOTE: Modicator requires line_numbers and cursorline to be enabled
modicator.setup {
    show_warnings = true,
    highlights = {
        defaults = {
            bold = true
        },
        modes = {
            ["n"] = {
                foreground = "#f8f8f8"
            },
            ["i"] = {
                foreground = "#d75faf"
            },
            ["v"] = {
                foreground = "#5fd7d7"
            },
            ["V"] = {
                foreground = "#5fd7d7"
            },
            ["�"] = {
                -- This symbol is the ^V character
                foreground = "#5fd7d7"
            },
            ["s"] = {
                foreground = "#d75faf"
            },
            ["S"] = {
                foreground = "#d75faf"
            },
            ["R"] = {
                foreground = "#ffaf00"
            },
            ["c"] = {
                foreground = "#c197fd"
            }
        }
    }
}
