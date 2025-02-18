-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "gruvbox",
}

M.nvdash = { load_on_startup = true }

M.ui = {
  -- disable nvchad bufferline and statusline
  tabufline = {
    enabled = false,
  },
  statusline = {
    enabled = false,
  },
}

-- TODO: remove cheetsheet keymap for q and <ESC>
return M
