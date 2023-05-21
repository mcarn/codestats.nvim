local popup = require("plenary.popup")

local function create_default_popup()
    local win_id = popup.create(
        { "menu 1", "menu 2" },
        {title="Code::Stats",
		relative="editor", col = 0, minwidth = 20, border = true, highlight = PopupColor }
    )
    print(win_id)
end

create_default_popup()
