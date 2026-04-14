local M = {}

local health = vim.health or require("health")

local function check_nvim_version()
	local v = vim.version()
	if v.major == 0 and v.minor < 12 then
		health.error("Neovim 0.12+ is required (current: " .. v.major .. "." .. v.minor .. "." .. v.patch .. ")")
		return false
	end
	health.ok("Neovim version " .. v.major .. "." .. v.minor .. "." .. v.patch .. " (meets 0.12+ requirement)")
	return true
end

local function check_internet()
	local ok, res = pcall(vim.net.request, "https://httpbin.org/get")
	if not ok then
		health.error("Network request failed: " .. tostring(res))
		return
	end
	if not res then
		health.error("No response from server (connection refused/timeout/DNS error)")
		return
	end
	local status = res.status or res.code
	if not status or status < 200 or status >= 400 then
		health.error("Internet unavailable (HTTP status: " .. tostring(status or "nil") .. ")")
		return
	end
	health.ok("Internet connection available")
end

local function check_datamuse()
	local ok, res = pcall(vim.net.request, "https://api.datamuse.com/words?ml=test")
	if not ok then
		health.error("Datamuse API request failed: " .. tostring(res))
		return
	end
	if not res then
		health.error("Datamuse API unreachable (connection refused/timeout/DNS error)")
		return
	end
	local status = res.status or res.code
	if not status or status < 200 or status >= 400 then
		health.error("Datamuse API not reachable (HTTP status: " .. tostring(status or "nil") .. ")")
		return
	end
	health.ok("Datamuse API reachable (HTTP " .. status .. ")")
end

function M.check()
	health.start("synonymous.nvim Health Check")

	if not check_nvim_version() then
		return
	end

	check_internet()
	check_datamuse()
end

return M
