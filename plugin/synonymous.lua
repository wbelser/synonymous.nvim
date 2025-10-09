vim.api.nvim_create_user_command("Synonymous", function()
	require("synonymous").select_synonym()
end, {})
