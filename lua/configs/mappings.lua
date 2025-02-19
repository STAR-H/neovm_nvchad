-- Shorten function name
local keymap = vim.keymap.set
-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true, desc = "NavigateWindow Left" })
keymap("n", "<C-j>", "<C-w>j", { noremap = true, silent = true, desc = "NavigateWindow Down" })
keymap("n", "<C-k>", "<C-w>k", { noremap = true, silent = true, desc = "NavigateWindow Up" })
keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true, desc = "NavigateWindow Right" })

-- Clear search hightlight
keymap("n", "<ESC>", ":nohl<CR>", { noremap = true, silent = true })

-- Resize with arrows
keymap("n", "<up>", "<Cmd>resize -5<CR>", { noremap = true, silent = true })
keymap("n", "<down>", "<Cmd>resize +5<CR>", { noremap = true, silent = true })
keymap("n", "<left>", "<Cmd>vertical resize -5<CR>", { noremap = true, silent = true })
keymap("n", "<right>", "<Cmd>vertical resize +5<CR>", { noremap = true, silent = true })

-- Navigate buffers
keymap("n", "<S-l>", "<Cmd>bnext<CR>", { noremap = true, silent = true, desc = "NavigateBuffer Next" })
keymap("n", "<S-h>", "<Cmd>bprevious<CR>", { noremap = true, silent = true, desc = "NavigateBuffer Prev" })

-- Insert --
-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", { noremap = true, silent = true })
keymap("i", "kj", "<ESC>", { noremap = true, silent = true })

keymap("n", "n", "nzzzv", { noremap = true, silent = true })
keymap("n", "N", "Nzzzv", { noremap = true, silent = true })

-- Use q to quit visual selection
keymap("v", "q", "<Esc>", { noremap = true, silent = true })

-- Remap Q to q for macro recording
keymap("n", "q", "<NOP>", { noremap = true, silent = true })
keymap("n", "Q", "q", { noremap = true, silent = true })

keymap("n", "dt", function() require("configs.utils").toggle_diagnostics() end,
  { silent = true, noremap = true, desc = "Diagnostics toggle(On/Off)" })

keymap("n", "<leader>d", function() require("configs.utils").close_buffer() end,
  { silent = true, noremap = true, desc = "Global delete buffer" })

-- Exit in terminal mode
keymap("t", "jk", "<C-\\><C-n>", { noremap = true, silent = true })
keymap("t", "kj", "<C-\\><C-n>", { noremap = true, silent = true })

keymap("n", "<leader>th", function() require("nvchad.themes").open() end, { desc = "nvchad themes change" })

keymap("n", "<leader>ch", "<Cmd>NvCheatsheet<CR>", { desc = "nvchad nvcheatsheet toggle" })
