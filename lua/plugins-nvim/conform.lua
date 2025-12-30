return {
    "stevearc/conform.nvim",
    opts = {
        default_format_opts = {
            lsp_format = "fallback",
        },
        formatters_by_ft = {
            lua = { "stylua" },
        },
        formatters = {
            stylua = {},
        },
    },
    config = function(_, opts)
        local conform = require("conform")
        conform.setup(opts)
        vim.keymap.set({ "n", "v" }, "<Leader>cf", function()
            local ok = conform.format({ async = true })
            if ok == false then
                local mode = vim.api.nvim_get_mode().mode
                if mode == "n" then
                    vim.cmd("normal! gg=G``")
                else
                    vim.cmd("normal! =")
                end
            end
        end, { desc = "Format" })
    end,
}
