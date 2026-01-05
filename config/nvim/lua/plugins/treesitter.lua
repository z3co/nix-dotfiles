return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter")
		configs.setup({
			sync_install = false,
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
			ensure_installed = {},
			ignore_install = {},
			modules = {},
		})
	end,
}
