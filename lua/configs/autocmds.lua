-- load nvchad autocmds
require "nvchad.autocmds"

-- function for diffMode (vi -d)
function IsDiffMode()
    if vim.opt.diff:get() then
        return true
    else
        return false
    end
end

function ToggleDiagnostics()
    if vim.diagnostic.is_enabled() then
        vim.diagnostic.enable(true)
        vim.notify("Diagnostic Enabled!", vim.log.levels.INFO)
    else
        vim.diagnostic.enable(false)
        vim.notify("Diagnostic Disabled!", vim.log.levels.INFO)
    end
end

-- close buffer or window layout
function CloseBuffer()
    local win_count = vim.fn.winnr('$')
    if win_count > 1 then
        vim.cmd("close")
    else
        vim.cmd("bd")
    end
end

local function augroup(name)
  return vim.api.nvim_create_augroup("star_" .. name, { clear = true })
end

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
 group = augroup("highlight_yank"),
 callback = function()
   (vim.hl or vim.highlight).on_yank({higroup="IncSearch", timeout=300})
 end,
})

-- Open the file to automatically locate to the last edited position
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].neovim_last_loc then
      return
    end
    vim.b[buf].neovim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Set the terminal buffer when terminal open
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      vim.opt_local.signcolumn ="no"
  end,
})


-- vim.api.nvim_create_autocmd("DiagnosticChanged", {
--   callback = function()
--     -- check lualine load status
--     local status_ok, lualine = pcall(require, 'lualine')
--     if status_ok then
--       lualine.refresh() -- flash lualine status
--     else
--       vim.notify('lualine is not loaded!', vim.log.levels.WARN)
--     end
--   end,
-- })


-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "checkhealth",
    "gitsigns-blame",
    "help",
    "lspinfo",
    "notify",
    "startuptime",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = "Quit buffer",
      })
    end)
  end,
})

-- auto enable diagnostics in lua
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.diagnostic.enable(true)  -- enable diagnostics in current buffer
  end,
})
