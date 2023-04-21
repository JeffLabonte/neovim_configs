function has_words_before()
  local line, column = unpack(vim.api.nvim_win_get_cursor(0))
  return column ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(column, column):match("%s") == nil
end

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
  },
  config = function()
    local cmp = require("cmp")
    local lua = require("luasnip")
    local icons = require("plugins.icons")

    cmp.setup()
  end
}
