vim.wo.signcolumn = "yes"

vim.opt.number = true
vim.opt.relativenumber = true

vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.termguicolors = true

vim.o.expandtab = true
-- number of spaces used for each indentation level
vim.o.shiftwidth = 2
-- number of spaces to be inserted when the 'Tab' key is pressed
vim.o.softtabstop = 2
-- number of spaces a tab character appears as
vim.o.tabstop = 2

vim.o.cmdheight = 0

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
