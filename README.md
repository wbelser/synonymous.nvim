# synonymous.nvim

Just want a simple plugin to give me choices from a thesaurus to replace the boring word I used.

# Lazy.nvim

```lua
return {
    {
      "wbelser/synonymous.nvim",
      config = function()
        -- Optional: set up any user options later
        require("synonymous").setup({})
      end,
      keys = {
        {
          "<leader>s",
          function() require("synonymous").select_synonym() end,
          desc = "Find and replace with synonym",
          mode = { "n", "v" },
        },
      },
      ft = { "markdown", "text", "tex", "html" }, -- optional, load only for writing
    }
}
```
