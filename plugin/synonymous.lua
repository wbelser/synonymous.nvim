vim.api.nvim_create_user_command("Synonymous", function()
	require("synonymous").select_synonym()
end, { desc = "show word under cursor" })

-- vim.keymap.set("n", "<leader>s", function()
-- 	require("synonymous").select_synonym()
-- end, { desc = "Synonymous: find synonym" })
