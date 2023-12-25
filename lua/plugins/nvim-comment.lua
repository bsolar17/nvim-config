return {
    'terrortylor/nvim-comment',
    config = function()
        require('nvim_comment').setup({
            line_mapping = "<C-_><C-_>",
            operator_mapping = "<C-_>",
            comment_chunk_text_object = "i<C-_>",
        })
    end
}
