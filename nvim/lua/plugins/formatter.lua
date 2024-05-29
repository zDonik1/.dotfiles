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
		require("formatter").setup({
			filetype = {
				lua = { require("formatter.filetypes.lua").stylua },
				cpp = { require("formatter.filetypes.cpp").clangformat },
				rust = { require("formatter.filetypes.rust").rustfmt },
				cs = { require("formatter.filetypes.cs").csharpier },
				python = { require("formatter.filetypes.python").autopep8 },
				nix = { require("formatter.filetypes.nix").nixfmt },
				gdscript = {
					function()
						return { exe = "gdformat" }
					end,
				},
			},
		})
	end,
}
