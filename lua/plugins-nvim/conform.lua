return {
    "stevearc/conform.nvim",
    opts = {
        default_format_opts = {
            lsp_format = "fallback",
        },
        formatters_by_ft = {
            lua = { "stylua" },
            markdown = { "prettier" },
        },
        formatters = {
            stylua = {},
            prettier = {
                prepend_args = { "--prose-wrap", "always" },
            },
        },
    },
    config = function(_, opts)
        local conform = require("conform")
        conform.setup(opts)
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
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
