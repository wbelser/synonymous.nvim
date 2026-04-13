# Agents.md

## Overview

synonymous.nvim is a Neovim plugin that provides thesaurus functionality. It fetches synonyms for the word under the cursor using the Datamuse API and allows you to replace the word with a chosen synonym via a selection menu.

The plugin uses `vim.ui.select` to display available synonyms and replaces the word under the cursor with the selected option. It is designed for writing in markdown, plain text, LaTeX, and HTML files.

## Requirements

- Neovim 0.9+ (uses `vim.ui.select` and health API)
- `curl` command available in PATH
- Internet connection (to query the Datamuse API)

## Installation

### Lazy.nvim

```lua
return {
  {
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
  },
}
```

### vim.pack.add()

Clone the repository to your pack directory:

```bash
git clone https://github.com/wbelser/synonymous.nvim.git ~/.local/share/nvim/site/pack/vendor/start/synonymous.nvim
```

Then add to your `init.lua`:

```lua
require("synonymous").setup()
```

### setup({}) Parameters

The plugin currently accepts no configuration options. The `setup()` function exists for future extensibility.

```lua
-- Currently accepts no options
require("synonymous").setup()
```

## Commands

| Command | Description |
|---------|-------------|
| `:Synonymous` | Fetch and replace synonym for word under cursor |
| `:SynonymousHealthCheck` | Run health checks (internet, curl, Datamuse API) |

## Keymaps

| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>sy` | Normal | Find and replace with synonym |
| `<leader>sy` | Visual | Find and replace with synonym |

## Usage

1. Place your cursor on a word you want to replace
2. Run `:Synonymous` or press `<leader>sy`
3. Select a synonym from the menu using arrow keys
4. Press `Enter` to replace the word

The plugin will notify you of successful replacement via `vim.notify`.