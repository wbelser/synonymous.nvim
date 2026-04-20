# Synonymous.nvim

A Neovim plugin that provides synonym and antonym suggestions via the Datamuse API. Place your cursor on a word and invoke the plugin to get a list of synonyms or antonyms to replace it with.

---

## Installation

### lazy.nvim

```lua
return {
	"wbelser/synonymous.nvim",
	ft = { "markdown", "text", "tex", "html", "typst" },
	config = function()
		require("synonymous").setup()
	end,
	keys = {
		{
			"<leader>sy",
			function()
				require("synonymous").select_synonym()
			end,
			desc = "Find and replace with synonym",
			mode = { "n", "v" },
		},
		{
			"<leader>an",
			function()
				require("synonymous").select_antonym()
			end,
			desc = "Find and replace with antonym",
			mode = { "n", "v" },
		},
	},
}
```

### vim.pack.add({})

```lua
vim.pack.add({ start = "path/to/synonymous.nvim" })
```

Then call setup in your init.lua:

```lua
require("synonymous").setup()
```

---

## Setup Function

The setup function accepts an options table to customize the plugin's behavior:

```lua
require("synonymous").setup({
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
})
```

### Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `ft` | `table<string>` | `{ "markdown", "text", "tex", "html", "typst" }` | List of filetypes to load the plugin for |
| `keys` | `table<table>` | `{{ lhs = "<leader>sy", ... }, { lhs = "<leader>an", ... }` | List of keymaps to register (synonym and antonym) |

### Usage Examples

**Default configuration:**

```lua
require("synonymous").setup()
```

**Custom filetypes:**

```lua
require("synonymous").setup({
	ft = { "python", "lua" },
})
```

**Custom keymaps:**

```lua
require("synonymous").setup({
	keys = {
		{
			lhs = "<leader>ss",
			rhs = function()
				require("synonymous").select_synonym()
			end,
			desc = "Find and replace with synonym",
			mode = { "n", "v" },
		},
	},
})
```

---

## Health Check

Run the built-in Neovim health check:

```vim
:checkhealth synonymous
```

Or from Lua:

```lua
lua require("synonymous.health").check()
```

This checks:
- Internet connectivity
- `curl` command availability
- Datamuse API reachability

---

## Usage

**Synonyms:**
1. Place your cursor on the word you want to replace
2. Run either:
   - Command: `:Synonymous`
   - Keymap: `<leader>sy` (in normal or visual mode)
3. Use arrow keys or type to filter, press `Enter` to select a synonym

**Antonyms:**
1. Place your cursor on the word you want to replace
2. Run either:
   - Command: `:Antonymous`
   - Keymap: `<leader>an` (in normal or visual mode)
3. Use arrow keys or type to filter, press `Enter` to select an antonym