-- Stop nvim-treesitter from hiding raw markdown
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt.conceallevel = 0
  end,
})

return {}
