return {
    "my-chop-down",
    dir = vim.fn.stdpath("config") .. "/lua/my-plugins/my-chop-down",
    config = function()
        local chop_down = require("my-chop-down")
        chop_down.setup()
        vim.keymap.set("n", "<Leader>cd", function()
            chop_down.chop_down()
        end, { desc = "Chop Down" })
    end,
}
