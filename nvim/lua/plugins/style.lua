return {
	{
		"catppuccin/nvim",
		name = "catppuccin.nvim",
		lazy = false,
		opts = {
			show_end_of_buffer = true,
			custom_highlights = function(colors)
				return {
					["@text.emphasis"] = { fg = colors.green },
					["@markup.italic"] = { fg = colors.green },
					["@markup.quote"] = { fg = colors.lavender },
					rainbow1 = { bold = true },
					rainbow2 = { bold = true },
					rainbow3 = { bold = true },
					rainbow4 = { bold = true },
					rainbow5 = { bold = true },
					rainbow6 = { bold = true },

					RenderMarkdownH1Bg = { bg = "#4d363c" },
					RenderMarkdownH2Bg = { bg = "#4d3e36" },
					RenderMarkdownH3Bg = { bg = "#4d4536" },
					RenderMarkdownH4Bg = { bg = "#374d36" },
					RenderMarkdownH5Bg = { bg = "#36454d" },
					RenderMarkdownH6Bg = { bg = "#36394d" },
					RenderMarkdownCode = { bg = colors.mantle },
					RenderMarkdownCodeInline = { bg = colors.mantle },
					RenderMarkdownBullet = { link = "@markup.list" },
				}
			end,
		},
		config = function(_, opts)
			-- make background transparent
			vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
			vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })

			require("catppuccin").setup(opts)
			vim.cmd.colorscheme("catppuccin")
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		config = true,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPre",
		opts = {
			scope = { enabled = false },
		},
		config = function(_, opts)
			require("ibl").setup(opts)
		end,
	},

	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
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
			local ignore_filetypes = {}
			local ignore_buftypes = { "nofile", "prompt", "popup" }

			local augroup = vim.api.nvim_create_augroup("FocusDisable", { clear = true })

			vim.api.nvim_create_autocmd("WinEnter", {
				group = augroup,
				callback = function(_)
					if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
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
					if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
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

	{
		"Bekaboo/deadcolumn.nvim",
		init = function()
			vim.o.colorcolumn = "101"
		end,
		opts = {
			blending = { threshold = 1 },
		},
	},
}
