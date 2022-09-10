vim.g.bad_lualine_theme='tokyonight'

require('lualine').setup({
    sections = sections,
    options = {
        theme = vim.g.bad_lualine_theme,
    }
})
