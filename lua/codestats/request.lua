local curl = require("plenary.curl")

--- request module
-- @module request
-- @alias M

local M = {}

--- fetches the username data
-- @param version codestats version
-- @param url codestats url
-- @param username codestats username
-- @return a table of all user data
M.fetch = function(version, url, username)
    local res = curl.get(url .. "/users/" .. username, {
        accept = "application/json",
        headers = {
            ["Content-Type"] = "application/json",
        },
    })
    return vim.json.decode(res.body)
end

--- pushes the username data
-- @param key codestats api key
-- @param version codestats version
-- @param url codestats url
-- @param payload user data
-- @return ok object
M.push = function(key, version, url, payload)
    local res = curl.post(url .. "/my/pulses", {
        accept = "application/json",
        headers = {
            ["Content-Type"] = "application/json",
            ["X-API-Token"] = key,
        },
        body = payload,
    })
    return vim.json.decode(res.body)
end

return M
