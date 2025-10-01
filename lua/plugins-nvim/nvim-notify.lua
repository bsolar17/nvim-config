return {
    "rcarriga/nvim-notify",
    lazy = false,
    opts = {
        stages = "fade",
        background_colour = "#000000",
        top_down = false,
    },
    config = function(_, opts)
        local notify = require("notify")
        notify.setup(opts)
        vim.notify = notify
    end
}
