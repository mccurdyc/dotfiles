local no_preview = function()
  return require("telescope.themes").get_dropdown(
    {
      borderchars = {
        {"─", "│", "─", "│", "┌", "┐", "┘", "└"},
        prompt = {"─", "│", " ", "│", "┌", "┐", "│", "│"},
        results = {"─", "│", "─", "│", "├", "┤", "┘", "└"},
        preview = {"─", "│", "─", "│", "┌", "┐", "┘", "└"}
      },
      width = 0.8,
      previewer = false,
      prompt_title = false
    }
  )
end

require("telescope").setup {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--hidden",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case"
    }
  }
}
