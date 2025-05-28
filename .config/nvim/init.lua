-- Settings
vim.opt.number = true
vim.opt.cursorline = true

vim.opt.foldmethod = "syntax"
vim.opt.foldlevelstart = 9999

vim.opt.completeopt:append { "fuzzy", "menuone", "noselect" }

vim.cmd.colorscheme "sorbet"

vim.g.loaded_perl_provider = 0

vim.diagnostic.config({
    virtual_text = true,
    current_line = false,
    virtual_lines = true,
})


-- Personal spacing preferences
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true


-- Mappings
vim.keymap.set('i', 'jk', '<Esc>') -- bad habit
vim.keymap.set('n', 'gh', '^')
vim.keymap.set('n', 'gl', '$')
vim.keymap.set('n', 'gj', 'G')
vim.keymap.set('n', 'gk', 'gg')
vim.keymap.set('n', '<C-j>', 'gj<C-e>')
vim.keymap.set('n', '<C-k>', 'gk<C-y>')
vim.keymap.set('n', '<Tab>', '<C-6>')
vim.keymap.set('n', '<C-s>', '<Cmd>write<CR>')
vim.keymap.set('n', '<Leader>n', '<Cmd>set number!<CR>')


-- Autocommands
local mygroup = vim.api.nvim_create_augroup('my_init_lua', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function() vim.highlight.on_yank() end,
    group = mygroup,
    desc = "Briefly highlight yanked text"
})

vim.api.nvim_create_autocmd('BufReadPost', {
    pattern = "*",
    callback = function(args)
        if vim.o.filetype == "gitcommit" then return end
        local line, col = unpack(vim.api.nvim_buf_get_mark(args.buf, '`'))
        if line < 1 then return end
        if line > vim.api.nvim_buf_line_count(args.buf) then return end
        vim.api.nvim_win_set_cursor(0, {line, col})
    end,
    group = mygroup,
    desc = "Jump to the last known cursor position"
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end,
    group = mygroup,
    desc = "Enbale builtin auto-completion with LSP"
})
