return {
    "stevearc/conform.nvim",
    cond = not vim.g.vscode,
    opts = {
        default_format_opts = {
            lsp_format = "fallback",
        },
    },
    config = function(_, opts)
        local conform = require("conform")
        conform.setup(opts)
        vim.keymap.set({ "n", "x", "v" }, "<Leader>cf", conform.format, { desc = "Format" })
        vim.keymap.set("n", "<Leader>cp", function()
            if opts and opts.formatters_by_ft and vim.tbl_contains(opts.formatters_by_ft.java or {}, "prettier") then
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
