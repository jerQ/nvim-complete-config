-- ~/.config/nvim-new/lua/keymaps.lua
local keymap = vim.keymap.set
local s = { silent = true }

vim.g.mapleader = " "

keymap("n", "<space>", "<Nop>")


-- Move down, but use 'gj' if no count is given
keymap("n", "j", function()
    return tonumber(vim.api.nvim_get_vvar("count")) > 0 and "j" or "gj"
end, { expr = true, silent = true }) 

-- Move up, but use 'gk' if no count is given
keymap("n", "k", function()
    return tonumber(vim.api.nvim_get_vvar("count")) > 0 and "k" or "gk"
end, { expr = true, silent = true }) 

-- Scroll down and center the cursor
keymap("n", "<C-d>", "<C-d>zz") 

-- Scroll up and center the cursor
keymap("n", "<C-u>", "<C-u>zz") 

-- Save the current file
keymap("n", "<Leader>w", "<cmd>w!<CR>", s) 

-- Quit Neovim
keymap("n", "<Leader>q", "<cmd>q<CR>", s) 

-- Open a new tab
keymap("n", "<Leader>te", "<cmd>tabnew<CR>", s) 

-- Split the window vertically
keymap("n", "<Leader>_", "<cmd>vsplit<CR>", s) 

-- Split the window horizontally
keymap("n", "<Leader>-", "<cmd>split<CR>", s) 

-- Format the current buffer using LSP
keymap("n", "<Leader>fo", ":lua vim.lsp.buf.format()<CR>", s) 

-- Paste without overwriting the default register
keymap("v", "<Leader>p", '"_dP') 

-- Yank to the system clipboard in visual mode
keymap("x", "y", [["+y]], s) 

-- Exit terminal mode
keymap("t", "<Esc>", "<C-\\><C-N>") 

-- Change directory to the current file's directory
keymap("n", "<leader>cd", '<cmd>lua vim.fn.chdir(vim.fn.expand("%:p:h"))<CR>')

local opts = { noremap = true, silent = true }
keymap("n", "grd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts) -- Go to definition


-- Update plugins
keymap("n", "<leader>ps", '<cmd>lua vim.pack.update()<CR>')


-- Netrw
keymap("n", "<Leader>ex", "<cmd>Ex %:p:h<CR>") -- Open Netrw in the current file's directory


-- Misc
vim.api.nvim_create_autocmd("FileType", {
    pattern = "netrw",
    callback = function()
        local bs = { buffer = true, silent = true }
        local bsr = { buffer = true, remap = true, silent = true }
        vim.keymap.set('n', '<C-c>', '<cmd>bd<CR>', bs) -- Close the current Netrw buffer
        vim.keymap.set('n', '<Tab>', 'mf', bsr) -- Mark the file/directory to the mark list
        vim.keymap.set('n', '<S-Tab>', 'mF', bsr) -- Unmark all the files/directories
        -- Improved file creation
        vim.keymap.set('n', '%', function()
            local dir = vim.b.netrw_curdir or vim.fn.expand('%:p:h')
            vim.ui.input({ prompt = 'Enter filename: ' }, function(input)
                if input and input ~= '' then
                    local filepath = dir .. '/' .. input
                    vim.cmd('!touch ' .. vim.fn.shellescape(filepath))
                    vim.api.nvim_feedkeys('<C-l>', 'n', false)
                end
            end)
        end, { buffer = true, silent = true })
end
})


-- fzf-lua
-- ~/.config/nvim-new/lua/keymaps.lua
keymap("n", "<leader>ff", '<cmd>FzfLua files<CR>')
keymap("n", "<leader>fg", '<cmd>FzfLua live_grep<CR>')


-- Fugitive
-- ~/.config/nvim-new/lua/keymaps.lua
keymap("n", "<leader>gs", '<cmd>Git<CR>', opts)
keymap("n", "<leader>gp", '<cmd>Git push<CR>', opts)


-- Miniharp
-- Might want to use Harpoon instead
keymap("n", "<leader>m", '<cmd>lua require("miniharp").toggle_file()<CR>')
keymap("n", "<leader>l", '<cmd>lua require("miniharp").show_list()<CR>')
keymap("n", "<C-n>", require("miniharp").next)
keymap("n", "<C-p>", require("miniharp").prev)

