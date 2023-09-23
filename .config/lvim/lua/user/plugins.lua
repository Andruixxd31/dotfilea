lvim.plugins = {
    { "lunarvim/lunar.nvim" },
    {
        "folke/trouble.nvim",
        cmd = "TroubleToggle",
    },
    {
        "folke/todo-comments.nvim",
        event = "BufRead",
        config = function()
            require("todo-comments").setup()
        end
    },
    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        config = function()
            require("persistence").setup({
                dir = vim.fn.expand(vim.fn.stdpath "state" .. "/sessions/"),
                options = { "buffers", "curdir", "tabpages", "winsize" }
            })
        end
    },
    { "christoomey/vim-tmux-navigator" },
    { "tpope/vim-surround" },
    {
        "felipec/vim-sanegx",
        event = "BufRead"
    },
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },
    { "tpope/vim-repeat" },
    {
        'smoka7/hop.nvim',
        version = "*",
        opts = {},
    },
    { "ThePrimeagen/harpoon" },
    {
        "nvim-telescope/telescope-frecency.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "kkharji/sqlite.lua" },
    },
}

lvim.builtin.telescope.on_config_done = function(telescope)
    pcall(telescope.load_extension, "frecency")
end
