local start = vim.health.start or vim.health.report_start
local ok = vim.health.ok or vim.health.report_ok
local info = vim.health.info or vim.health.report_info
local warn = vim.health.warn or vim.health.report_warn
local error = vim.health.error or vim.health.report_error

local function check_username ()
	local codestats_api_key = vim.env.CODESTATS_API_KEY
	if codestats_api_key== nil then
            error("Missing CODESTATS_API_KEY")
	    return false
	end
	return true
end

local function check_key ()
    local username = vim.env.CODESTATS_USERNAME
    if username == nil then
            error("Missing CODESTATS_USERNAME")
	    return false
    end
    return true
end

local M = {}

function M.check()
    start("codestats.nvim")

    local usernameStatus = check_username()
    local keyStatus = check_key()

    if keyStatus and usernameStatus then
        ok("Setup is correct")
    end
end

return M
