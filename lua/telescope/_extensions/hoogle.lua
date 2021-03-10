local has_telescope, telescope = pcall(require, "telescope")
if not has_telescope then
  error("This plugin requires nvim-telescope/telescope.nvim")
end

local hoogle = require 'telescope._extensions.hoogle.live_hoogle_search'

return telescope.register_extension {
  exports = { hoogle = hoogle }
}

