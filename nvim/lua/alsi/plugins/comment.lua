return {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    config = function()
        local comment = require("Comment")
        local comment_ft = require("Comment.ft")

        local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()

        comment.setup({
            pre_hook = function(ctx)
                return ts_context_commentstring(ctx) or comment_ft.get(vim.bo.filetype, ctx.ctype)
            end,
        })
    end
}
