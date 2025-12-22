-- SPDX-License-Identifier: BSD-2-Clause
--
-- Copyright(c) 2025 The FreeBSD Foundation.
--
-- This software was developed by Tuukka Pasanen <tuukka.pasanen@ilmi.fi>
-- under sponsorship from the FreeBSD Foundation.
--
-- Functions handling ports make command output. One can have them as
-- raw with ports_make.target or as array (separate line by line)
-- ports_make.target_as_table. Target should be some FreeBSD ports make
-- targets.
--
-- example:
-- local Logging = require("logging")
-- logger = Logging.new(nil, "DEBUG", true)
-- require("ports-make")
--
-- output = ports_make.target("describe")
--
-- print(output)
--
-- output_table = ports_make.target_as_table("describe-json")
--
-- for _, cur_string in ipairs(output_table) do
--        print("Output line: [" .. cur_string .. "]")
-- end
--
-- This can be excuted under FreeBSD 14.3 and later with:
-- LUA_PATH="/usr/ports/Mk/LuaScripts/?.lua;;" /usr/libexec/flua /usr/ports/Mk/LuaScripts/example.lua

local ports_make = {}
local Logging = require("logging")
local logger = Logging.new(nil, "INFO")

-------------------------------------------------------------------------------
-- Splits string with separator
-- @param inputstr String to be splitter
-- @param sep Separator
-- @return Table with splitted values
-------------------------------------------------------------------------------
function ports_make.split_string(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local rtn_table = {}
	for part in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		table.insert(rtn_table, part)
	end
	return rtn_table
end

-------------------------------------------------------------------------------
-- Call make with target
-- @param target String to be splitter
-- @return Stdout outpout of make-command
-------------------------------------------------------------------------------
function ports_make.target(target)
	if logger ~= nil then
		logger:debug("Run make target: '" .. target .. "'")
	end
	local handle = io.popen("make " .. target)
	local output = ""
	if handle ~= nil then
		output = handle:read("*a")
		handle:close()
	end
	return output
end

-------------------------------------------------------------------------------
-- Call make with target and add it line by line to table
-- @param target String to be splitter
-- @return Table line by line output of make-command
-------------------------------------------------------------------------------
function ports_make.target_as_table(target)
	local output = ports_make.target(target)
	return ports_make.split_string(output, "\n")
end

return ports_make
