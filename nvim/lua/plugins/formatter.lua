return {
	"mhartington/formatter.nvim",
	cmd = "FormatWrite",
	init = function()
		vim.api.nvim_create_augroup("__formatter__", { clear = true })
		vim.api.nvim_create_autocmd("BufWritePost", {
			group = "__formatter__",
			command = ":FormatWrite",
		})
	end,
	config = function()
		local util = require("formatter.util")
		require("formatter").setup({
			filetype = {
				lua = { require("formatter.filetypes.lua").stylua },
				rust = { require("formatter.filetypes.rust").rustfmt },
				cs = { require("formatter.filetypes.cs").csharpier },
				python = { require("formatter.filetypes.python").ruff },
				nix = { require("formatter.filetypes.nix").nixfmt },
				cmake = { require("formatter.filetypes.cmake").cmakeformat },
				gdscript = {
					function()
						return { exe = "gdformat" }
					end,
				},
				cpp = {
					function()
						return {
							exe = "clang-format",
							args = {
								"-fallback-style=WebKit", -- WebKit style based on Qt style
								"-assume-filename",
								util.escape_path(util.get_current_buffer_file_name()),
							},
							stdin = true,
							try_node_modules = true,
						}
					end,
				},
			},
		})
	end,
}
