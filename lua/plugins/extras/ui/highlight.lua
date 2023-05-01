return {
  {
    "RRethy/vim-illuminate",
    event = "BufReadPost",
    opts = {
      delay = 200,
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
  },
  {
    "m-demare/hlargs.nvim",
    event = "VeryLazy",
    opts = {
      color = "#ef9062",
      use_colorpalette = false,
      disable = function(_, buffer_nbr)
        if vim.b.semantic_tokens then
          return true
        end

        local clients = vim.lsp.get_active_clients({
          bufnr = buffer_nbr,
        })
        for _, client in pairs(clients) do
          local capabilities = client.server_capabilities

          if client.name ~= "null-ls" and capabilities.sementicTokensProvider and capabilities.sementicTokensProvider.full then
            vim.b.semantic_tokens = true
            return vim.b.semantic_tokens
          end
        end
      end,
    }
  },
  {
    "andymass/vim-matchup",
    lazy = false,
    enable = true,
    init = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  }
}
