local M = {}

-- simple test command to make sure it runs
function M.select_synonym()
	local word = vim.fn.expand("<cword>")

	if word == nil or word == "" then
		vim.notify("no word to look up", vim.log.levels.WARN)
		return
	end

	local cmd = string.format("curl -s 'https://api.datamuse.com/words?rel_syn=%s'", word)
	local handle = io.popen(cmd)
	if not handle then
		vim.notify("Failed to run curl command", vim.log.levels.ERROR)
		return
	end

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

	vim.ui.select(choices, { prompt = "Synonyms for '" .. word .. "':" }, function(choice)
		if not choice then
			vim.notify("No synonym selected", vim.log.levels.INFO)
			return
		end

		local cursor = vim.api.nvim_win_get_cursor(0)
		local row, col = cursor[1], cursor[2]

		vim.cmd("normal! viw")
		vim.cmd("normal! c" .. choice)

		vim.api.nvim_win_set_cursor(0, { row, col })

		vim.notify(string.format("Replaced '%s' with '%s'", word, choice))
	end)
end

function M.select_antonym()
	local word = vim.fn.expand("<cword>")

	if word == nil or word == "" then
		vim.notify("no word to look up", vim.log.levels.WARN)
		return
	end

	local cmd = string.format("curl -s 'https://api.datamuse.com/words?rel_ant=%s'", word)
	local handle = io.popen(cmd)
	if not handle then
		vim.notify("Failed to run curl command", vim.log.levels.ERROR)
		return
	end

	local result = handle:read("*a")
	handle:close()

	local ok, data = pcall(vim.json.decode, result)
	if not ok or not data or #data == 0 then
		vim.notify("No antonyms found for '" .. word .. "'", vim.log.levels.INFO)
		return
	end

	local choices = {}
	for _, item in ipairs(data) do
		table.insert(choices, item.word)
	end

	vim.ui.select(choices, { prompt = "Antonyms for '" .. word .. "':" }, function(choice)
		if not choice then
			vim.notify("No antonym selected", vim.log.levels.INFO)
			return
		end

		local cursor = vim.api.nvim_win_get_cursor(0)
		local row, col = cursor[1], cursor[2]

		vim.cmd("normal! viw")
		vim.cmd("normal! c" .. choice)

		vim.api.nvim_win_set_cursor(0, { row, col })

		vim.notify(string.format("Replaced '%s' with '%s'", word, choice))
	end)
end

return M
