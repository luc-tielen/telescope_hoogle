local neorocks = require 'plenary.neorocks'
local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local actions = require 'telescope.actions'
local previewers = require 'telescope.previewers'
local json = require 'telescope.hoogle.json'

local function prompt_to_hoogle_cmd(prompt)
  if not prompt or prompt == '' then
    return nil
  end

  -- TODO results showing up twice when typing quickly?
  return vim.tbl_flatten {'hoogle_search.sh', prompt}
end

local function show_preview(entry, buf)
  local lines = vim.split(entry.docs, '\n')
  vim.api.nvim_buf_set_lines(buf, 0, -1, true, lines)
end

local function entry_maker(data)
  local json = json.parse(data)
  local line = json.module.name .. ' ' .. json.item
  return {
    valid = true,
    value = line,
    ordinal = line,
    display = line,
    docs = json.docs,
    preview_command = show_preview
  }
end

local function setup(opts)
  if neorocks.ensure_installed('lua-cjson') then
    neorocks.install('lua-cjson')
    return
  end
  if vim.fn.executable('hoogle') == '1' then
    vim.api.nvim_err_writeln("telescope.hoogle: 'hoogle' command not found! Aborting.")
    return
  end

  local finder = finders.new_job(prompt_to_hoogle_cmd, entry_maker)

  opts = opts or {}
  pickers.new(opts, {
    prompt_title = 'Live Hoogle search',
    finder = finder,
    previewer = previewers.display_content.new(opts),
    attach_mappings = function(_, map)
      -- TODO mappings
      -- map('i', '<CR>', actions.close)
      return true
    end
  }):find()
end

-- Testing code:

test = setup

-- TODO
-- remove need for custom shell script
-- show pretty preview, not raw HTML
-- add custom keybindings
-- actions:
--   open browser
--   copy type
--   copy import
vim.cmd 'nnoremap <leader>t :lua test()<cr>'
