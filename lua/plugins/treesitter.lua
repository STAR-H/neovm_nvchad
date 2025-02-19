return {
  "nvim-treesitter/nvim-treesitter",
  enabled = not require("configs.utils").is_diff_mode(),
  event = { "BufReadPost", "BufNewFile" },
  build = ":TsUpdate",   -- auto update installed parser
  init = function()
    dofile(vim.g.base46_cache .. "syntax")
    dofile(vim.g.base46_cache .. "treesitter")
  end,
  config = function()
  local opts = {
    ensure_installed = {
      "html",
      "python",
      "diff",
      "bash",
      "json",
      "vim",
      "lua",
      "c",
      "cpp",
      "markdown",
      "markdown_inline",
      "vim",
      "regex",
      "query",
    },
    sync_install = false,
    auto_install = false,
    highlight = {
      enable = true,
      disable = function(lang, buf)
        local max_filesize = 1024 * 1024 -- 1MB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = false }, -- influnce = indent
    incremental_selection = { enable = false },
    textobjects = { enable = true },
  }
  require'nvim-treesitter.configs'.setup(opts)
  end,
}
