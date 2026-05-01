local start = vim.health.start or vim.health.report_start
local ok = vim.health.ok or vim.health.report_ok
local info = vim.health.info or vim.health.report_info
local warn = vim.health.warn or vim.health.report_warn
local error = vim.health.error or vim.health.report_error

local function check_version()
    if not vim.net or not vim.net.request then
        error("Neovim 0.12.0 or later required (vim.net.request not available)")
        return false
    end
    ok("Neovim version is compatible (0.12.0+)")
    return true
end

local function check_username()
    local username = vim.env.CODESTATS_USERNAME
    if not username or username == "" then
        error("Missing or empty CODESTATS_USERNAME environment variable")
        return false
    end
    ok("CODESTATS_USERNAME is set")
    return true
end

local function check_key()
    local codestats_api_key = vim.env.CODESTATS_API_KEY
    if not codestats_api_key or codestats_api_key == "" then
        error("Missing or empty CODESTATS_API_KEY environment variable")
        return false
    end
    ok("CODESTATS_API_KEY is set")
    return true
end

local M = {}

function M.check()
    start("codestats.nvim")

    local versionStatus = check_version()
    local usernameStatus = check_username()
    local keyStatus = check_key()

    if versionStatus and keyStatus and usernameStatus then
        ok("Setup is correct")
    end
end

return M
