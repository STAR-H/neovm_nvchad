return {
  -- TODO: add picker for search in current buffer
  -- and optimate the live grep behavior
  "nvim-telescope/telescope.nvim",
  branch = '0.1.x',
  cmd = "Telescope",
  keys = {
    -- TODO: find files from root dir
    { "<leader>ff", "<cmd>Telescope find_files<cr>",                desc = 'telescope find files' },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>",                 desc = 'telescope live grep' },
    { "<leader>fb", "<cmd>Telescope buffers<cr>",                   desc = 'telescope list buffers' },
    { "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = 'telescope fuzzy search' },
    -- TODO: add a keymap for lsp symbols
  },
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-lua/plenary.nvim" },
  },
  config = function()
    dofile(vim.g.base46_cache .. "telescope")
    local actions = require "telescope.actions"
    require("telescope").load_extension("fzf")
    require('telescope').setup({
      defaults = {
        git_worktrees = vim.g.git_worktrees,
        color_devicons = false,
        prompt_prefix = "  ",
        selection_caret = "  ",
        path_display = { "truncate" },
        sorting_strategy = "descending",
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--trim" --remove indentation
        },
        layout_config = {
          horizontal = { prompt_position = "bottom", preview_width = 0.6 },
          vertical = { mirror = false },
          width = 0.9,
          height = 0.9,
          preview_cutoff = 120,
        },
        mappings = {
          i = {
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-e>"] = actions.close,
          },
          n = { ["<C-e>"] = actions.close },
        },
      },
      pickers = {
        find_files = {
          theme = "dropdown",
          previewer = false,
        },
        buffers = {
          theme = "dropdown",
          previewer = false,
          ignore_current_buffer = true,
        },
        commands = {
          theme = "dropdown",
          previewer = false,
        },
        live_grep = {
          disable_coordinates = false,
        },
        current_buffer_fuzzy_find = {
          skip_empty_lines = true,
        }
      },
    })
  end
}
