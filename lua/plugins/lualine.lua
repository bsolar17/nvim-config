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
            lualine_c = { "buffers" },
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
            vim.keymap.set("n", "<leader>b" .. i, function() safeBuffersJump(i) end, { desc = tostring(i) })
        end
    end
}
