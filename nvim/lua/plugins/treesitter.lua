return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-context",
		"nvim-treesitter/nvim-treesitter-textobjects",
		"lewis6991/gitsigns.nvim",
		"nushell/tree-sitter-nu",
		"IndianBoy42/tree-sitter-just",
	},
	build = function()
		vim.cmd("TSUpdate")
	end,
	opts = {
		auto_install = true,
		ensure_installed = { "lua" },
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
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
					["]m"] = "@function.outer",
					["]]"] = "@class.outer",
				},
				goto_next_end = {
					["]M"] = "@function.outer",
					["]["] = "@class.outer",
				},
				goto_previous_start = {
					["[m"] = "@function.outer",
					["[["] = "@class.outer",
				},
				goto_previous_end = {
					["[M"] = "@function.outer",
					["[]"] = "@class.outer",
				},
			},
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
		require("treesitter-context").setup({ separator = "─", max_lines = 5 })
		require("tree-sitter-just").setup({})

		local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
		vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
		vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
		vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
		vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
		vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
		vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)

		local gs = require("gitsigns")
		local next_hunk_repeat, prev_hunk_repeat =
			ts_repeat_move.make_repeatable_move_pair(gs.next_hunk, gs.prev_hunk)
		vim.keymap.set({ "n", "x", "o" }, "]h", next_hunk_repeat)
		vim.keymap.set({ "n", "x", "o" }, "[h", prev_hunk_repeat)
	end,
}
