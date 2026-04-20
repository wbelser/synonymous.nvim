local core = require("synonymous.core")

local M = {}

M.opts = nil

local defaults = {
	ft = { "markdown", "text", "tex", "html", "typst" },
	keys = {
		{
			lhs = "<leader>sy",
			rhs = function()
				require("synonymous").select_synonym()
			end,
			desc = "Find and replace with synonym",
			mode = { "n", "v" },
		},
		{
			lhs = "<leader>an",
			rhs = function()
				require("synonymous").select_antonym()
			end,
			desc = "Find and replace with antonym",
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

function M.select_antonym()
	core.select_antonym()
end

return M
