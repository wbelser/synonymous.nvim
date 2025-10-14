local M = {}

-- Neovim health API (handles Neovim 0.9+ and older)
local health = vim.health or require("health")

-- Utility to safely run shell commands and capture output
local function safe_popen(cmd)
	local handle = io.popen(cmd)
	if not handle then
		return nil
	end
	local result = handle:read("*a")
	handle:close()
	return result
end

local function check_internet()
	local result = safe_popen("ping -c 1 8.8.8.8 >/dev/null 2>&1 && echo OK || echo FAIL")
	if not result then
		health.error("Failed to run ping command")
		return
	end
	if result:find("OK") then
		health.ok("Internet connection available")
	else
		health.error("No internet connection detected")
	end
end

local function check_curl()
	local result = safe_popen("command -v curl >/dev/null 2>&1 && echo OK || echo FAIL")
	if not result then
		health.error("Failed to check for `curl` command")
		return
	end
	if result:find("OK") then
		health.ok("`curl` command found")
	else
		health.error("`curl` command not found in PATH")
	end
end

local function check_datamuse()
	local result = safe_popen("curl -s -o /dev/null -w '%{http_code}' https://api.datamuse.com/words?ml=test")
	if not result then
		health.error("Failed to run curl for Datamuse API")
		return
	end
	local http_code = result:gsub("%s+", "") -- clean up trailing newline
	if http_code == "200" then
		health.ok("Datamuse API reachable (HTTP 200)")
	else
		health.error("Datamuse API not reachable (code: " .. http_code .. ")")
	end
end

function M.check()
	health.start("synonymous.nvim Health Check")
	check_internet()
	check_curl()
	check_datamuse()
end

return M
