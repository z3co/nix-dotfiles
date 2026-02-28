return {
    {
	"neovim/nvim-lspconfig",
	dependencies = {
	    "nvimtools/none-ls.nvim",
	    "nvim-lua/plenary.nvim",
	    "hrsh7th/nvim-cmp",
	    "saadparwaiz1/cmp_luasnip",
	    'hrsh7th/cmp-buffer',
	    'hrsh7th/cmp-path',
	    "L3MON4D3/LuaSnip",
	    "rafamadriz/friendly-snippets",
	},
	config = function()

	    vim.keymap.set({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help)
	    vim.keymap.set("n", "K", vim.lsp.buf.hover)
	    vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format)
	    vim.lsp.enable({ "lua_ls", "gopls", "tinymist", "nixd" })

	    -- Solve warnings in neovim config
	    vim.lsp.config("lua_ls", {
		settings = {
		    Lua = {
			workspace = {
			    library = vim.api.nvim_get_runtime_file("", true),
			},
		    },
		},
	    })

	    vim.diagnostic.config({
		virtual_text = true,
		severity_sort = true,
		float = {
		    style = 'minimal',
		    border = 'rounded',
		    header = '',
		    prefix = '',
		},
		signs = {
		    text = {
			[vim.diagnostic.severity.ERROR] = '✘',
			[vim.diagnostic.severity.WARN] = '▲',
			[vim.diagnostic.severity.HINT] = '⚑',
			[vim.diagnostic.severity.INFO] = '»',
		    },
		},
	    })

	    vim.api.nvim_create_autocmd('LspAttach', {
		callback = function(event)
		    local opts = { buffer = event.buf }

		    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
		    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
		    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
		    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
		    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
		    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
		    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
		    vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
		    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
		    vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
		    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
		end,
	    })

	    local null_ls = require"null-ls"
	    null_ls.setup({
		sources = {
		    null_ls.builtins.formatting.stylua,
		    null_ls.builtins.formatting.gofumpt,
		    null_ls.builtins.diagnostics.golangci_lint,
		},
	    })

	    local cmp = require"cmp"

	    require"luasnip.loaders.from_vscode".lazy_load()

	    vim.opt.completeopt = { "menu", "menuone", "noselect" }
	    
	    cmp.setup({
		window = {
		    completion = cmp.config.window.bordered(),
		    documentation = {
			winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder",
			border = "rounded",
			close_events = { "CursorMoved", "BufHidden", "InsertLeave" },
		    },
		},
		mapping = cmp.mapping.preset.insert({
		    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
		    ["<C-f>"] = cmp.mapping.scroll_docs(4),
		    ["<C-Space>"] = cmp.mapping.complete(),
		    ["<C-e>"] = cmp.mapping.abort(),
		    ["<CR>"] = cmp.mapping.confirm({ select = false }),
		}),
		sources = {
		    { name = "path" },
		    { name = "nvim_lsp" },
		    { name = "buffer", keyword_length = 3 },
		    { name = "luasnip", keyword_length = 2 },
		},
	    })



	end,
    },
}
