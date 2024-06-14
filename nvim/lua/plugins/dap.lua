return {
	"mfussenegger/nvim-dap",
	keys = { "<F5>", "<leader>b" },
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio", -- Required dependency for nvim-dap-ui
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		require("mason-nvim-dap").setup({
			automatic_installation = true,

			-- You can provide additional configuration to the handlers,
			-- see mason-nvim-dap README for more information
			handlers = {},
		})

		vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
		vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
		vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
		vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })
		vim.keymap.set(
			"n",
			"<leader>b",
			dap.toggle_breakpoint,
			{ desc = "Debug: Toggle Breakpoint" }
		)
		vim.keymap.set("n", "<leader>B", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, { desc = "Debug: Set Breakpoint" })

		-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
		vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug: See last session result." })

		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		dap.adapters.cppdbg = {
			type = "executable",
			command = os.getenv("HOME")
				.. "/.vscode/extensions/ms-vscode.cpptools-1.20.5-win32-x64/debugAdapters/vsdbg/bin/vsdbg",
		}
		dap.configurations.cpp = {
			{
				type = "cppdbg",
				request = "launch",
				name = "Launch Project",
				program = "${workspaceFolder}/bin/godot.windows.editor.dev.x86_64.exe",

				args = { "--editor", "--path", "D:/godot/TestLsp" },
				-- stopAtEntry = false,
				cwd = "${workspaceFolder}",
				console = "externalTerminal",
				visualizerFile = "${workspaceFolder}/platform/windows/godot.natvis",
				-- preLaunchTask = "build",
			},
		}
		dap.defaults.fallback.external_terminal = {
			command = "wezterm",
		}
		dap.defaults.fallback.force_external_terminal = true
		-- require("dap.ext.vscode").load_launchjs(nil, { cppdbg = { "c", "cpp" } })
	end,
}
