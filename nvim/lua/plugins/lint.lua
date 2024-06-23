return {
	"mfussenegger/nvim-lint",
	ft = "gdscript",
	config = function()
		require("lint").linters_by_ft = {
			gdscript = { "gdlint" },
		}

		vim.api.nvim_create_augroup("__linter__", { clear = true })
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			group = "__linter__",
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
