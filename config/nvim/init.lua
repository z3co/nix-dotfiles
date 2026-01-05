-------------------
-- Custom macros --
-------------------

local esc = vim.api.nvim_replace_termcodes("<Esc>", true, true, true)

vim.fn.setreg("l", "yoconsole.log('" .. esc .. "pa: ', " .. esc .. "pa);" .. esc .. "")

-- Lazy
require("config.lazy")

