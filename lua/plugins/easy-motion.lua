return {
  "easymotion/vim-easymotion",
  init = function()
    vim.g.EasyMotion_do_mapping = 0
  end,
  config = function()
    vim.keymap.set("n", "<leader>m", "<Plug>(easymotion-prefix)", { desc = "easymotion" })
    vim.keymap.set("n", "<leader>m<leader>", "<Plug>(easymotion-overwin-f2)", { desc = "Motion two chars" })
  end,
}
