local M = {}

M.autoformat = true

function M.toggle()
  M.autoformat = not M.autoformat
  vim.notify(M.autoformat and "Enabled format on save" or "Disabled format on save")
end

function M.format()
  local buffer = vim.api.nvim_get_current_buf()
  local filetype = vim.bo[buffer].filetype

  local has_null_ls = #require("null_ls.source").get_available(filetype, "NULL_LS_FORMATTING") > 0

  vim.lsp.buf.format({
    bufnr = buffer,
    filter = function(client)
      if has_null_ls then
        return client.name == "null-ls"
      end
      return client.name ~= "null-ls"
    end,
  })
end

function M.on_attach(client, buf)
  if client.supports_method "textDocument/formatting" then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("LspFormat." .. buf, {}),
      buffer = buf,
      callback = function()
        if M.autoformat then
          M.format()
        end
      end,
    })
  end
end

return M
