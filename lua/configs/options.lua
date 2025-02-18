local options = {
  backup = false,                          -- creates a backup file
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  cmdheight = 2,                           -- more space in the neovim command line for displaying messages
  completeopt = { "menu", "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0,                        -- so that `` is visible in markdown files
  fileencoding = "utf-8",                  -- the encoding written to a file
  hlsearch = true,                         -- highlight all matches on previous search pattern
  ignorecase = true,                       -- ignore case in search patterns
  mouse = "n",                             -- allow the mouse to be used in neovim
  pumheight = 10,                          -- pop up menu height
  showcmd = false,
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  showtabline = 0,                         -- never show tabs
  smartcase = true,                        -- smart case
  smartindent = true,                      -- make indenting smarter again
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  swapfile = false,                        -- creates a swapfile
  termguicolors = true,                    -- set term gui colors (most terminals support this)
  timeoutlen = 500,                        -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                         -- enable persistent undo
  updatetime = 100,                        -- faster completion (4000ms default)
  writebackup = true,                      -- if a file is being edited by another program 
                                           --(or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true,                        -- convert tabs to spaces
  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
  tabstop = 4,                             -- insert 4 spaces for a tab
  cursorline = true,                       -- highlight the current line
  number = true,                           -- set numbered lines
  relativenumber = true,                   -- set relative numbered lines
  numberwidth = 4,                         -- set number column width to 2 {default 4}

  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  wrap = true,                             -- display lines as one long line
  linebreak = true,                        -- companion to wrap, don't split words
  scrolloff = 10,                          -- minimal number of screen lines to keep above and below the cursor
  sidescrolloff = 10,                      -- minimal number of screen columns either side of cursor if wrap is `false`
  whichwrap = "bs<>[]hl",                  -- which "horizontal" keys are allowed to travel to prev/next line

  ruler = false,
  laststatus = 2,
  list = true,
  magic = true,
  redrawtime = 300,
  showmatch = true,
  matchtime = 1,
  tags = "./.tags;,.tags",
  cindent = true,
  cinoptions = "g0,:0,N-s,(0",
  softtabstop = 4,
  smarttab = true,
  autowrite = false,
  confirm = true

}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0

vim.g.diff_translations = 0 -- To disable localisations and speed up the syntax highlighting

vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
}
local function foldtext()
  return vim.api.nvim_buf_get_lines(0, vim.v.lnum - 1, vim.v.lnum, false)[1]
end
-- vim.opt.foldmethod = "indent"
vim.opt.foldtext = foldtext()

vim.diagnostic.enable(false)                           -- disable diagnostic by default

vim.opt.shortmess:append "c"                           -- don't give |ins-completion-menu| messages
vim.opt.iskeyword:append "-"                           -- hyphenated words recognized by searches
vim.opt.formatoptions:remove({ "c", "r", "o" })        -- don't insert the current comment leader automatically 
                                                       -- for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode.
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles")  -- separate vim plugins from neovim in case vim still in use
-- add binaries installed by mason.nvim to path
local is_windows = vim.fn.has "win32" ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath "data", "mason", "bin" }, sep) .. delim .. vim.env.PATH
