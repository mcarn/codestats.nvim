local base = require("codestats.base")

local url = base.url
local M = {}

local REQUEST_TIMEOUT_MS = 5000

if not vim.net or not vim.net.request then
    error("codestats.nvim requires Neovim 0.12.0 or later (vim.net.request not available)")
end

local function request_sync(method, endpoint, headers, body)
    local done = false
    local result = nil
    local error_msg = nil

    vim.net.request({
        url = url .. endpoint,
        method = method,
        headers = headers,
        body = body,
    }, function(err, response)
        if err then
            error_msg = err
        else
            if response.status >= 200 and response.status < 300 then
                local ok, decoded = pcall(vim.json.decode, response.body)
                if ok then
                    result = decoded
                else
                    error_msg = "Failed to decode response: " .. decoded
                end
            else
                error_msg = string.format("HTTP %d: %s", response.status, response.body or "")
            end
        end
        done = true
    end)

    vim.wait(REQUEST_TIMEOUT_MS, function()
        return done
    end)

    if error_msg then
        error("Request failed: " .. error_msg)
    end

    return result
end

M.fetch = function(username)
    if not username or username == "" then
        error("username cannot be empty")
    end

    return request_sync("GET", "/users/" .. vim.fn.escape(username, "/"), {
        ["Accept"] = "application/json",
        ["Content-Type"] = "application/json",
    }, nil)
end

M.push = function(key, payload)
    if not key or key == "" then
        error("API key cannot be empty")
    end
    if not payload or payload == "" then
        error("payload cannot be empty")
    end

    return request_sync("POST", "/my/pulses", {
        ["Accept"] = "application/json",
        ["Content-Type"] = "application/json",
        ["X-API-Token"] = key,
    }, payload)
end

return M
