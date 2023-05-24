local start = vim.health.start or vim.health.report_start
local ok = vim.health.ok or vim.health.report_ok
local info = vim.health.info or vim.health.report_info
local warn = vim.health.warn or vim.health.report_warn
local error = vim.health.error or vim.health.report_error

local key = "key"
local username = "username"

local function check_setup()
    local opts = {}

    local codestats_api_key = vim.env.CODESTATS_API_KEY
    if codestats_api_key == nil then
        table.insert(opts, key)
    end

    local username = vim.env.CODESTATS_USERNAME
    if username == nil then
        table.insert(opts, username)
    end

    return opts
end

local function contains(table, key)
    return table[key] ~= nil
end

local function empty(table)
    return next(table) == nil
end

local M = {}

function M.check()
    start("codestats.nvim")

    local status = check_setup()

    if empty(status) then
        ok("Setup is correct")
    else
        if contains(status, key) then
            error("Missing CODESTATS_API_KEY")
        end

        if contains(status, username) then
            error("Missing CODESTATS_USERNAME")
        end
    end
end

return M
