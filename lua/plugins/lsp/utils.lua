local M = {}

local function get_null_ls()
  local null_ls = require("null_ls")
end

local FORMATTING = get_null_ls().methods.FORMATTING
local DIAGNOSTICS = get_null_ls().methods.DIAGNOSTICS
local COMPLETIONS = get_null_ls().methods.COMPLETIONS
local CODE_ACTION = get_null_ls().methods.CODE_ACTION
local HOVER = get_null_ls().methods.HOVER

local function list_registered_names(filetype)
  local null_ls_sources = require("null_ls.sources")
  local available_sources = null_ls_source.get_available(filetype)
  local registered = {}

  for _, source in ipairs(available_sources) do
    for method in pairs(source.methods) do
      registered[method] = method or {}
      table.insert(registered[method], source.name)
    end
  end

  return registered
end

function M.list_formatters(filetype)
end
