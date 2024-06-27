M = {}

function M.scratch()
	vim.ui.input({ prompt = "Enter command", completion = "command" }, function(input)
		if input == nil then
			return
		elseif input == "scratch" then
			input = "echo('')"
		end
		local cmd = vim.api.nvim_exec2(input, { output = true })
		local output = {}
		for line in cmd.output:gmatch("[^\n]+") do
			table.insert(output, line)
		end
		local buf = vim.api.nvim_create_buf(true, true)
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)
		vim.api.nvim_win_set_buf(0, buf)
	end)
end

return M
