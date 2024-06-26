M = {}

function M.all(range, pred)
	for key, val in pairs(range) do
		if not pred(key, val) then
			return false
		end
	end
	return true
end

return M
