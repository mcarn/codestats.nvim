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

local function fetch(username)
    local res = request.fetch(username)

    total_xp = res["total_xp"]
    new_xp = res["new_xp"]
    machines = res["machines"]
    langs = res["languages"]
    dates = res["dates"]
end

local function create_default_popup()
    fetch("mcarnerm")
    local result = {}
    table.insert(result, string.format("Total XP: %s", total_xp))
    table.insert(result, string.format("New XP: %s", new_xp))

    local win_id = popup.create(result, {
        title = "Code::Stats",
        relative = "editor",
        col = 0,
        minwidth = 20,
        border = true,
    })
    print(win_id)
end

create_default_popup()
