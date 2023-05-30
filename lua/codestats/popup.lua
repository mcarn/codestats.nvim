local popup = require("plenary.popup")
local request = require"codestats.request"

local curr_xp = 0
local total_xp = 0
local new_xp = 0
local xp_table = {}
local machines = {}
local langs = {}
local dates = {}

local base = {
    version = "0.3.0",
    url = "https://codestats.net/api",
}

local function fetch(version, url, username)
    local res = request.fetch(version, url, username)

    local json = vim.json.decode(res)
    total_xp = json["total_xp"]
    new_xp = json["new_xp"]
    machines = json["machines"]
    langs = json["languages"]
    dates = json["dates"]
end

local function create_default_popup()
	fetch(1, "",mcarnerm")
    local win_id, popup_state = popup.create(
        { "menu 1", "menu 2" },
        { title = "Code::Stats", relative = "editor", col = 0, minwidth = 20, border = true, highlight = PopupColor }
    )
    print(win_id)
end

create_default_popup()
