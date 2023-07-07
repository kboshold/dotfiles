set_key = function(mode, keys, func, desc, opts, context)
    if not opts then
        opts = {}
    end
    opts.desc = desc
    vim.keymap.set(mode, keys, func, opts)
end