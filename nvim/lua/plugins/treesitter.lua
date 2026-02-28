return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context",
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = function()
			vim.cmd("TSUpdate")
		end,

		keys = function()
			local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
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
			}
		end,

		opts = {
			auto_install = true,
			ensure_installed = { "lua" },
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
				disable = { "csv" },
			},
			indent = { enable = true },
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						["as"] = "@scope.outer",
						["ar"] = "@parameter.outer",
						["ir"] = "@parameter.inner",
					},
					selection_modes = {
						["@function.outer"] = "V",
						["@class.outer"] = "V",
					},
					include_surrounding_whitespace = true,
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]f"] = "@function.outer",
						["]c"] = "@class.outer",
					},
					goto_next_end = {
						["]F"] = "@function.outer",
						["]C"] = "@class.outer",
					},
					goto_previous_start = {
						["[f"] = "@function.outer",
						["[c"] = "@class.outer",
					},
					goto_previous_end = {
						["[F"] = "@function.outer",
						["[C"] = "@class.outer",
					},
				},
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
