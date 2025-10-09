vim.api.nvim_create_user_command("Synonymous", function()
	require("synonymous").run()
end, { desc = "Run the Synonymous plugin" })

-- vim.keymap.set("n", "<leader>s", function()
-- 	require("synonymous").select_synonym()
-- end, { desc = "Synonymous: find synonym" })
