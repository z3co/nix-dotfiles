local MiniPick = require("mini.pick")

local export_types = {
	"pdf",
	"png",
	"svg",
	"html",
}

local typst_export_picker = {
	action = function(item)
		if item == nil then
			return
		end
		local filetype = vim.bo.filetype
		if filetype ~= "typst" then
			print("Current buffer is not a typst file")
			return
		end
		local current_file = vim.fn.expand("%:p")
		local cmd = "typst compile --format " .. item .. " " .. current_file
		print("Running: " .. cmd)
		local result = vim.fn.system(cmd)
		local exit_code = vim.v.shell_error
		if exit_code ~= 0 then
			print("Typst compilation failed: " .. result)
		else
			print("Successfully exported to " .. item)
		end
	end,
}

local M = {}

function M.open_export_picker()
	typst_export_picker.action(
		MiniPick.start({ source = { name = "Select a format to export", items = export_types } })
	)
end

return M
