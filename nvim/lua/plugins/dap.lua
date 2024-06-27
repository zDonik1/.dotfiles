local function get_win_for_buf(buf)
	local wins = vim.api.nvim_tabpage_list_wins(0)
	for _, win in ipairs(wins) do
		if vim.api.nvim_win_get_buf(win) == buf then
			return win
		end
	end
	return -1
end

local last_win = 0

local function setup_keymaps()
	local dap = require("dap")
	local dapui = require("dapui")
	local lib = require("lib")

	local elements = { "watches", "stacks", "breakpoints", "scopes", "console", "repl" }

	local function make_focus_map(map, elem)
		vim.keymap.set("n", map, function()
			local cur_buf = vim.api.nvim_get_current_buf()
			if
				lib.all(elements, function(_, e)
					return cur_buf ~= dapui.elements[e].buffer()
				end)
			then
				last_win = vim.api.nvim_get_current_win()
			end

			local win = get_win_for_buf(dapui.elements[elem].buffer())
			if win ~= -1 then
				vim.api.nvim_set_current_win(win)
			end
		end, { desc = "Debug: Focus " .. elem .. " window." })
	end

	vim.keymap.set("n", "<leader>ts", dap.continue, { desc = "Debug: Start/Continue" })
	vim.keymap.set("n", "<leader>tr", dap.run_last, { desc = "Debug: Run last" })
	vim.keymap.set("n", "<leader>tx", dap.terminate, { desc = "Debug: Stop" })
	vim.keymap.set("n", "<C-i>", dap.step_into, { desc = "Debug: Step Into" })
	vim.keymap.set("n", "<C-e>", dap.step_over, { desc = "Debug: Step Over" })
	vim.keymap.set("n", "<C-a>", dap.step_out, { desc = "Debug: Step Out" })
	vim.keymap.set("n", "<leader>tb", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
	vim.keymap.set("n", "<leader>tB", function()
		dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
	end, { desc = "Debug: Set Breakpoint" })

	vim.keymap.set("n", "<leader>tu", dapui.toggle, { desc = "Debug: Toggle debug session" })
	vim.keymap.set("n", "<leader>to", function()
		dapui.toggle({ reset = true })
	end, { desc = "Debug: Toggle debug session with default layout" })

	make_focus_map("<leader>tc", "watches")
	make_focus_map("<leader>ti", "stacks")
	make_focus_map("<leader>te", "breakpoints")
	make_focus_map("<leader>ta", "scopes")
	make_focus_map("<leader>tj", "console")
	make_focus_map("<leader>tk", "repl")

	vim.keymap.set("n", "<leader>tg", function()
		vim.api.nvim_set_current_win(last_win)
	end, { desc = "Debug: Focus last edit window" })
end

local function setup_dap_python()
	local dap_python = require("dap-python")
	dap_python.setup("python")
	vim.keymap.set("n", "<leader>tf", dap_python.test_method, { desc = "Debug: Debug current method"})
	vim.keymap.set("n", "<leader>tp", dap_python.test_class, { desc = "Debug: Debug current class"})
	vim.keymap.set("v", "<leader>tv<esc>", dap_python.debug_selection, { desc = "Debug: Debug selection"})
end

local dapui_opts = {
	layouts = {
		{
			elements = {
				{
					id = "scopes",
					size = 0.25,
				},
				{
					id = "breakpoints",
					size = 0.25,
				},
				{
					id = "stacks",
					size = 0.25,
				},
				{
					id = "watches",
					size = 0.25,
				},
			},
			position = "left",
			size = 40,
		},
		{
			elements = {
				{
					id = "repl",
					size = 0.25,
				},
				{
					id = "console",
					size = 0.75,
				},
			},
			position = "bottom",
			size = 15,
		},
	},
}

return {
	"mfussenegger/nvim-dap",
	keys = { "<leader>ts", "<leader>tb", "<leader>tu", "<leader>to" },
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio", -- Required dependency for nvim-dap-ui
		"mfussenegger/nvim-dap-python",
	},
	config = function()
		setup_keymaps()

		local dap = require("dap")
		local dapui = require("dapui")

		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		-- dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		-- dap.listeners.before.event_exited["dapui_config"] = dapui.close

		dapui.setup(dapui_opts)
		setup_dap_python()
	end,
}
