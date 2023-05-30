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

local function fetch(url, username)
    local res = request.fetch(url, username)

    local json = vim.json.decode(res)
    total_xp = json["total_xp"]
    new_xp = json["new_xp"]
    machines = json["machines"]
    langs = json["languages"]
    dates = json["dates"]
end

local function create_default_popup()
    fetch(base.url, "mcarnerm")
    local result = {}
    table.insert(result, "Total XP")
    table.insert(result, total_xp)
    table.insert(result, "New XP")
    table.insert(result, new_xp)

    local win_id = popup.create(
        result,
        { title = "Code::Stats", relative = "editor", col = 0, minwidth = 20, border = true, highlight = PopupColor }
    )
    print(win_id)
end

create_default_popup()
