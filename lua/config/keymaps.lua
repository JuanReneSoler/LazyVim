-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>W", ":w<CR>", { desc = "Write all text" })

--
vim.keymap.set("i", "<C-p>", function()
  local my_gh_token = os.getenv("GH_TOKEN") or ""
  vim.api.nvim_put({ my_gh_token }, "c", true, true)
end, { desc = "pegar my GH_TOKEN" })

--
-- Evitar que al pegar sobre texto se reemplace lo copiado (modo visual)
vim.keymap.set("x", "p", '"_dP', { noremap = true, silent = true, desc = "Pegar sin perder el yank" })

-- Hacer que p y P siempre peguen desde el registro 0 (último yank)
vim.keymap.set("n", "p", '"0p', { noremap = true, silent = true, desc = "Pegar desde registro 0" })
vim.keymap.set("n", "P", '"0P', { noremap = true, silent = true, desc = "Pegar desde registro 0 (antes del cursor)" })

-- Yank al portapapeles del sistema con <leader>y
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Copiar al portapapeles del sistema" })

-- Pegar desde el portapapeles del sistema con <leader>p
vim.keymap.set("n", "<leader>p", '"+p', { desc = "Pegar desde el portapapeles del sistema" })
