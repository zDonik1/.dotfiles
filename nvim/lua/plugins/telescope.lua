local add_hidden_flags = function(command)
	table.insert(command, "--hidden")
	table.insert(command, "--glob")
	table.insert(command, "!**/.git/*")
	table.insert(command, "--glob")
	table.insert(command, "!**/.jj/*")
	table.insert(command, "--glob")
	table.insert(command, "!**/.devenv*/*")
	return command
end

local search_command = add_hidden_flags({ "rg", "--files" })

local project_files = function()
	local command = vim.deepcopy(search_command)
	table.insert(command, "--ignore-file")
	table.insert(command, ".gitignore")
	require("telescope.builtin").find_files({ find_command = command })
end

return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build",
		},
	},
	opts = function()
		local vimgrep_arguments = { unpack(require("telescope.config").values.vimgrep_arguments) }

		return {
			defaults = {
				vimgrep_arguments = add_hidden_flags(vimgrep_arguments),
				mappings = {
					i = {
						["<C-x>"] = function(prompt_bufnr)
							require("telescope.actions.set").edit(prompt_bufnr, "rightbelow new")
						end,
						["<C-v>"] = function(prompt_bufnr)
							require("telescope.actions.set").edit(prompt_bufnr, "rightbelow vnew")
						end,
					},
				},
			},
			pickers = {
				find_files = {
					find_command = search_command,
				},
			},
		}
	end,
	config = function(_, opts)
		require("telescope").setup(opts)
		require("telescope").load_extension("fzf")

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>kf", function()
			builtin.find_files({ hidden = true, no_ignore = true })
		end, { desc = "Open files" })
		vim.keymap.set(
			"n",
			"<leader>kp",
			project_files,
			{ desc = "Open project files (git or all)" }
		)
		vim.keymap.set("n", "<leader>kc", function()
			builtin.find_files({ cwd = vim.fn.expand("%:p:h") })
		end, { desc = "Open files in current directory" })
		vim.keymap.set("n", "<leader>ko", builtin.oldfiles, {})
		vim.keymap.set("n", "<leader>kg", builtin.git_files, {})
		vim.keymap.set("n", "<leader>kr", builtin.resume, {})
		vim.keymap.set("n", "<leader>kw", builtin.live_grep, {})
		vim.keymap.set("n", "<leader>kb", builtin.buffers, {})
		vim.keymap.set("n", "<leader>kh", builtin.help_tags, {})
		vim.keymap.set("n", "<leader>km", builtin.keymaps, {})
	end,
}
