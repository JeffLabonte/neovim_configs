local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazy_path) then
  vim.fn.system(
    {
      "git",
      "clone",
      "--filter=blob:none",
      "https:://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazy_path,
    }
  )
end
vim.opt.rtp:prepend(lazy_path)

require("lazy").setup({
  spec = {
    { import = "plugins" },
    { import = "plugins.extras.lang" },
    { import = "plugins.extras.ui" },
  },
  defaults = { lazy = true, version = nil },
  install = { missing = true, colorscheme = { "tokyonight", "gruvbox" } },
  checker = { enabled = true },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

vim.keymap.set("n", "<leader>z", "<cmd>:Lazy<cr>", { desc = "Plugin Manager" })
