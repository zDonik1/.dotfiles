vim.g.mapleader = " "

vim.keymap.set("n", "<esc>", vim.cmd.noh) -- no highlight
vim.keymap.set("t", "<esc>", "<C-\\><C-n>")
vim.keymap.set("c", "<C-n>", "<Nop>")
vim.keymap.set("c", "<C-p>", "<Nop>")
vim.keymap.set("n", "<C-y>", "<C-r>")
vim.keymap.set("n", "<leader>so", ":luafile $MYVIMRC<CR>")

-- common commands
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
vim.keymap.set("n", "<leader>w", vim.cmd.write)
vim.keymap.set("n", "<leader>x", vim.cmd.quit)
vim.keymap.set("n", "<leader>qq", vim.cmd.quitall)
vim.keymap.set("n", "<leader>ss", vim.cmd.split)
vim.keymap.set("n", "<leader>sv", vim.cmd.vsplit)
vim.keymap.set("n", "<leader>ql", vim.cmd.cclose)
vim.keymap.set("n", "<leader>c", function()
	vim.fn.feedkeys("gc")
end)
vim.keymap.set("n", "<leader>.", "@@", { desc = "Repeat last macro" })

-- navigation
vim.keymap.set({ "n", "v" }, "<C-s>", "<C-u>zz")
vim.keymap.set({ "n", "v" }, "<C-t>", "<C-d>zz")

-- window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h")
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l")
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j")
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k")
vim.keymap.set("n", "<leader>r", function()
	local win = vim.api.nvim_get_current_win()
	vim.cmd.wincmd("p")
	if win == vim.api.nvim_get_current_win() then
		vim.cmd.wincmd("w")
	end
end, { desc = "go to last window" })

vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "*", "*zzzv")
vim.keymap.set("n", "#", "#zzzv")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("x", "<leader>p", '"_dP')
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')

vim.keymap.set("n", "<leader>jf", function()
	vim.api.nvim_del_augroup_by_name("__formatter__")
	print("Formatter disabled till end of session")
end)
vim.keymap.set("n", "<leader>jl", function()
	vim.cmd.LspStop()
end)

vim.keymap.set("n", "<leader>sc", require("util").scratch, { desc = "Command to scratch buffer" })

-- plugin keymaps
vim.keymap.set("n", "<leader>l", vim.cmd.Lazy)

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

vim.keymap.set("n", "-", "<cmd>Oil --float<cr>", { desc = "Open parent directory" })
