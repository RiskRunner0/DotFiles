return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "bash",
                "embedded_template",
                "html",
                "java",
                "javascript",
                "json",
                "lua",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "regex",
                "ruby",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "yaml",
            },
            sync_install = false,
            auto_install = true,
            indent = {
                enable = true
            },
            highlight = {
                enable = true,
            },
        })
    end
}
