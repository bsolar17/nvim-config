return {
    "nvim-mini/mini.nvim",
    version = false,
    config = function()
        require("mini.comment").setup()
        require("mini.pairs").setup()
        require("mini.splitjoin").setup({
            mappings = {
                toggle = "<leader>cS",
            },
        })
        require("mini.surround").setup()
        require("mini.tabline").setup()
        require("mini.icons").setup()
        MiniIcons.mock_nvim_web_devicons()
    end,
}
