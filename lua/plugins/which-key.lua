return {
  "folke/which-key.nvim",
  enabled = false, -- replace by nvcheetsheet
  cmd = "WhichKey",
  opts = function()
    local settings = {
      delay = 1000,
      icons = {
        mappings = false, -- not use icon
      },
    }
    return settings
  end,
}
