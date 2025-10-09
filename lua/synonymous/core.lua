local M = {}

function M.select_synonym()
	local word = vim.fn.expand("<cword>")
	if not word or word == "" then
		vim.notify("No word under cursor.", vim.log.levels.WARN)
		return
	end

	-- Example: call an API or a local dictionary
	local handle = io.popen("curl -s 'https://api.datamuse.com/words?rel_syn=" .. word .. "'")
	local result = handle:read("*a")
	handle:close()

	local ok, data = pcall(vim.json.decode, result)
	if not ok or not data or #data == 0 then
		vim.notify("No synonyms found for '" .. word .. "'", vim.log.levels.INFO)
		return
	end

	local choices = {}
	for _, item in ipairs(data) do
		table.insert(choices, item.word)
	end

	vim.ui.select(choices, { prompt = "Replace '" .. word .. "' with:" }, function(choice)
		if choice then
			vim.cmd("normal! ciw" .. choice)
		end
	end)
end

return M
