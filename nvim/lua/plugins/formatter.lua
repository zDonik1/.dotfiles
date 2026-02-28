return {
	"mhartington/formatter.nvim",
	cmd = "FormatWrite",

	init = function()
		require("utils.snacks").on_snacks_loaded(function()
			if _G.Snacks == nil then
				return
			end

			Snacks.toggle
				.new({
					id = "formatter",
					name = "Format on Save",
					get = function()
						local ok, _ = pcall(vim.api.nvim_get_autocmds, { group = "__formatter__" })
						return ok
					end,
					set = function(state)
						if state then
							vim.api.nvim_create_augroup("__formatter__", { clear = true })
							vim.api.nvim_create_autocmd("BufWritePost", {
								group = "__formatter__",
								command = ":FormatWrite",
							})
						else
							vim.api.nvim_del_augroup_by_name("__formatter__")
						end
					end,
				})
				:map("<leader>uf")
				:set(true)
		end)
	end,

	opts = function()
		local util = require("formatter.util")
		return {
			filetype = {
				lua = { require("formatter.filetypes.lua").stylua },
				rust = { require("formatter.filetypes.rust").rustfmt },
				go = { require("formatter.filetypes.go").gofumpt },
				dart = { require("formatter.filetypes.dart").dartformat },
				cs = { require("formatter.filetypes.cs").csharpier },
				python = { require("formatter.filetypes.python").ruff },
				nix = { require("formatter.filetypes.nix").nixfmt },
				cmake = { require("formatter.filetypes.cmake").cmakeformat },
				json = { require("formatter.filetypes.json").biome },
				toml = { require("formatter.filetypes.toml").taplo },
				gdscript = {
					function()
						return { exe = "gdformat" }
					end,
				},
				wgsl = {
					function()
						return { exe = "wgslfmt" }
					end,
				},
				yaml = {
					function()
						if util.get_current_buffer_file_name() == "helmfile.yaml" then
							return nil
						end
						return require("formatter.filetypes.yaml").prettierd()
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
		}
	end,
}
