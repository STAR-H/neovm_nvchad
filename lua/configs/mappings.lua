-- Shorten function name
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }


-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Clear search hightlight
keymap("n", "<ESC>", ":nohl<CR>", opts)

-- Resize with arrows
keymap("n", "<up>",    "<Cmd>resize -5<CR>",          opts)
keymap("n", "<down>",  "<Cmd>resize +5<CR>",          opts)
keymap("n", "<left>",  "<Cmd>vertical resize -5<CR>", opts)
keymap("n", "<right>", "<Cmd>vertical resize +5<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", "<Cmd>bnext<CR>",     opts)
keymap("n", "<S-h>", "<Cmd>bprevious<CR>", opts)

-- Insert --
-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)

keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Use q to quit visual selection
keymap("v", "q", "<Esc>", opts)

-- Remap Q to q for macro recording
keymap("n", "q", "<NOP>", opts)
keymap("n", "Q", "q",     opts)

keymap("n", "dt", function() require("configs.utils").toggle_diagnostics() end,
  { silent = true, noremap = true, desc = "diagnostics toggle" })

keymap("n", "<leader>d", function() require("configs.utils").close_buffer() end,
  { silent = true, noremap = true, desc = "delete buffer" })

-- Exit in terminal mode
keymap("t", "jk", "<C-\\><C-n>", opts)
keymap("t", "kj", "<C-\\><C-n>", opts)

keymap("n", "<leader>th", function() require("nvchad.themes").open() end, { desc = "telescope nvchad themes" })

keymap("n", "<leader>ch", "<Cmd>NvCheatsheet<CR>", { desc = "toggle nvcheatsheet" })
