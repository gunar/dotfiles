local naughty = require("naughty")

local notifications = {}

function notify(id, title, text)
	if (notifications[id] == nil) then
		notifications[id] = naughty.notify({
			title = title,
			text = text,
			timeout = 1,
			destroy = function()
				notifications[id] = nil
			end
		})
	else
		naughty.reset_timeout(notifications[id])
		naughty.replace_text(notifications[id], title, text)
	end
end

return notify
