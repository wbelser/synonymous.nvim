# Synonymous.nvim

Just want a simple plugin to give me choices from a thesaurus to replace the boring word I used.

## Requirements

- Neovim 0.12+ (uses `vim.net.request` for HTTP requests)
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
| `:SynonymousHealthCheck` | Run health checks (Neovim version, internet, Datamuse API) |

## Usage

So - put your cursor on a word (because you were most likely going through a document with `w` or `b` as you were rereading) and then run the command `:Synonymous` or use the keymap `<leader>sy` to launch the word picker. Use arrow keys or start typing and then hit `Enter` to select your new word.