-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Load functions
require('kpalatzky.functions')

-- Load package manager
require('kpalatzky.lazy')

-- Load plugins
require('kpalatzky.plugins')

-- Set keybindings
require('kpalatzky.remap')

-- Set options
require('kpalatzky.set')
