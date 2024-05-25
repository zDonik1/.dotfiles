vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.colorcolumn = "101"
vim.opt.rnu = true
vim.opt.nu = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.linebreak = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.smartindent = true
vim.opt.showmode = false

if vim.fn.has("win32") then
	vim.opt.shell = "cmd.exe"
else
	vim.opt.shell = "nu"
	vim.opt.shellcmdflag =
		'"--config ($env.XDG_CONFIG_HOME | path join nushell/nvim.nu)" --stdin -c'
	vim.opt.shellredir = "o+e> %s"
	vim.opt.shellpipe = "o+e>| tee { save %s }"
	vim.opt.shellslash = true
	vim.opt.shellquote = "'"
	vim.opt.shellxquote = ""
end

if os.getenv("XDG_DATA_HOME") then
	vim.opt.directory = os.getenv("XDG_DATA_HOME") .. "/nvim-data/swap"
end
