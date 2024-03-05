-- saves the current directory in Windows Terminal session
local save_cur_dir = clink.promptfilter(-100) -- Negative number so it runs early.
function save_cur_dir:filter(_) end
function save_cur_dir:surround()
	local prompt_prefix = "$e]9;9;$P$e\\"
	return prompt_prefix
end

-- initalizing starship
os.setenv("STARSHIP_CONFIG", "C:\\Users\\dtokhirov\\.config\\winterm-cmd-config\\starship.toml")

load(io.popen("starship init cmd"):read("*a"))()
