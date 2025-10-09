vim.keymap.set("n", "<leader>s", function()
	require("synonymous").select_synonym()
end, { desc = "Synonymous: find synonym" })
