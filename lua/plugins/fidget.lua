-- Progress titles jdtls reports on nearly every buffer change and request;
-- "Background task" is the one carrying "Reconciling...".
local jdtls_noise = {
    "Publish Diagnostics",
    "Validate documents",
    "Background task",
}

return {
    "j-hui/fidget.nvim",
    opts = {
        notification = {
            override_vim_notify = true,
            window = {
                winblend = 0,
            },
        },
        progress = {
            ignore = {
                function(msg)
                    if msg.lsp_client.name ~= "jdtls" then
                        return false
                    end
                    for _, title in ipairs(jdtls_noise) do
                        if string.find(msg.title, title, 1, true) then
                            return true
                        end
                    end
                    return false
                end,
            },
        },
    },
}
