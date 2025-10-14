# synonymous.nvim

Just want a simple plugin to give me choices from a thesaurus to replace the boring word I used.

# Lazy.nvim

Here is what you need as a file in your
Lazy.nvim plugins folder. You can create the
file `synonymous.lau` and have this in it.
It will only load the plugin when you are in
files that you are _writing_ (markdown, plain test,
LaTeX, and hypertext markup language). It also
maps `Leader + s y` as the keymap and you can
surely change that.

```lua
return {
	{
		"wbelser/synonymous.nvim",
		ft = { "markdown", "text", "tex", "html" }, -- optional, load only for writing
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

# Usage

So - put your cursor on a word (because you were most likely
going through a document with `w` or `b` as you were
rereading) and then run the command `:Synonomyus` or use the
keymap `Leader + s y` to launch the word picker. Use
arrow keys or start typing and then hit `Enter` to select
your new word.
