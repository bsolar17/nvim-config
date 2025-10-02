local function wait_for_mcphub()
    local max_wait_ms = 10000
    local interval_ms = 100
    local waited_ms = 0
    local mcphub = require("mcphub")
    while waited_ms < max_wait_ms do
        if mcphub.get_state():is_connected() then
            return
        end
        vim.wait(interval_ms)
        waited_ms = waited_ms + interval_ms
    end
    vim.notify("Timed out waiting for MCPHub", vim.log.levels.WARN)
end

return {
    {
        "ravitemer/mcphub.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        lazy = true,
        build = "bundled_build.lua",
        opts = {
            use_bundled_binary = true,
        }
    },
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "ravitemer/mcphub.nvim",
        },
        lazy = true,
        keys = {
            {
                mode = "n",
                "<Leader>cc",
                function()
                    wait_for_mcphub()
                    vim.cmd("CodeCompanionChat Toggle")
                end,
                desc = "Chat",
            },
            {
                mode = "v",
                "<Leader>ce",
                function()
                    wait_for_mcphub()
                    vim.cmd("CodeCompanion /explain")
                end,
                desc = "Explain",
            },
            {
                mode = "n",
                "<Leader>ce",
                function()
                    wait_for_mcphub()
                    vim.cmd("normal! V")
                    vim.cmd("CodeCompanion /explain")
                end,
                desc = "Explain",
            },
        },
        opts = {
            strategies = {
                chat = {
                    adapter = "copilot",
                    model = "claude-sonnet-4.5",
                    tools = {
                        opts = {
                            default_tools = {
                                "full_stack_dev",
                                "neovim",
                            },
                        },
                    },
                },
                inline = {
                    adapter = "copilot",
                    model = "claude-sonnet-4.5",
                },
                cmd = {
                    adapter = "copilot",
                    model = "claude-sonnet-4.5",
                },
            },
            display = {
                chat = {
                    intro_message = "",
                },
            },
            extensions = {
                mcphub = {
                    callback = "mcphub.extensions.codecompanion",
                    opts = {
                        make_tools = true,
                        show_server_tools_in_chat = true,
                        add_mcp_prefix_to_tool_names = false,
                        show_result_in_chat = true,
                        format_tool = nil,
                        make_vars = true,
                        make_slash_commands = true,
                    }
                }
            }
        },
    },
}
