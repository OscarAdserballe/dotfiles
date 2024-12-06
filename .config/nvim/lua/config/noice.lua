return {
  setup = function()
    require("noice").setup({
      cmdline = {
        enabled = true,
        view = "cmdline_popup",
        position = {
          row = "50%",
          col = "50%",
        },
        size = {
          width = 60,
          height = "auto",
        },
        border = {
          style = "rounded",
          padding = { 1, 2 },
        },
      },
      -- Add any other Noice configurations here
      messages = {
        enabled = true,
      },
      popupmenu = {
        enabled = true,
      },
    })
  end
}
