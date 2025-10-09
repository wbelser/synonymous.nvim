local core = require("synonymous.core")

local M = {}

function M.setup()
	-- Later we can accept options here
end

function M.run()
	core.run()
end

-- function M.select_synonym()
-- 	core.select_synonym()
-- end
--
-- function M.setup(opts)
-- 	-- optional setup for config later
-- 	M.opts = opts or {}
-- end

return M
