vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = ","

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "STAR-H/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- TODO: mason install output error twice may realted mason.nvim version, but lua_ls attch twice may config issue
-- TODO: add tmux disable pane move when zoomed
-- check the diff mode plugin load situation
-- make autocmd q to quit in diff mode
-- load theme
-- Load all cached colors in prevent
local base46_cache = require "chadrc".base46.integrations or {}
for _, v in ipairs(base46_cache) do
  dofile(vim.g.base46_cache .. v)
end

require "configs.options"
require "configs.autocmds"

vim.schedule(function()
  require "configs.mappings"
end)
