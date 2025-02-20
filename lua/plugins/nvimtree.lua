return {
  "nvim-tree/nvim-tree.lua",
  keys = {
    { "<leader>n", "<Cmd>NvimTreeToggle<CR>", desc = "NvimTree Toggle" },
  },
  config = function()
    local function my_on_attach(bufnr)
      local api = require('nvim-tree.api')
      local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end
      -- default mappings
      -- api.config.mappings.default_on_attach(bufnr)

      -- custom key mappings start
      vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close'))
      vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
      vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
      vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
      vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
      vim.keymap.set('n', 'a', api.fs.create, opts('Create File or Dir'))
      vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
      vim.keymap.set('n', 'e', api.tree.expand_all, opts('Expand All'))
      vim.keymap.set('n', 'p', api.node.navigate.parent, opts('Parent Directory'))
      vim.keymap.set('n', 'w', api.tree.collapse_all, opts('Collapse'))
      vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
      vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
      vim.keymap.set('n', '<C-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
      vim.keymap.set('n', '<BS>', api.tree.change_root_to_parent, opts('Up'))
      vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node(), opts('Change Root Dir'))
      vim.keymap.set('n', 'x', api.fs.cut(), opts('Cut'))
      vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
      -- custom key mappings end
    end

    require("nvim-tree").setup({
      -- Changes the tree root directory on `DirChanged` and refreshes the tree.
      sync_root_with_cwd = false,
      -- Will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
      respect_buf_cwd = false,
      sort_by = "case_sensitive",
      on_attach = my_on_attach,
      view = {
        width = 40,
        side = "right",
      },
      update_focused_file = {
        enable = true,
        -- Update the root directory of the tree if the file is not under current
        -- root directory. It prefers vim's cwd and `root_dirs`.
        -- Otherwise it falls back to the folder containing the file.
        update_root = {
          enable = true,
        },
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = true,
      },
    })
  end
}
