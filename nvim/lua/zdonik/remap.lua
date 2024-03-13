vim.g.mapleader = " "

vim.keymap.set("n", "<esc>", vim.cmd.noh) -- no highlight
vim.keymap.set("t", "<esc>", "<C-\\><C-n>")
vim.keymap.set("c", "<C-n>", "<Nop>")
vim.keymap.set("c", "<C-p>", "<Nop>")
vim.keymap.set("n", "<C-e>", "<C-r>")
vim.keymap.set("n", "<leader>so", ":luafile $MYVIMRC<CR>")

-- common commands
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
vim.keymap.set("n", "<leader>w", vim.cmd.write)
vim.keymap.set("n", "<leader>x", vim.cmd.quit)
vim.keymap.set("n", "<leader>ss", vim.cmd.split)
vim.keymap.set("n", "<leader>sv", vim.cmd.vsplit)
vim.keymap.set("n", "<leader>qq", vim.cmd.cclose)

-- navigation
vim.keymap.set("n", "<C-w>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-w>")

-- window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h")
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l")
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j")
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k")
vim.keymap.set("n", "<leader>r", "<C-w>p", { desc = "go to last window" })

vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("x", "<leader>p", '"_dP')
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')

vim.keymap.set("n", "<leader>f", function()
	vim.api.nvim_del_augroup_by_name("__formatter__")
	print("Formatter disabled till end of session")
end)

vim.keymap.set("n", "<leader>l", vim.cmd.Lazy)

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

vim.keymap.set("n", "<leader>gs", vim.cmd.Floggit)
vim.keymap.set("n", "<leader>gl", vim.cmd.Flog)
vim.keymap.set("n", "<leader>gi", function()
	vim.fn.feedkeys(":Floggit ")
end)

vim.keymap.set("n", "<leader>oo", "<cmd>ObsidianOpen<cr>")
vim.keymap.set("n", "<leader>oq", "<cmd>ObsidianQuickSwitch<cr>")
vim.keymap.set("n", "<leader>od", "<cmd>ObsidianToday<cr>")
vim.keymap.set("n", "<leader>on", "<cmd>ObsidianToday +1<cr>")
vim.keymap.set("n", "<leader>op", "<cmd>ObsidianToday -1<cr>")
vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianTemplate<cr>")
