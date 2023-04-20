return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    build = "TSUpdate",
    event = "BufReadPost",
    config = function()
    end
  }
}
