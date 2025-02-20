return {
  "folke/trouble.nvim",
  keys = {
    { "gr",         "<cmd>Trouble lsp toggle<cr>"},
    { "<leader>ld", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Diagnostics list diagnostics info(current buffer)" },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    auto_close = true, -- auto close when there are no items
    warn_no_results = false, -- show a warning when there are no results
  },
}
