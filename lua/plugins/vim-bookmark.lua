return {
  "MattesGroeger/vim-bookmarks",
  keys = {
    { '<Space>bb', "<cmd>BookmarkToggle<CR>",   desc = "Bookmark Toggle" },
    { '<Space>bi', "<cmd>BookmarkAnnotate<CR>", desc = "Bookmark Annotate" },
    { '<Space>bj', "<cmd>BookmarkNext<CR>",     desc = "Bookmark Go to Next" },
    { '<Space>bk', "<cmd>BookmarkPrev<CR>",     desc = "Bookmark Go to Prev" },
    { '<Space>ba', "<cmd>BookmarkShowAll<CR>",  desc = "Bookmark Show All Bookmark" },
    { '<Space>bc', "<cmd>BookmarkClearAll<CR>", desc = "Bookmark Clear All Bookmark" },
  },
  config = function()
    vim.g.bookmark_no_default_key_mappings = 1
    vim.g.bookmark_show_toggle_warning = 0
    vim.g.bookmark_highlight_lines = 1
    vim.g.bookmark_location_list = 1
    vim.g.bookmark_disable_ctrlp = 1
    vim.g.bookmark_show_warning = 0
    vim.g.bookmark_auto_close = 1
    vim.g.bookmark_auto_save = 0
    vim.g.bookmark_center = 1
    vim.g.bookmark_sign = ''
    vim.g.bookmark_annotation_sign = '﭅'

    vim.api.nvim_set_hl(0, 'BookmarkSign', { fg = '#a9ddea', bg = '#3c3836' })
    vim.api.nvim_set_hl(0, 'BookmarkAnnotationSign', { fg = '#a9ddea', bg = '#3c3836' })
  end
}
