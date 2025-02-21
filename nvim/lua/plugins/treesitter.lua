require("nvim-treesitter.configs").setup {
    ensure_installed = { "lua", "go", "vim", "json" },
    ignore_install = {}, -- Lists of parsers to ignore installing
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = { 'help' },
    },
}
