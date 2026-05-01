local popup = require("plenary.popup")
local base = require("codestats.base")
local request = require("codestats.request")

local curr_xp = 0
local total_xp = 0
local new_xp = 0
local xp_table = {}
local machines = {}
local langs = {}
local dates = {}

local M = {}

local function fetch(username)
    local ok, res = pcall(request.fetch, username)
    if not ok then
        vim.notify("Failed to fetch CodeStats data: " .. tostring(res), vim.log.levels.ERROR)
        return false
    end

    if not res then
        vim.notify("Empty response from CodeStats API", vim.log.levels.ERROR)
        return false
    end

    total_xp = res["total_xp"] or 0
    new_xp = res["new_xp"] or 0
    machines = res["machines"] or {}
    langs = res["languages"] or {}
    dates = res["dates"] or {}

    return true
end

local function create_window()
    local closer_ke = "q"

    local width = math.floor(vim.o.columns * 0.6)
    local heigth = math.floor(vim.o.lines * 0.6)

    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - heigth) / 2)

    local buff = vim.api.nvim_create_buf(false, true)

    local result = {}
    table.insert(result, string.format("Total XP: %s", total_xp))
    table.insert(result, string.format("New XP: %s", new_xp))

    vim.api.nvim_buf_set_lines(buff, 0, -1, false, result)
    vim.api.nvim_buf_set_option(buff, "modifiable", true)

    local win_id, _win = popup.create(result, {
        title = "Code::Stats",
        line = row,
        col = col,
        minwidth = width,
        minheigth = heigth,
        borderchars = {
            "─",
            "│",
            "─",
            "│",
            "╭",
            "╮",
            "╯",
            "╰",
        },
    })

    local new_buff = vim.api.nvim_win_get_buf(win_id)
    vim.api.nvim_buf_set_option(buff, "modifiable", true)

    vim.api.nvim_win_set_cursor(win_id, { #result, 0 })

    vim.api.nvim_buf_set_keymap(new_buff, "n", closer_ke, "", {
        noremap = true,
        silent = true,
        callback = function()
            vim.api.nvim_win_close(win_id, true)
        end,
    })
end

function M.create_default_popup(username)
    if not fetch(username) then
        return
    end

    create_window()
end

return M
