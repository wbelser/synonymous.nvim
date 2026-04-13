local M = {}

local health = vim.health or require("health")

local function check_nvim_version()
	local v = vim.version()
	if v.major < 12 then
		health.error("Neovim 0.12+ is required (current: " .. v.major .. "." .. v.minor .. "." .. v.patch .. ")")
		return false
	end
	health.ok("Neovim version " .. v.major .. "." .. v.minor .. "." .. v.patch .. " (meets 0.12+ requirement)")
	return true
end

local function check_internet()
	local res = vim.net.request("https://api.datamuse.com")
	if not res or res.status ~= 200 then
		health.error("No internet connection detected")
		return
	end
	health.ok("Internet connection available")
end

local function check_datamuse()
	local res = vim.net.request("https://api.datamuse.com/words?ml=test")
	if not res or res.status ~= 200 then
		health.error("Datamuse API not reachable")
		return
	end
	health.ok("Datamuse API reachable (HTTP " .. res.status .. ")")
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
