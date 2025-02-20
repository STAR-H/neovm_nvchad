-- load nvchad autocmds
pcall(require, "nvchad.autocmds")

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


vim.api.nvim_create_autocmd("DiagnosticChanged", {
  callback = function()
    -- check lualine load status
    local status_ok, lualine = pcall(require, 'lualine')
    if status_ok then
      lualine.refresh() -- flash lualine status
    else
      vim.notify('lualine is not loaded!', vim.log.levels.WARN)
    end
  end,
})

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
    "nvcheatsheet",
    "nvdash"
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        if #vim.api.nvim_list_wins() > 1 then
          vim.cmd("close")
        else
          vim.cmd("bdelete!") -- 仅删除缓冲区，不关闭窗口
        end
      end, {
        buffer = event.buf,
        silent = true,
        desc = "Quit buffer",
      })
      vim.keymap.set("n", "<ESC>", function()
        if #vim.api.nvim_list_wins() > 1 then
          vim.cmd("close")
        else
          vim.cmd("bdelete!") -- 仅删除缓冲区，不关闭窗口
        end
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

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})
