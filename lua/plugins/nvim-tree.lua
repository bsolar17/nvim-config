return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        vim.keymap.set("n", "<leader>t", vim.cmd.NvimTreeToggle, { desc = "File Explorer" })
        local function my_on_attach(bufnr)
            local api = require("nvim-tree.api")

            api.config.mappings.default_on_attach(bufnr)

            vim.keymap.set("n", "<S-Right>", "<cmd>NvimTreeResize +10<CR>", { desc = "Widen nvim-tree" })
            vim.keymap.set("n", "<S-Left>", "<cmd>NvimTreeResize -10<CR>", { desc = "Narrow nvim-tree" })
        end

        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        require("nvim-tree").setup({
            update_focused_file = {
                enable = true,
            },
            view = {
                width = 50,
            },
            actions = {
                open_file = {
                    quit_on_open = true,
                },
                change_dir = {
                    global = true,
                },
            },
            on_attach = my_on_attach
        })
    end
}
