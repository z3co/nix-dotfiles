require("catppuccin").setup({
	integrations = {
		treesitter = true,
		native_lsp = {
			enabled = true,
		},
	},
})
vim.cmd.colorscheme "catppuccin"
