return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local which_key = require("which-key")
    which_key.setup(
      {
        show_help = true,
        plugins = { spelling = true },
        key_labels = {
          ["<leader>"] = "SPC",
        },
        triggers = "auto",
      }
    )
    which_key.register({
      w = { "<cmd>update!<CR>", "Save" },
      q = { "<cmd>lua require('util').smart_quit()<CR>", "Quit" },
      f = { name = "+File" },
      g = { name = "+Git" },
      s = {
        name = "+Search",
        c = {
          function()
            require("utils.cht").cht()
          end,
          "Cheatsheets",
        },
        s = {
          function()
            require("utils.cht").stack_overflow()
          end,
          "Stack Overflow",
        },
      },
      c = {
        name = "+Code",
        x = {
          -- Works with TreeSitter
          name = "Swap Next",
          f = "Function",
          p = "Parameter",
          c = "Class",
        },
        X = {
          -- Works with TreeSitter
          name = "Swap Previous",
          f = "Function",
          p = "Parameter",
          c = "Class",
        },
      },
    }, {
      prefix = "<leader>",
    })
  end
}
