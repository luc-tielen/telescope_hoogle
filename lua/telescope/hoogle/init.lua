local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local actions = require 'telescope.actions'
local previewers = require 'telescope.previewers'

local function prompt_to_hoogle_cmd(prompt)
  if not prompt or prompt == '' then
    return nil
  end

  return vim.tbl_flatten {'hoogle', '--count=500', prompt}
end

local function entry_maker(line)
  return {
    valid = string.match(line, '^%-%-') == nil,
    value = line,
    ordinal = line,
    display = line
  }
end

test = function()
  if vim.fn.executable('hoogle') == '1' then
    vim.api.nvim_err_writeln("telescope.hoogle: 'hoogle' command not found! Aborting.")
    return
  end

  local finder = finders.new_job(prompt_to_hoogle_cmd, entry_maker)
  local opts = {} -- TODO
  pickers.new(opts, {
    prompt_title = 'Hoogle search',
    finder = finder
  }):find()
end

vim.cmd 'nnoremap <leader>t :lua test()<cr>'
