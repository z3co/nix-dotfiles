return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    commit = "20db421f5fba0c23f6a7629af96ba6d4fc531677",
    config = function()
	local configs = require'nvim-treesitter'
	configs.install({ "go", "nix", "lua", "vimdoc", "markdown" })
	vim.api.nvim_create_autocmd('FileType', {
	    pattern = { "go", "nix", "lua", "vimdoc", "markdown" },
		callback = function() 
			vim.treesitter.start()
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end,
	})
    end,
}
