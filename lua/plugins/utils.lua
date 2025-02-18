return {
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    -- only use in diff mode
    "octol/vim-cpp-enhanced-highlight",
    enabled = require("configs.utils").is_diff_mode(),
    ft = { "cpp" },
  },
  {
    "junegunn/vim-easy-align",
    keys = {
      -- for unknown reason can use <Cmd> must use :
      { "ga", mode = { "n", "x" }, ":EasyAlign<CR>" },
    }
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      scope = { show_start = false, show_end = false },
      exclude = {
        filetypes = {
          "Trouble",
          "alpha",
          "dashboard",
          "help",
          "lazy",
          "mason",
          "nvim-tree",
          "notify",
          "trouble",
        },
      },
    },
  },

  {
    "andersevenrud/nvim_context_vt",
    event = "VeryLazy",
    ft = { 'c', 'cpp', 'lua', 'python' },
    config = function()
      vim.api.nvim_set_hl(0, 'CustomContextVt', { fg = '#928374', bold = true, italic = true })
      require('nvim_context_vt').setup({
        enabled = true,
        prefix = '󰞘 𝓮𝓷𝓭 𝓸𝓯',
        highlight = 'CustomContextVt',
        disable_ft = { 'markdown' },
        disable_virtual_lines = false,
        disable_virtual_lines_ft = { 'yaml' },
        min_rows = 20,
      })
    end,
  },
  {
    "kevinhwang91/nvim-hlslens",
    event = "VeryLazy",
    config = function()
      require('hlslens').setup({
        override_lens = function(render, posList, nearest, idx)
          local text, chunks
          local lnum, col = unpack(posList[idx])
          if nearest then
            local cnt = #posList
            text = ('[%d/%d]'):format(idx, cnt)
            chunks = { { ' ', 'Ignore' }, { text, 'HlSearchLensNear' } }
          else
            text = ('[%d]'):format(idx)
            chunks = { { ' ', 'Ignore' }, { text, 'HlSearchLens' } }
          end
          render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
        end

      })
       -- lhsearch colror and keymap for *#
      -- vim.keymap.set('n', '*', "<Cmd>lua require('hlslens').start()<CR>")
      -- vim.keymap.set('n', '#', "<Cmd>lua require('hlslens').start()<CR>")
      -- vim.keymap.set('v', '*', "<Cmd>lua require('hlslens').start()<CR>")
      -- vim.keymap.set('v', '#', "<Cmd>lua require('hlslens').start()<CR>")
    end
  }
}
