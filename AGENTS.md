# Agents.md

## Overview

**synonymous.nvim** is a Neovim plugin that provides synonym suggestions via the Datamuse API. Place your cursor on a word and invoke the plugin to get a list of synonyms to replace it with.

---

## Loading the Plugin

### lazy.nvim

```lua
return {
	"wbelser/synonymous.nvim",
	ft = { "markdown", "text", "tex", "html" },
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

```lua
require("synonymous").setup({})
```

The setup function currently accepts no options but is required to initialize the plugin.

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

1. Place your cursor on the word you want to replace
2. Run either:
   - Command: `:Synonymous`
   - Keymap: `<leader>sy` (in normal or visual mode)
3. Use arrow keys or type to filter, press `Enter` to select a synonym