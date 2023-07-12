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
