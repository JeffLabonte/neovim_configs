local M = {}

local servers = {
  pyright = {
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "off",
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "workspace",
        },
      },
    },
  },
  rust_analyzer = {
    settings = {
      ["rust_analyzer"] = {
        cargo = {
          allFeatures = true,
        },
        checkOnSave = {
          command = "cargo clippy",
          extraArgs = { "--no-deps" },
        },
      },
    },
  },
  tsserver = {
    disable_formatting = true,
  },
  dockerls = {},
}

local function lsp_attach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })
end

local function lsp_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  return require("cmp_nvim_lsp").default_capabilities(capabilities)
end

function M.setup(_)
  lsp_attach(function(client, buffer)
    require("plugins.lsp.format").on_attach(client, buffer)
    require("plugins.lsp.keymaps").on_attach(client, buffer)
  end)

  require("mason-lspconfig").setup({
    ensure_installed = vim.tbl_keys(servers)
  })

  require("mason-lspconfig").setup_handlers({
    function(server)
      local opts = servers[server] or {}
      opts.capabilities = lsp_capabilities()
      require("lspconfig")[server].setup(opts)
    end,
    ["rust_analyzer"] = function(server)
      local rust_tools = require("rust-tools")
      local options = servers[server] or {}
      options.capabilities = lsp_capabilities()
      rust_tools.setup({
        server = options,
      })
    end
  })
end

return M
