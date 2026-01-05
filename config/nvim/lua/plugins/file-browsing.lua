return {
	{
		"echasnovski/mini.pick",
		dependencies = {
			"nvim-mini/mini.icons",
		},
		config = function()
			require("mini.pick").setup()
			require("mini.icons").setup()
			local bufopts = { noremap = true, silent = true, buffer = bufnr }
			vim.keymap.set("n", "<leader>ff", ":Pick files<CR>", bufopts)
			vim.keymap.set("n", "<leader>fh", ":Pick help<CR>", bufopts)
			local TypstExportPicker = require("typst-export-picker")

			vim.keymap.set(
				"n",
				"<leader>fe",
				TypstExportPicker.open_export_picker,
				{ desc = "Open custom color picker" }
			)
		end,
	},
	{
		"stevearc/oil.nvim",
		config = function()
			local oil = require("oil")
			oil.setup()
			vim.keymap.set("n", "<leader>e", oil.toggle_float)
		end,
	},
}
