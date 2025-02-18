-- local signs = {
--     { name = "DiagnosticSignError", text = "✘" },
--     { name = "DiagnosticSignWarn",  text = "" },
--     { name = "DiagnosticSignHint",  text = "" },
--     { name = "DiagnosticSignInfo",  text = "" },
-- }
--
-- for _, sign in ipairs(signs) do
--     vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
-- end

local x = vim.diagnostic.severity
local config = {
    virtual_text = { prefix = "" },
    signs = { text = { [x.ERROR] = "✘", [x.WARN] = "", [x.INFO] = "", [x.HINT] = "" } },
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
            focusable = true,
            style  = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    }
vim.diagnostic.config(config)
