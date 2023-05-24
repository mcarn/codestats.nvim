local M = {}

local function check_setup()
    local opts = {}

    local codestats_api_key = vim.env.CODESTATS_API_KEY
    if codestats_api_key == nil then
        table.insert(opts, "key")
    end

    local username = vim.env.CODESTATS_USERNAME
    if username == nil then
        table.insert(opts, "username")
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
    vim.health.start("codestats report")

    local status = check_setup()

    if empty(status) then
        vim.health.ok("Setup is correct")
    else
        if contains(status, "key") then
            vim.health.error("Missing CODESTATS_API_KEY")
        end

        if contains(status, "username") then
            vim.health.error("Missing CODESTATS_USERNAME")
        end
    end
end

return M
