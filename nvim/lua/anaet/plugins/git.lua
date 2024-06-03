return {{
        'lewis6991/gitsigns.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = 'nvim-lua/plenary.nvim',
        config = function()
            require('gitsigns').setup({
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map('n', '<leader>gn', function()
                        if vim.wo.diff then
                            return '<leader>gn'
                        end
                        vim.schedule(function()
                            gs.next_hunk()
                        end)
                        return '<Ignore>'
                    end, { expr = true, desc = 'Gitsigns Next Hunk' })

                    map('n', '<leader>gN', function()
                        if vim.wo.diff then
                            return '<leader>gN'
                        end
                        vim.schedule(function()
                            gs.prev_hunk()
                        end)
                        return '<Ignore>'
                    end, { expr = true, desc = 'Gitsigns Previous Hunk' })

                    -- Actions
                    map('n', '<leader>gs', gs.stage_hunk, { desc = 'Gitsigns Stage Hunk' })
                    map('n', '<leader>gr', gs.reset_hunk, { desc = 'Gitsigns Reset Hunk' })
                    map('v', '<leader>gs', function()
                        gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                    end, { desc = 'Gitsigns Stage Hunk' })
                    map('v', '<leader>gr', function()
                        gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                    end, { desc = 'Gitsigns Reset Hunk' })
                    map('n', '<leader>gS', gs.stage_buffer, { desc = 'Gitsigns Stage Buffer' })
                    map('n', '<leader>gu', gs.undo_stage_hunk, { desc = 'Gitsigns Undo Stage Buffer' })
                    map('n', '<leader>gR', gs.reset_buffer, { desc = 'Gitsigns Reset Buffer' })
                    map('n', '<leader>gp', gs.preview_hunk, { desc = 'Gitsigns Preview Hunk' })
                    map('n', '<leader>gB', function()
                        gs.blame_line({ full = true })
                    end, { desc = 'Gitsigns Blame Line Full' })
                    map('n', '<leader>gb', gs.toggle_current_line_blame, { desc = 'Gitsigns Current Blame Line' })
                    map('n', '<leader>gd', gs.diffthis, { desc = 'Gitsigns Hunk Diffthis' })
                    map('n', '<leader>gD', function()
                        gs.diffthis('~')
                    end, { desc = 'Gitsigns Hunk Diffthis' })
                    map('n', '<leader>gt', gs.toggle_deleted, { desc = 'Gitsigns Git Toggle deleted lines' })

                    -- Text object
                    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
                end,
            })
        end,
    }}
