
# telescope_hoogle

A telescope plugin for Hoogle.

## Installation

1. Install [Telescope](https://github.com/nvim-telescope/telescope.nvim)
1. Install a recent Hoogle (needs to support `--json` flag)
2. Run `hoogle generate`
3. Install this plugin (`paq 'luc-tielen/telescope_hoogle'`)
4. Add the following Lua snippet to your nvim config:

```lua
local telescope = require('telescope')
telescope.setup {
  -- opts...
}
telescope.load_extension('hoogle')
```

By default, `<cr>` selects the currently selected type signature. `<c-b>` opens
Hoogle in the browser (with the current selection).

## Development

```bash
nvim --cmd "set rtp+=$(pwd)"
```
