local Remap = require("bad.keymap")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap

local sumneko_root_path = vim.env.HOME .. "/.local/share/nvim/lsp_servers/sumneko_lua/extension/server"
local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"

local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

local ok, lspkind = pcall(require, "lspkind")
if not ok then
  return
end

lspkind.init()

require("luasnip.loaders.from_vscode").lazy_load(
-- {paths = vim.env.HOME .. ".config/nvim/lua/bad/snippets"}
)

local opts = {
    highlight_hovered_item = true,
    show_guides = true,
}

require("symbols-outline").setup(opts)

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `LuaSnip` users.
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = {
        ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<c-y>"] = cmp.mapping(
          cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          },
          { "i", "c" }
        ),

        ["<c-space>"] = cmp.mapping {
          i = cmp.mapping.complete(),
          c = function(
            _ --[[fallback]]
          )
            if cmp.visible() then
              if not cmp.confirm { select = true } then
                return
              end
            else
              cmp.complete()
            end
          end,
        },

        ["<Tab>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif check_backspace() then
                fallback()
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
    }, {
        { name = 'buffer' },
    }),
    formatting = {
        format = lspkind.cmp_format {
            with_text = true,
            menu = {
                buffer = "[buf]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[api]",
                path = "[path]",
                luasnip = "[snip]",
                gh_issues = "[issues]",
                tn = "[TabNine]",
            },
        },
    },
})

local function config(_config)
    return vim.tbl_deep_extend("force", {
        capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
        on_attach = function()
            nnoremap("gd", function() vim.lsp.buf.declaration() end)
            nnoremap("gD", function() vim.lsp.buf.definition() end)
            nnoremap("K", function() vim.lsp.buf.hover() end)
            nnoremap("gi", function() vim.lsp.buf.implementation() end)
            nnoremap("<Leader>K", function() vim.lsp.buf.signature_help() end)
            nnoremap("<Leader>wa", function() vim.lsp.buf.add_workspace_folder() end)
            nnoremap("<Leader>wr", function() vim.lsp.buf.remove_workspace_folder() end)
            nnoremap("<Leader>wl", function() vim.lsp.buf.list_workspace_folders() end)
            nnoremap("<Leader>D", function() vim.lsp.buf.type_definition() end)
            nnoremap("<Leader>rn", function() vim.lsp.buf.rename() end)
            nnoremap("<Leader>gr", function() vim.lsp.buf.references() end)
            nnoremap("<Leader>ca", function() vim.lsp.buf.code_action({
                    filter = function(code_action)
                        if not code_action or not code_action.data then
                            return false
                        end

                        local data = code_action.data.id
                        return string.sub(data, #data - 1, #data) == ":0"
                    end,
                    apply = true
                })
            end)
            nnoremap("<Leader>f", function() vim.lsp.buf.formatting() end)
            inoremap("<C-h>", function() vim.lsp.buf.signature_help() end)
            nnoremap("[x", function() vim.diagnostic.goto_next() end)
			nnoremap("]x", function() vim.diagnostic.goto_prev() end)
        end,
    }, _config or {})
end

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['pylsp'].setup(config({
    capabilities = capabilities,
}))
require('lspconfig')['marksman'].setup (config({
    capabilities = capabilities,
}))
require("lspconfig")['sumneko_lua'].setup(config({
    capabilities = capabilities,
    cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
                -- Setup your lua path
                path = vim.split(package.path, ";"),
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                },
            },
        },
    },
}))
require('lspconfig')['rust_analyzer'].setup(config({
    capabilities = capabilities,
    settings = {
        cmd = { "rustup", "run", "nightly", "rust-analyzer" },
        ["rust-analyzer"] = {
            assist = {
                importEnforceGranularity = true,
                importPrefix = "crate"
            },
            cargo = {
                allFeatures = true
            },
            checkOnSave = {
                -- default: `cargo check`
                command = "clippy"
            },
        },
        inlayHints = {
            lifetimeElisionHints = {
                enable = true,
                useParameterNames = true
            },
        },
    }
}))
