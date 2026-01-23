require('nvim-treesitter').setup {
    ensure_installed = {},

    auto_install = false,

    highlight = { 
			enable = true,
			additional_vim_regex_highligting = false,

		},

    indent = { enable = true },
}

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local bufnr = args.buf
    -- Tjek om vi har en parser til dette sprog før vi starter
    local lang = vim.bo[bufnr].filetype
    if lang ~= "" and vim.treesitter.language.add(lang) then
        vim.treesitter.start(bufnr)
    end
  end,
})
