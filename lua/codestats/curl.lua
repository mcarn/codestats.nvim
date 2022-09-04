local curl = require("plenary.curl")
local M = {}

function M.pulse(payload)
	local cmd = {
		'curl',
		'--header', 'Content-Type: application/json',
		'--header', 'X-API-Token: ' .. CODESTATS_API_KEY,
		'--user-agent', 'codestats.nvim/' .. CODESTATS_VERSION,
		'--data', payload,
		'--request', 'POST',
		'--silent',
		'--output', '/dev/null',
		'--write-out', '%{http_code}',
		CODESTATS_API_URL .. '/my/pulses'
	}

	return vim.fn.system(cmd)
end

function M.fetch(username)
	local url = CODESTATS_API_URL .. '/users/' .. username
	local method = 'get'
	local accept = 'application/json'
	local response = 	curl.request(url, method,accept)
	print(response)
	return response
end
return M
