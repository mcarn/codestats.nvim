local M = {}

local health = {
    start = vim.health.start,
    ok = vim.health.ok,
    warn = vim.health.warn,
    error = vim.health.error,
    info = vim.health.info,
}

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
    return next(table)
end

function M.check()
    health.start("codestats report")

    local status = check_setup()

    if empty(status) then
        health.ok("Setup is correct")
    else
        if contains(status, key) then
            health.error("Missing CODESTATS_API_KEY")
        end

        if contains(status, username) then
            health.error("Missing CODESTATS_USERNAME")
        end
    end
end

return M
