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
    use("folke/tokyonight.nvim")
    -- LSP
    use {
        "williamboman/nvim-lsp-installer",
        "neovim/nvim-lspconfig",
    }
end)
