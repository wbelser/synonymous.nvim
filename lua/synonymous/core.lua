local M = {}

-- Simple helper: do HTTP GET (using plenary or vim.loop + curl)
local function fetch_synonyms(word)
	-- Example: using Datamuse API
	local url = "https://api.datamuse.com/words?rel_syn=" .. vim.fn.escape(word, " ")
	-- You could use plenary.http if you have it
	local ok, resp = pcall(vim.fn.system, { "curl", "-s", url })
	if not ok then
		return nil, "HTTP request failed: " .. tostring(resp)
	end
	local data = vim.fn.json_decode(resp)
	if not data then
		return nil, "Could not parse JSON from response"
	end

	local synonyms = {}
	for _, item in ipairs(data) do
		if item.word then
			table.insert(synonyms, item.word)
		end
	end
	return synonyms, nil
end

-- Main function: lookup and replace
function M.synonym_replace_at_cursor()
	local word = vim.fn.expand("<cword>")
	if word == nil or word == "" then
		vim.notify("No word under cursor", vim.log.levels.WARN)
		return
	end

	local syns, err = fetch_synonyms(word)
	if err then
		vim.notify("Error fetching synonyms: " .. err, vim.log.levels.ERROR)
		return
	end
	if #syns == 0 then
		vim.notify("No synonyms found for “" .. word .. "”", vim.log.levels.INFO)
		return
	end

	-- Use vim.ui.select to let user choose
	vim.ui.select(syns, {
		prompt = "Synonyms for “" .. word .. "”:",
	}, function(choice)
		if not choice then
			-- user canceled
			return
		end
		-- Replace the word under cursor
		local row, col = unpack(vim.api.nvim_win_get_cursor(0))
		local line = vim.api.nvim_get_current_line()

		-- Find the boundaries of the word under cursor (rough, maybe refine)
		local startcol = col
		local endcol = col
		-- expand to left
		while startcol > 0 and line:sub(startcol, startcol):match("[%w_]") do
			startcol = startcol - 1
		end
		-- expand to right
		while endcol <= #line and line:sub(endcol + 1, endcol + 1):match("[%w_]") do
			endcol = endcol + 1
		end

		-- Replace in the line
		local newline = line:sub(1, startcol) .. choice .. line:sub(endcol + 1)
		vim.api.nvim_set_current_line(newline)
	end)
end

return M
