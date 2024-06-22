local function setup_keymaps()
	local dap = require("dap")
	local dapui = require("dapui")

	vim.keymap.set("n", "<leader>ts", dap.continue, { desc = "Debug: Start/Continue" })
	vim.keymap.set("n", "<leader>tp", dap.terminate, { desc = "Debug: Stop" })
	vim.keymap.set("n", "<C-i>", dap.step_into, { desc = "Debug: Step Into" })
	vim.keymap.set("n", "<C-e>", dap.step_over, { desc = "Debug: Step Over" })
	vim.keymap.set("n", "<C-a>", dap.step_out, { desc = "Debug: Step Out" })
	vim.keymap.set("n", "<leader>tb", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
	vim.keymap.set("n", "<leader>tB", function()
		dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
	end, { desc = "Debug: Set Breakpoint" })

	-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
	vim.keymap.set("n", "<leader>tu", dapui.toggle, { desc = "Debug: See last session result." })
end

local function setup_dap_python()
	local dap_python = require("dap-python")
	dap_python.setup("python")
	vim.keymap.set("n", "<leader>tf", dap_python.test_method)
	vim.keymap.set("n", "<leader>tc", dap_python.test_class)
	vim.keymap.set("v", "<leader>tv<esc>", dap_python.debug_selection)
end

return {
	"mfussenegger/nvim-dap",
	keys = { "<leader>ts", "<leader>tb" },
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
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		dapui.setup()
		setup_dap_python()
	end,
}
