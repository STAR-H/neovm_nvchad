return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("configs.handlers").defaults()

      local lspconfig = require "lspconfig"
      local lsphandlers = require("configs.handlers")

      local servers = { "clangd", "cmake", "bashls",}
      -- local nvlsp = require "nvchad.configs.lspconfig"

      -- lsps with default config
      -- for _, lsp in ipairs(servers) do
      --   lspconfig[lsp].setup {
      --     on_attach = nvlsp.on_attach,
      --     on_init = nvlsp.on_init,
      --     capabilities = nvlsp.capabilities,
      --   }
      -- end

      -- configuring single server
      lspconfig.lua_ls.setup {
        on_attach = lsphandlers.on_attach,
        capabilities = lsphandlers.capabilities,
        on_init = lsphandlers.on_init,

        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                vim.fn.expand "$VIMRUNTIME/lua",
                vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
                vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
                vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
                "${3rd}/luv/library",
              },
              maxPreload = 100000,
              preloadFileSize = 10000,
            },
          },
        },
      }
    end,
  },
  {
    "SmiteshP/nvim-navic",
    event = "VeryLazy",
    dependencies = { "neovim/nvim-lspconfig" },
    init = function()
      -- PERF: Set it to true to update context only on CursorHold event. Could be usefull if
      -- you are facing performance issues on large files. Example usage
      vim.api.nvim_create_autocmd("BufEnter", {
        callback = function()
          if vim.api.nvim_buf_line_count(0) > 10000 then
            vim.b.navic_lazy_update_context = true
          end
        end,
      })
    end,
    config = function()
      require("nvim-navic").setup {
        icons = {
          File          = "󰈙 ",
          Module        = " ",
          Namespace     = "󰦮 ",
          Package       = " ",
          Class         = " ",
          Method        = "ƒ ",
          Property      = "󰜢 ",
          Field         = " ",
          Constructor   = " ",
          Enum          = " ",
          Interface     = " ",
          Function      = "󰊕 ",
          Variable      = "󰀫 ",
          Constant      = "󰏿 ",
          String        = " ",
          Number        = "󰎠 ",
          Boolean       = "󰨙 ",
          Array         = "󰅪 ",
          Object        = "󰅩 ",
          Key           = "󰌋 ",
          Null          = "󰟢 ",
          EnumMember    = " ",
          Struct        = "󰆧 ",
          Event         = " ",
          Operator      = " ",
          TypeParameter = " ",
        },
        lsp = {
          auto_attach = true,
          preference = nil,
        },
        highlight = false,
        separator = " > ",
        depth_limit = 10,
        depth_limit_indicator = "..",
        safe_output = true,
        lazy_update_context = false,
        click = true
      }
    end,
  },

  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    -- extend default config by nvchad
    opts = function(_, conf)
    end,
  },
}
