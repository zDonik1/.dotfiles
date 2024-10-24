local function round(n, places)
	local rounder = 10 ^ places
	return math.floor(n * rounder + 0.5) / rounder
end

local function comma_format(amount)
	local formatted = amount
	while true do
		local k
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", "%1,%2")
		if k == 0 then
			break
		end
	end
	return formatted
end

local function format_num(amount, decimal, prefix, neg_prefix)
	decimal = decimal or 2 -- default 2 decimal places
	neg_prefix = neg_prefix or "-" -- default negative sign

	local famount = math.abs(round(amount, decimal))
	famount = math.floor(famount)

	local remain = round(math.abs(amount) - famount, decimal)

	-- comma to separate the thousands
	local formatted = comma_format(famount)

	-- attach the decimal portion
	if decimal > 0 then
		remain = string.sub(tostring(remain), 3)
		formatted = formatted .. "." .. remain .. string.rep("0", decimal - string.len(remain))
	end

	-- attach prefix string e.g '$'
	formatted = (prefix or "") .. formatted

	-- if value is negative then format accordingly
	if amount < 0 then
		if neg_prefix == "()" then
			formatted = "(" .. formatted .. ")"
		else
			formatted = neg_prefix .. formatted
		end
	end

	return formatted
end

vim.api.nvim_create_user_command("Exchange", function(opts)
	local line = vim.api.nvim_get_current_line()
	local _, _, uzs_val = string.find(line, "UZS (-?[%d%.,]+)")
	local rate = opts.fargs[1]
	uzs_val = string.gsub(uzs_val, ",", "")
	uzs_val = tonumber(uzs_val)
	local usd_val = round(uzs_val / rate, 2)
	local result = string.format(
		"%s @ %s",
		format_num(usd_val, 2, "$"),
		format_num(uzs_val / usd_val, 5, "UZS ")
	)
	line = string.gsub(line, "UZS (-?[%d%.,]+)", result, 1)
	vim.api.nvim_set_current_line(line)
end, { desc = "Convert to USD in place with given rate and amount.", nargs = "+" })
