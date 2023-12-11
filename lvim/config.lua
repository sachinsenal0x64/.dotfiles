-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny


-- Misc

vim.opt.mouse = ""
lvim.transparent_window = true
lvim.leader = "space"
lvim.colorscheme = "pywal"


-- Keybindigs


lvim.builtin.which_key.mappings = {
  ["c"] = { "<cmd>BufferClose!<CR>", "Close Buffer" },
  ["e"] = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
  ["h"] = { '<cmd>let @/=""<CR>', "No Highlight" },
  ["i"] = { "<cmd>Lazy install<cr>", "Install" },
  ["s"] = { "<cmd>Lazy sync<cr>", "Sync" },
  ["S"] = { "<cmd>Lazy clear<cr>", "Status" },
  ["u"] = { "<cmd>Lazy update<cr>", "Update" },
 }

-- Plugins

lvim.plugins = {
  {
    "AlphaTechnolog/pywal.nvim",
    config = function()
      require("pywal").setup()
    end,
  },


}

