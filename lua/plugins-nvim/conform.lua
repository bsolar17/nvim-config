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
        vim.keymap.set("n", "<Leader>cp", function()
            if
                opts
                and opts.formatters_by_ft
                and vim.tbl_contains(
                    opts.formatters_by_ft.java or {},
                    "prettier"
                )
            then
                opts.formatters_by_ft.java = nil
                print("Prettier disabled for Java")
            else
                opts = opts or {}
                opts.formatters_by_ft = opts.formatters_by_ft or {}
                opts.formatters_by_ft.java = { "prettier" }
                print("Prettier enabled for Java")
            end
            conform.setup(opts)
        end, { desc = "Toggle Prettier for Java" })
    end,
}
