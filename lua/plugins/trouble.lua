return {
  "folke/trouble.nvim",
  keys = {
    { "gr",         "<cmd>Trouble lsp toggle<cr>",                      desc = "lsp reference" },
    { "<leader>ld", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "diagnostic list(current buffer)" },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    position = "bottom",
    height = 10,
    padding = false,
    cycle_results = false,
  },
}
