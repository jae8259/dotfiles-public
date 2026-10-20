return {
  {
    "clabby/difftastic.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "folke/snacks.nvim",
    },
    config = function()
      require("difftastic-nvim").setup({
        download = true,
        vcs = "jj",
        snacks_picker = {
          enabled = true,
        },
      })
    end,
  },
}
