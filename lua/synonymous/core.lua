local M = {}

-- simple test command to make sure it runs
function M.select_synonym()
	local word = vim.fn.expand("<cword>")

	if word == nil or word == "" then
		vim.notify("no word to look up", vim.log.levels.WARN)
		return
	end

	-- Fetch synonyms from Datamuse using vim.net.request (Neovim 0.12+)
	local url = "https://api.datamuse.com/words?rel_syn=" .. word
	local res = vim.net.request(url)

	if not res then
		vim.notify("Failed to fetch synonyms for '" .. word .. "'", vim.log.levels.ERROR)
		return
	end

	if res.status and res.status ~= 200 then
		vim.notify("Datamuse API returned HTTP " .. res.status, vim.log.levels.ERROR)
		return
	end

	local ok, data = pcall(vim.json.decode, res.body)
	if not ok or not data or #data == 0 then
		vim.notify("No synonyms found for '" .. word .. "'", vim.log.levels.INFO)
		return
	end

	-- Extract just the words
	local choices = {}
	for _, item in ipairs(data) do
		table.insert(choices, item.word)
	end

	vim.ui.select(choices, { prompt = "Synonyms for '" .. word .. "':" }, function(choice)
		if not choice then
			vim.notify("No synonym selected", vim.log.levels.INFO)
			return
		end

		-- Replace the word under cursor
		local cursor = vim.api.nvim_win_get_cursor(0)
		local row, col = cursor[1], cursor[2]

		-- Move cursor to the start of the word
		vim.cmd("normal! viw")
		vim.cmd("normal! c" .. choice)

		-- Restore cursor near replaced word
		vim.api.nvim_win_set_cursor(0, { row, col })

		vim.notify(string.format("Replaced '%s' with '%s'", word, choice))
	end)
end

-- function M.select_synonym()
-- 	local word = vim.fn.expand("<cword>")
-- 	if not word or word == "" then
-- 		vim.notify("No word under cursor.", vim.log.levels.WARN)
-- 		return
-- 	end
--
-- 	-- Example: call an API or a local dictionary
-- 	local handle = io.popen("curl -s 'https://api.datamuse.com/words?rel_syn=" .. word .. "'")
-- 	local result = handle:read("*a")
-- 	handle:close()
--
-- 	local ok, data = pcall(vim.json.decode, result)
-- 	if not ok or not data or #data == 0 then
-- 		vim.notify("No synonyms found for '" .. word .. "'", vim.log.levels.INFO)
-- 		return
-- 	end
--
-- 	local choices = {}
-- 	for _, item in ipairs(data) do
-- 		table.insert(choices, item.word)
-- 	end
--
-- 	vim.ui.select(choices, { prompt = "Replace '" .. word .. "' with:" }, function(choice)
-- 		if choice then
-- 			vim.cmd("normal! ciw" .. choice)
-- 		end
-- 	end)
-- end

return M
