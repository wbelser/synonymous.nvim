local core = require("synonymous.core")

local M = {}

function M.select_synonym()
	core.select_synonym()
end

function M.setup(opts)
	-- optional setup for config later
	M.opts = opts or {}
end

return M
