if not vim.api.nvim_buf_get_name(0):match("%.ipynb$") then
    return
end

-- Collect python code cell content ranges {start_line, end_line} (1-indexed)
local function get_code_cells()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local cells, in_cell, cell_start = {}, false, nil
    for i, line in ipairs(lines) do
        if not in_cell and line:match("^```%s*{?python") then
            in_cell, cell_start = true, i + 1
        elseif in_cell and line:match("^```%s*$") then
            if cell_start and i - 1 >= cell_start then
                table.insert(cells, { cell_start, i - 1 })
            end
            in_cell, cell_start = false, nil
        end
    end
    return cells
end

local function eval_cells(cells)
    for _, c in ipairs(cells) do
        vim.fn.setpos("'<", { 0, c[1], 1, 0 })
        vim.fn.setpos("'>", { 0, c[2], 999, 0 })
        vim.cmd("MoltenEvaluateVisual")
    end
end

local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = true, silent = true, desc = desc })
end

-- Output
map("n", "<localleader>os", ":noautocmd MoltenEnterOutput<CR>", "open output")
map("n", "<localleader>oh", ":MoltenHideOutput<CR>",            "hide output")
map("n", "<localleader>md", ":MoltenDelete<CR>",                "delete cell")
map("n", "<localleader>mx", ":MoltenOpenInBrowser<CR>",         "open output in browser")

-- Evaluate (operator / visual)
map("n", "<localleader>e", ":MoltenEvaluateOperator<CR>", "evaluate operator")
map("v", "<localleader>r", ":<C-u>MoltenEvaluateVisual<CR>gv", "evaluate visual")

-- Runner
map("n", "<localleader>rc", function()
    vim.cmd("MoltenEvaluateOperator")
    vim.api.nvim_feedkeys("ib", "m", false)
end, "run cell")

map("n", "<localleader>rl", ":MoltenEvaluateLine<CR>", "run line")

map("n", "<localleader>rr", ":MoltenReevaluateCell<CR>", "re-run cell")

map("n", "<localleader>ra", function()
    local cursor = vim.api.nvim_win_get_cursor(0)[1]
    local cells = vim.tbl_filter(function(c) return c[1] <= cursor end, get_code_cells())
    eval_cells(cells)
end, "run cell and above")

map("n", "<localleader>rA", function()
    eval_cells(get_code_cells())
end, "run all cells")
