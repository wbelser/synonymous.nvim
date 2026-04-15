vim.api.nvim_create_user_command("Synonymous", function()
	require("synonymous").select_synonym()
end, { desc = "show word under cursor" })

vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		local syn = require("synonymous")
		if not syn.opts then
			syn.setup()
		end

		if not vim.tbl_contains(syn.opts.ft, args.match) then
			return
		end

		for _, keymap in ipairs(syn.opts.keys) do
			local mode = keymap.mode or "n"
			local lhs = keymap.lhs
			local rhs = keymap.rhs
			local opts = vim.tbl_extend("keep", {
				buffer = args.buf,
				desc = keymap.desc,
			}, keymap)
			opts.lhs = nil
			opts.rhs = nil
			opts.mode = nil
			opts.desc = nil
			vim.keymap.set(mode, lhs, rhs, opts)
		end
	end,
})
