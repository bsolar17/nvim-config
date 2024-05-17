return {
    "unblevable/quick-scope",
    init = function()
        vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
        vim.g.qs_max_chars = 250
        vim.g.qs_lazy_highlight = 1
        vim.api.nvim_set_hl(0, "QuickScopePrimary", { bold = true, underline = true })
        vim.api.nvim_set_hl(0, "QuickScopeSecondary", { underline = true })
    end,
}
