local M = {}

function M.on_snacks_loaded(fn)
	vim.api.nvim_create_autocmd("User", {
		pattern = "VeryLazy",
		callback = fn,
	})
end

return M
