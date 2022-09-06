local ok, popup = require("plenary.popup")

if not ok then
    print("plenary not present")
    return
end

local M = {}

M.create_default_popup = function()
    local win_id = popup.create({ "menu 1", "menu 2" })
    print(win_id)
end

return M
