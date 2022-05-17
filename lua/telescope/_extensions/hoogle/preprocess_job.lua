-- Slightly modified JobFinder from Telescope, able to return multiple results.

local Job = require 'plenary.job'

local _callable_obj = function()
  local obj = {}

  obj.__index = obj
  obj.__call = function(t, ...) return t:_find(...) end
  obj.close = function() end

  return obj
end

local JobFinder = _callable_obj()

local function default_preprocess(data)
  return {data}
end

--- Create a new finder command
---
---@param opts table Keys:
--     fn_command function The function to call
function JobFinder:new(opts)
  opts = opts or {}

  local obj = setmetatable({
    entry_maker = opts.entry_maker or make_entry.from_string,
    fn_command = opts.fn_command,
    fn_preprocess = opts.fn_preprocess or default_preprocess,
    cwd = opts.cwd,
    writer = opts.writer,

    -- Maximum number of results to process.
    --  Particularly useful for live updating large queries.
    maximum_results = opts.maximum_results,
  }, self)

  return obj
end

function JobFinder:_find(prompt, process_result, process_complete)
  if self.job and not self.job.is_shutdown then
    self.job:shutdown()
  end

  local on_output = function(_, data, _)
    if not data or data == "" then
      return
    end

    -- NOTE: modified part, preprocess function returns array iso single value!
    local lines = self.fn_preprocess(data)

    for _, line in ipairs(lines) do
      if self.entry_maker then
        line = self.entry_maker(line)
      end

      -- NOTE: Because we are calling this within a loop, 
      -- we must defer processing until nvim API functions are safe to call.
      vim.defer_fn(function()
        process_result(line)
      end,
      0)
    end
  end

  local opts = self:fn_command(prompt)
  if not opts then return end

  local writer = nil
  if opts.writer and Job.is_job(opts.writer) then
    writer = opts.writer
  elseif opts.writer then
    writer = Job:new(opts.writer)
  end

  self.job = Job:new {
    command = opts.command,
    args = opts.args,
    cwd = opts.cwd or self.cwd,

    maximum_results = self.maximum_results,

    writer = writer,

    enable_recording = false,

    on_stdout = on_output,
    on_stderr = on_output,

    on_exit = process_complete
  }

  self.job:start()
end

return JobFinder
