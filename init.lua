require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Packer manages itself
  use 'neovim/nvim-lspconfig'  -- Add lspconfig
  use 'nvim-tree/nvim-tree.lua'
  use 'kyazdani42/nvim-web-devicons'
end)


require'lspconfig'.clangd.setup{}
require'nvim-tree'.setup {}
require'nvim-web-devicons'.setup {}

vim.cmd("colorscheme embark")
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.tabstop = 4
vim.o.wrap = false

function GetAllColorschemes()
    local colors = {}

    -- Check each potential colors directory in the runtime path
    for _, source in ipairs(vim.api.nvim_list_runtime_paths()) do
        local colors_dir = source .. '/colors'
        -- Check if directory exists before reading
        local exists = vim.fn.isdirectory(colors_dir)
        if exists ~= 0 then 
            local ok, files = pcall(vim.fn.readdir, colors_dir)
            if ok then
                for _, f in ipairs(files) do
                    if f:match('%.vim$') then
                        local cname = f:sub(1, #f - 4)
                        table.insert(colors, cname)
                    end
                end
            end
        end
    end

    -- Remove duplicate entries
    local unique_colors = {}
    for _, v in ipairs(colors) do
        unique_colors[v] = true
    end

    -- Convert back to list
    local final_colors = {}
    for k, _ in pairs(unique_colors) do
        table.insert(final_colors, k)
    end

    return final_colors
end

colorIndex = vim.fn.index(GetAllColorschemes(), vim.g.colors_name)

function NextColorscheme()
    local allColors = GetAllColorschemes()
    colorIndex = colorIndex + 1
    if colorIndex > #allColors then
        colorIndex = 1
    end

    vim.cmd('colorscheme ' .. allColors[colorIndex])
    print('[' .. colorIndex .. '/' .. #allColors .. ']:' .. allColors[colorIndex])
end

function PrevColorscheme()
    local allColors = GetAllColorschemes()

    colorIndex = colorIndex - 1
    if colorIndex <= 0 then
        colorIndex = #allColors 
    end

    vim.cmd('colorscheme ' .. allColors[colorIndex])
    print('[' .. colorIndex .. '/' .. #allColors .. ']:' .. allColors[colorIndex])
end

vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>b', ':echo system(findfile("build.sh", ";"))<CR>', { noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '<leader>d', ':echo system(findfile("buildrun.sh", ";"))<CR>', { noremap = true, silent = false})
vim.api.nvim_set_keymap('i', '<C-n>', '<C-x><C-o>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-G>', ':lua PrevColorscheme()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-H>', ':lua NextColorscheme()<CR>', {noremap = true, silent = true})

