
# telescope_hoogle

A telescope plugin for Hoogle.

## Keybindings

- `<C-b>`: opens selected entry in the browser:

![](./hoogle_browser.gif)

- `<cr>`: copies selected entry to clipboard:

![](./hoogle_paste.gif)

## Installation

1. Install [Telescope](https://github.com/nvim-telescope/telescope.nvim)
2. Install a recent Hoogle (needs to support `--json` flag)
3. Run `hoogle generate`
4. Install this plugin (for example: `paq 'luc-tielen/telescope_hoogle'`)
5. Add the following Lua snippet to your nvim config:

```lua
local telescope = require('telescope')
telescope.setup {
  -- opts...
}
telescope.load_extension('hoogle')
```

## Usage

```lua
-- Use telescope_hoogle with custom settings:
require('telescope').extensions.hoogle.hoogle({

    browser_cmd = "firefox -P search", -- leave empty for defaults.
    count = 50 -- leave empty for defaults.

    })
```

You can create a keybind for easy access:
```lua
-- lua
vim.api.nvim_set_keymap('n', '<leader>ho', '<cmd>lua require("telescope").extensions.hoogle.hoogle({browser_cmd="firefox -P search"})<cr>')
```
```vimscript
-- vimscript
nnoremap <leader>ho <cmd>lua require("telescope").extensions.hoogle.hoogle({browser_cmd="firefox -P search"})<cr>
```

## Development

```bash
$ git clone git@github.com:luc-tielen/telescope_hoogle.git
$ cd telescope_hoogle
$ nvim --cmd "set rtp+=$(pwd)"
```
