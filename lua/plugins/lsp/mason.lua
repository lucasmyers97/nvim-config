return {
    'mason-org/mason-lspconfig.nvim',
    opts = {
        ensure_installed = {
            'lua_ls',
        }
    },
    dependencies = {
        {
            'mason-org/mason.nvim',
            opts = {
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            },
            tag = 'v2.1.1'
        },
        {
            'neovim/nvim-lspconfig',
            tag = 'v2.7.0'
        }
    },
    tag = 'v2.1.0'
}
