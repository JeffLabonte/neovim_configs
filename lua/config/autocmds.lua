local highlight_group = vim.api.nvim_create_augroup(
  "YankHighlight",
  {
    clear = true
  }
)

vim.api.nvim_create_autocmd(
  "TextYankPost",
  {
    callback = function()
      vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
  }
)

vim.api.nvim_create_autocmd(
  "FocusGained",
  {
    command = "checktime",
  }
)

vim.api.nvim_create_autocmd(
  "BufReadPre",
  {
    pattern = "*",
    callback = function()
      vim.api.nvim_create_autocmd(
        "FileType",
        {
          pattern = "<buffer>",
          once = true,
          callback = function()
            vim.cmd(
              [[if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif]]
            )
          end,
        }
      )
    end,
  }
)
