vim.keymap.set('n', '<C-s>', ':w<cr>', { silent = true })

vim.keymap.set("n", "<C-L>", "<C-W><C-L>", { noremap = true, silent = true });
vim.keymap.set("n", "<C-K>", "<C-W><C-K>", { noremap = true, silent = true });
vim.keymap.set("n", "<C-J>", "<C-W><C-J>", { noremap = true, silent = true });
vim.keymap.set("n", "<C-H>", "<C-W><C-H>", { noremap = true, silent = true });

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
