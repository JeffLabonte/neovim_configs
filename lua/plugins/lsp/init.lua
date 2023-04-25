return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      "folke/neoconf.nvim",
      { "folke/neodev.nvim",       config = true },
      { "j-hui/fidget.nvim",       config = true },
      { "smjonas/inc-rename.nvim", config = true },
      "simrat39/rust-tools.nvim",
      "rust-lang/rust.vim",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
    config = function(plugins)
      require("plugins.lsp.servers").setup(plugins)
    end
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    ensure_installed = {
      "stylua",
      "autopep8",
      "ruff",
      "black",
      "debugpy",
      "lua-language-server",
      "rust-analyzer",
      "json-lsp",
    },
    config = function(plugin)
      require("mason").setup()
      local mason_registry = require("mason-registry")

      for _, tool in ipairs(plugin.ensure_installed) do
        local _package = mason_registry.get_package(tool)
        if not _package:is_installed() then
          _package:install()
        end
      end
    end
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    dependencies = {
      "mason.nvim",
    },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.rustfmt,
          null_ls.builtins.diagnostics.ruff.with({
            extra_args = {
              "--max-line-length=180",
            }
          })
        }
      })
    end,
  },
  {
    "utilyre/barbecue.nvim",
    event = "VeryLazy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    config = true,
  }
}
