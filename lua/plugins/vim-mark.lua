return {
  "STAR-H/vim-mark",
  keys = {
    {"mm", mode = {"n", "x"}, "<Plug>MarkSet", desc = "Set a Mark"},
    {"mr", "<Plug>MarkRegex", desc = "Mark by Regx"},
    {"mc", "<Plug>MarkAllClear", desc = "Clear All Mark"},
    -- TODO: make n N moree smart can tell vim-mark or normal search
    {"n", "<Plug>MarkSearchOrCurNext", desc = "Mark Search Next"},
    {"N", "<Plug>MarkSearchOrCurPrev", desc = "Mark Search Prev"},
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
