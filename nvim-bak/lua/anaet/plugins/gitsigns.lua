return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
      end

      -- Navigation
      map("n", "]h", gs.next_hunk, "Next Hunk")
      map("n", "[h", gs.prev_hunk, "Prev Hunk")

      -- Actions
      map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
      map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
      map("v", "<leader>hs", function()
        gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "Stage hunk")
      map("v", "<leader>hr", function()
        gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "Reset hunk")

      map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
      map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")

      map("n", "<leader>hu", gs.undo_stage_hunk, "Undo stage hunk")

      map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")

      map("n", "<leader>hb", function()
        gs.blame_line({ full = true })
      end, "Blame line")
      map("n", "<leader>hB", gs.toggle_current_line_blame, "Toggle line blame")

      map("n", "<leader>hd", gs.diffthis, "Diff this")
      map("n", "<leader>hD", function()
        gs.diffthis("~")
      end, "Diff this ~")

      -- Text object
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Gitsigns select hunk")
    end,
  },
}

-- {
--   "lewis6991/gitsigns.nvim",
--   event = "LazyFile",
--   opts = {
--     signs = {
--       add = { text = "▎" },
--       change = { text = "▎" },
--       delete = { text = "" },
--       topdelete = { text = "" },
--       changedelete = { text = "▎" },
--       untracked = { text = "▎" },
--     },
--     on_attach = function(buffer)
--       local gs = package.loaded.gitsigns
--
--       local function map(mode, l, r, desc)
--         vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
--       end
--
--       -- stylua: ignore start
--       map("n", "]h", gs.next_hunk, "Next Hunk")
--       map("n", "[h", gs.prev_hunk, "Prev Hunk")
--       map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
--       map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
--       map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
--       map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
--       map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
--       map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
--       map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
--       map("n", "<leader>ghd", gs.diffthis, "Diff This")
--       map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
--       map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
--     end,
--   },
-- }
