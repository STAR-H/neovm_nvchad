return {
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },

  {
    "folke/todo-comments.nvim",
    event = {"BufReadPre", "BufNewFile"},
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      highlight = {
        after = "", -- "fg" or "bg" or empty
      },
    },
    -- TODO: check hight only highlight the sign not the text
    keys = {
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo-Comments Trouble Toggle" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo-Comments Telescope Show" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo-Comments Telescope Keyword" },
    },
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
      { "ga", mode = { "n", "x" }, ":EasyAlign<CR>" , desc = "EasyAlign Toggle +"},
    }
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "User FilePost",
    opts = {
      indent = { char = "│", highlight = "IblChar" },
      scope = { show_start = false, show_end = false, char = "│", highlight = "IblScopeChar" },
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
    config = function(_, opts)
      local hooks = require "ibl.hooks"
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
      require("ibl").setup(opts)
    end,
  },

  {
    "andersevenrud/nvim_context_vt",
    event = "VeryLazy",
    enabled = require("configs.utils").is_diff_mode(),
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
    -- replace by noice view_search virtualtext
    "kevinhwang91/nvim-hlslens",
    event = "VeryLazy",
    config = function()
      require('hlslens').setup({
        override_lens = function(render, posList, nearest, idx)
          local text, chunks
          local lnum, col = unpack(posList[idx])
          if nearest then
            local cnt = #posList
            text = ('(%d/%d)'):format(idx, cnt)
            chunks = { { ' ', 'Ignore' }, { text, 'HlSearchLensNear' } }
          end
          render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
        end

      })
      local kopts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
    end
  },

  -- autopairing of (){}[] etc
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      fast_wrap = {},
      disable_filetype = { "TelescopePrompt", "vim" },
    },
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)

      -- setup cmp for autopairs
      local cmp_autopairs = require "nvim-autopairs.completion.cmp"
      require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  {
    "stevearc/profile.nvim",
    enabled = false,
    lazy = false,
    config = function()
      local should_profile = os.getenv("NVIM_PROFILE")
      if should_profile then
        require("profile").instrument_autocmds()
        if should_profile:lower():match("^start") then
          require("profile").start("*")
        else
          require("profile").instrument("*")
        end
      end

      local function toggle_profile()
        local prof = require("profile")
        if prof.is_recording() then
          prof.stop()
          vim.ui.input({ prompt = "Save profile to:", completion = "file", default = "profile.json" }, function(filename)
            if filename then
              prof.export(filename)
              vim.notify(string.format("Wrote %s", filename))
            end
          end)
        else
          prof.start("*")
        end
      end
      vim.keymap.set("", "<f2>", toggle_profile)
    end
  }
}
