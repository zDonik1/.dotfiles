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

vim.opt.shell = "nu"
vim.opt.shellcmdflag = "--stdin -c"
vim.opt.shellredir = "o+e> %s"
vim.opt.shellpipe = "o+e>| tee { save %s }"
vim.opt.shellquote = "'"
vim.opt.shellxquote = ""
if string.find(vim.uv.os_uname().sysname, "Windows") then
	vim.opt.shellslash = true
end

if os.getenv("XDG_DATA_HOME") then
	vim.opt.directory = os.getenv("XDG_DATA_HOME") .. "/nvim-data/swap"
end
