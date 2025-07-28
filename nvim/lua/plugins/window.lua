local ft_ignores = {
	"undotree",
	"no-neck-pain",
	"Avante",
	"AvanteInput",
	"AvanteSelectedFiles",
}

return {
	"anuvyklack/windows.nvim",
	dependencies = { "anuvyklack/middleclass" },
	opts = {
		autowidth = {
			winwidth = 26, -- 80 + 20 + 6 (signcolumn) gives 100 column width
		},
		ignore = {
			filetype = ft_ignores,
			buftype = { "terminal" },
		},
	},

	{
		"nvim-focus/focus.nvim",
		opts = {
			commands = false,
			autoresize = { enable = false },
			ui = {
				hybridnumber = true, -- Display hybrid line numbers in the focussed window only
				absolutenumber_unfocussed = true, -- Preserve absolute numbers in the unfocussed windows

				cursorline = true, -- Display a cursorline in the focussed window only
				cursorcolumn = false, -- Display cursorcolumn in the focussed window only
				signcolumn = false, -- Display signcolumn in the focussed window only
			},
		},
		config = function(_, opts)
			local ignore_buftypes = { "nofile", "prompt", "popup" }

			local augroup = vim.api.nvim_create_augroup("FocusDisable", { clear = true })

			vim.api.nvim_create_autocmd("WinEnter", {
				group = augroup,
				callback = function(_)
					if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) or not vim.wo.number then
						vim.w.focus_disable = true
					else
						vim.w.focus_disable = false
					end
				end,
				desc = "Disable focus autoresize for BufType",
			})

			vim.api.nvim_create_autocmd("FileType", {
				group = augroup,
				callback = function(_)
					if vim.tbl_contains(ft_ignores, vim.bo.filetype) then
						vim.b.focus_disable = true
					else
						vim.b.focus_disable = false
					end
				end,
				desc = "Disable focus autoresize for FileType",
			})

			require("focus").setup(opts)
		end,
	},
}
