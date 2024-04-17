return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        options = {
            globalstatus = true,
        },
        sections = {
            lualine_x = {
                {
                    "harpoon2",
                    icon = "",
                    separator = " ",
                },
                "encoding",
                "fileformat",
                "filetype"
            },
        },
    },
    config = function(_, opts)
        require("lualine").setup(opts)
        local function safeBuffersJump(n)
            local ok, _ = pcall(vim.cmd, "LualineBuffersJump " .. n)
            if not ok then
                vim.print("Error jumping to buffer " .. n)
            end
        end
        for i = 1, 8 do
            vim.keymap.set("n", "<leader>" .. i, function() safeBuffersJump(i) end, { desc = "Buffer " .. i })
        end
    end
}
