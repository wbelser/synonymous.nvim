local core = require("synonymous.core")

local M = {}

M.opts = nil

local defaults = {
	ft = { "markdown", "text", "tex", "html" },
	keys = {
		{
			lhs = "<leader>sy",
			rhs = function()
				require("synonymous").select_synonym()
			end,
			desc = "Find and replace with synonym",
			mode = { "n", "v" },
		},
	},
}

function M.setup(opts)
	M.opts = vim.tbl_deep_extend("force", defaults, opts or {})
end

function M.select_synonym()
	core.select_synonym()
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
