local mason_ok, mason = pcall(require, 'mason')
if not mason_ok then return end

local mason_lspconfig_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not mason_lspconfig_ok then return end

local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_ok then return end

local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_nvim_lsp_ok then return end

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
--[[
mason.on_server_ready(function(server)
	local opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}

	 if server.name == "jsonls" then
	 	local jsonls_opts = require("user.lsp.settings.jsonls")
	 	opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
	 end

	 if server.name == "sumneko_lua" then
	 	local sumneko_opts = require("user.lsp.settings.sumneko_lua")
	 	opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	 end

	 if server.name == "pyright" then
	 	local pyright_opts = require("user.lsp.settings.pyright")
	 	opts = vim.tbl_deep_extend("force", pyright_opts, opts)
	 end

	-- This setup() function is exactly the same as lspconfig's setup function.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	server:setup(opts)
end)
]]--


mason.setup({
    ui = {
        border = "rounded",
        icons = {
            package_installed = "◍",
            package_pending = "◍",
            package_uninstalled = "◍"
        },
        keymaps = {
            toggle_package_expand = "<CR>",
            install_package = "i",
            update_package = "u",
            check_package_version = "c",
            update_all_packages = "U",
            check_outdated_packages = "C",
            uninstall_package = "X",
            cancel_installation = "<C-c>",
            apply_language_filter = "<C-f>",
        },
    },
    install_root_dir = vim.fn.stdpath("data").."/mason",
    pip = {
        install_args = {},
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
    github = {
        download_url_template = "https://github.com/%s/releases/download/%s/%s",
    },
})


mason_lspconfig.setup({
    ensure_installed = {},
    automatic_installation = false,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

mason_lspconfig.setup_handlers {
    function (server_name)
        local opts = {
		    on_attach = require("user.lsp.handlers").on_attach,
		    capabilities = require("user.lsp.handlers").capabilities,
        }
        lspconfig[server_name].setup(opts)
        vim.cmd [[ do User LspAttachBuffers ]]
    end,
    --["sumneko_lua"] = require("user.lsp.settings.sumneko_lua")
    ["sumneko_lua"] = function ()
        lspconfig.sumneko_lua.setup {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" }
                    }
                }
            }
        }
    end,
    ["tsserver"] = function ()
        lspconfig.tsserver.setup{}
    end,
    --#region
}
