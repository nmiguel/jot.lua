local utils = require("jot.utils")

local M = {}

local ui = vim.api.nvim_list_uis()[1]
M.config = {
  quit_key = "q",
  notes_dir = vim.fn.stdpath("data") .. "/jot",
  win_opts = {
    relative = "editor",
    width = 36,
    height = 100,
    anchor = "NE",
    row = 0,
    col = ui.width - 36,
    -- split = "right",
    focusable = false,
  },
}

M.open = function()
  local note_path = utils.provide_note_file(M.config)
  if note_path == nil then
    vim.api.nvim_err_writeln("Failed to create note file")
    return
  end

  local buf = utils.view_file(note_path, M.config)

  if M.config.quit_key ~= nil then
    vim.api.nvim_buf_set_keymap(buf, "n", M.config.quit_key, ":silent wq<CR>", { noremap = true, silent = true })
  end
end

M.setup = function(config)
  M.config = vim.tbl_deep_extend("force", M.config, config or {})
end

return M
