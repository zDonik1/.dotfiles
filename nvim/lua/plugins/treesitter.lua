return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context",
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = vim.cmd.TSUpdate,
		lazy = false,

		config = function()
			local ignore_ft = {
				"csv",
			}

			-- packaged in nvim
			local ignore_install = {
				"c",
				"lua",
				"markdown",
				"markdown_inline",
				"query",
				"vim",
				"vimdoc",
			}

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("treesitter.setup", {}),
				callback = function(args)
					local buf = args.buf
					local filetype = args.match

					if vim.list_contains(ignore_ft, filetype) then
						return
					end

					local language = vim.treesitter.language.get_lang(filetype) or filetype
					if not vim.treesitter.language.add(language) then
						return
					end

					if vim.list_contains(ignore_install, language) then
						vim.treesitter.start(buf, language)
					else
						require("nvim-treesitter").install(language):await(function()
							vim.treesitter.start(buf, language)
						end)
					end

					-- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
					-- vim.wo.foldmethod = "expr"

					vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		optional = true,
		branch = "main",

		keys = function()
			local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")
			local select_textobject =
				require("nvim-treesitter-textobjects.select").select_textobject

			return {
				{
					";",
					ts_repeat_move.repeat_last_move,
					desc = "TS repeat last move",
					mode = { "n", "x", "o" },
				},
				{
					",",
					ts_repeat_move.repeat_last_move_opposite,
					desc = "TS repeat last move opposite",
					mode = { "n", "x", "o" },
				},
				{
					"f",
					ts_repeat_move.builtin_f_expr,
					expr = true,
					desc = "Go to letter",
					mode = { "n", "x", "o" },
				},
				{
					"F",
					ts_repeat_move.builtin_F_expr,
					expr = true,
					desc = "Go to letter backwards",
					mode = { "n", "x", "o" },
				},
				{
					"t",
					ts_repeat_move.builtin_t_expr,
					expr = true,
					desc = "Go to letter not reaching",
					mode = { "n", "x", "o" },
				},
				{
					"T",
					ts_repeat_move.builtin_T_expr,
					expr = true,
					desc = "Go to letter not reaching backwards",
					mode = { "n", "x", "o" },
				},

				{
					"am",
					function()
						select_textobject("@function.outer", "textobjects")
					end,
					desc = "Text object: outer function",
					mode = { "x", "o" },
				},
				{
					"im",
					function()
						select_textobject("@function.inner", "textobjects")
					end,
					desc = "Text object: inner function",
					mode = { "x", "o" },
				},
				{
					"ac",
					function()
						select_textobject("@class.outer", "textobjects")
					end,
					desc = "Text object: outer class",
					mode = { "x", "o" },
				},
				{
					"ic",
					function()
						select_textobject("@class.inner", "textobjects")
					end,
					desc = "Text object: inner class",
					mode = { "x", "o" },
				},
				{
					"ar",
					function()
						select_textobject("@parameter.outer", "textobjects")
					end,
					desc = "Text object: outer parameter",
					mode = { "x", "o" },
				},
				{
					"ir",
					function()
						select_textobject("@parameter.inner", "textobjects")
					end,
					desc = "Text object: inner parameter",
					mode = { "x", "o" },
				},
				{
					"as",
					function()
						select_textobject("@local.scope", "locals")
					end,
					desc = "Text object: local scope",
					mode = { "x", "o" },
				},
			}
		end,

		opts = {
			select = {
				lookahead = true,
				selection_modes = {
					["@function.outer"] = "V",
					["@class.outer"] = "V",
				},
				include_surrounding_whitespace = true,
			},
		},
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		optional = true,
		opts = {
			separator = "─",
			max_lines = 5,
		},
	},
}
