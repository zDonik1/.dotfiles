-- vim.lsp.config("*", {
-- 	capabilities = {
-- 		textDocument = {
-- 			completion = {
-- 				completionItem = {
-- 					snippetSupport = false,
-- 				},
-- 			},
-- 		},
-- 	},
-- })

vim.lsp.enable({
	"lua_ls",
	"csharp_ls",
	"rust_analyzer",
	"wgsl_analyzer",
	"nushell",
	"gdscript",
	"nil_ls",
	"nixd",
	"pylsp",
	"ruff",
	"clangd",
	"cmake",
	"yamlls",
	"taplo",
	"gopls",
	"dartls",
	"helm_ls",
	"eslint",
	"ts_ls",
	"markdown_oxide",
})

vim.diagnostic.config({
	float = {
		focusable = false,
		border = "rounded",
		header = "",
		prefix = "",
	},
})

vim.lsp.inlay_hint.enable()

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp", {}),
	callback = function(args)
		local bufnr = args.buf
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

		if client:supports_method("textDocument/codeLens") then
			vim.lsp.codelens.refresh()
			vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
				buffer = bufnr,
				callback = vim.lsp.codelens.refresh,
			})
		end
	end,
})

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"j-hui/fidget.nvim",
		},
		lazy = false,

		keys = function()
			local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
			local next_diagnostic, prev_diagnostic = ts_repeat_move.make_repeatable_move_pair(
				function()
					vim.diagnostic.jump({ count = 1, float = true })
				end,
				function()
					vim.diagnostic.jump({ count = -1, float = true })
				end
			)

			return {
				{
					"]d",
					next_diagnostic,
					desc = "Go to next LSP diagnostic",
					mode = { "n", "x", "o" },
				},
				{
					"[d",
					prev_diagnostic,
					desc = "Go to previous LSP diagnostic",
					mode = { "n", "x", "o" },
				},
			}
		end,
	},

	{
		"j-hui/fidget.nvim",
		opts = {
			notification = {
				window = {
					winblend = 0, -- Background color opacity in the notification window
				},
			},
		},
	},
}
