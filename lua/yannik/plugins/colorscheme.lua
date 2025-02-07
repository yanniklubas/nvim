return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                integrations = {
                    alpha = true,
                    fidget = true,
                    gitsigns = true,
                    harpoon = true,
                    mason = true,
                    cmp = true,
                    dap = true,
                    dap_ui = true,
                    native_lsp = {
                        enabled = true,
                        virtual_text = {
                            errors = { "italic" },
                            hints = { "italic" },
                            warnings = { "italic" },
                            information = { "italic" },
                        },
                        underlines = {
                            errors = { "underline" },
                            hints = { "underline" },
                            warnings = { "underline" },
                            information = { "underline" },
                        },
                        inlay_hints = {
                            background = true,
                        },
                    },
                    nvimtree = true,
                    treesitter_context = true,
                    treesitter = true,
                    telescope = {
                        enabled = true,
                    },
                    which_key = true

                }
            })
            vim.cmd.colorscheme("catppuccin")
        end
    }
}
