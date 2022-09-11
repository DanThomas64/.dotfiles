-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function()
    use("wbthomason/packer.nvim")
    -- Formating
    use("sbdchd/neoformat")
    -- Lua cheat codes
    use("nvim-lua/plenary.nvim")
    use("nvim-lua/popup.nvim")
    -- Find shit in files
    use("nvim-telescope/telescope.nvim")
    use { "nvim-telescope/telescope-file-browser.nvim" }
    -- Theme and pretty lights
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    -- Treesitter
    use("nvim-treesitter/nvim-treesitter", {
        run = ":TSUpdate"
    })
    use("folke/tokyonight.nvim")
    -- LSP
    use {
        "williamboman/nvim-lsp-installer",
        "neovim/nvim-lspconfig",
    }
    -- Commenting
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
    -- Completion
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/nvim-cmp")
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")
    use("rafamadriz/friendly-snippets")
    use("simrat39/symbols-outline.nvim")
    use("onsails/lspkind.nvim")
end)
