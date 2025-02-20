return {
  "STAR-H/vim-mark",
  keys = {
    {"mm", mode = {"n", "x"}, "<Plug>MarkSet", desc = "Mark Set/Unset"},
    {"mr", "<Plug>MarkRegex", desc = "Mark by Regx"},
    {"mc", "<Plug>MarkAllClear", desc = "Mark Clear"},
  },
  branch = "master",
  dependencies = "inkarkat/vim-ingo-library",
  -- do not add mark words to the search(/)  and input(@) history
  config = function()
    vim.g.mwHistAdd = ' '
    -- let marks to be case-insensitive
    vim.g.mwIgnoreCase = 0
    vim.g.mwMaxMatchPriority = 10
    vim.g.mw_no_mappings = 1
  end
}
