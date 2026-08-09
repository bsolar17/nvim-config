-- Local (non-git) plugins that use the classic `plugin/` autoload convention.
vim.opt.rtp:append(vim.fn.stdpath("config") .. "/lua/my-plugins/my-autocmds")
vim.opt.rtp:append(
    vim.fn.stdpath("config") .. "/lua/my-plugins/my-java-autocmd"
)

vim.pack.add({
    -- Colorscheme
    "https://github.com/catppuccin/nvim",

    -- Completion
    -- Pinned to the v1.x line: v2 has no tagged release yet, and blink.cmp's
    -- prebuilt-binary downloader requires the checkout to sit on a tag.
    {
        src = "https://github.com/saghen/blink.cmp",
        version = vim.version.range("1"),
    },
    {
        src = "https://github.com/L3MON4D3/LuaSnip",
        version = vim.version.range("2.0.0"),
    },

    -- AI
    "https://github.com/coder/claudecode.nvim",
    "https://github.com/folke/snacks.nvim",

    -- Formatting
    "https://github.com/stevearc/conform.nvim",

    -- Git
    "https://github.com/sindrets/diffview.nvim",
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/tpope/vim-fugitive",

    -- LSP status / diagnostics UI
    "https://github.com/j-hui/fidget.nvim",
    "https://github.com/rachartier/tiny-inline-diagnostic.nvim",
    "https://github.com/folke/trouble.nvim",

    -- Fuzzy finder
    "https://github.com/ibhagwan/fzf-lua",

    -- Harpoon
    { src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
    "https://github.com/letieu/harpoon-lualine",
    "https://github.com/nvim-lua/plenary.nvim",

    -- UI
    "https://github.com/lukas-reineke/indent-blankline.nvim",
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/nvim-tree/nvim-tree.lua",
    "https://github.com/chentoast/marks.nvim",
    "https://github.com/folke/which-key.nvim",
    "https://github.com/MeanderingProgrammer/render-markdown.nvim",

    -- Editing
    "https://github.com/nvim-mini/mini.nvim",
    "https://github.com/unblevable/quick-scope",
    "https://github.com/ThePrimeagen/refactoring.nvim",
    "https://github.com/jiaoshijie/undotree",
    "https://github.com/kevinhwang91/nvim-fundo",
    "https://github.com/kevinhwang91/promise-async",
    "https://github.com/ethanholz/nvim-lastplace",

    -- Treesitter
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
        version = "main",
    },
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
        version = "main",
    },

    -- LSP
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/neovim/nvim-lspconfig",

    -- DAP
    "https://github.com/mfussenegger/nvim-dap",
    "https://github.com/rcarriga/nvim-dap-ui",
    "https://github.com/nvim-neotest/nvim-nio",

    -- Java
    "https://github.com/mfussenegger/nvim-jdtls",
    "https://github.com/JavaHello/spring-boot.nvim",
})

-- Build steps that lazy.nvim used to run via `build =`. vim.pack has no
-- equivalent field, so run them once after install/update via PackChanged.
vim.api.nvim_create_autocmd("PackChanged", {
    desc = "Run post-install/update build steps for plugins that need them",
    callback = function(event)
        local data = event.data
        if data.kind == "delete" then
            return
        end
        local name = data.spec and data.spec.name
        if name == "LuaSnip" then
            vim.system({ "make", "install_jsregexp" }, { cwd = data.path })
        elseif name == "nvim-fundo" then
            require("fundo").install()
        elseif name == "nvim-treesitter" then
            vim.cmd("TSUpdate")
        end
    end,
})

-- catppuccin must load first so the colorscheme is active before any other
-- plugin defines highlight groups at setup time, avoiding a flash of
-- default colors.
require("plugins.catppuccin")

-- Order below is otherwise arbitrary (kept alphabetical for tidiness): no
-- setup() here requires another plugin's module synchronously. If that
-- changes, list the dependency first.
require("plugins.blink-cmp")
require("plugins.claudecode")
require("plugins.conform")
require("plugins.diffview")
require("plugins.fidget")
require("plugins.fzf")
require("plugins.gitsigns")
require("plugins.harpoon")
require("plugins.harpoon-lualine")
require("plugins.indent-blankline")
require("plugins.lsp")
require("plugins.lualine")
require("plugins.marks")
require("plugins.mini")
require("plugins.nvim-dap")
require("plugins.nvim-fundo")
require("plugins.nvim-jdtls")
require("plugins.nvim-lastplace")
require("plugins.nvim-tree")
require("plugins.quick-scope")
require("plugins.refactoring")
require("plugins.render-markdown")
require("plugins.snacks")
require("plugins.tiny-inline-diagnostic")
require("plugins.treesitter")
require("plugins.trouble")
require("plugins.undotree")
require("plugins.vim-fugitive")
require("plugins.which-key")
