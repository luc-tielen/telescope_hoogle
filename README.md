
# telescope_hoogle

A telescope plugin for Hoogle.

## Installation

1. Make sure a recent Hoogle is installed
2. Run `hoogle generate`
3. Install this plugin
4. Add the following Lua snippet to your code:

```lua
require('telescope.hoogle').setup {}
```

```viml
lua require('telescope.hoogle').setup {}
```

## Development

```bash
nvim --cmd "set rtp+=$(pwd)"
```
