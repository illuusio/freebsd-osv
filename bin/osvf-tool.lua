#!/usr/libexec/flua

-- SPDX-License-Identifier: BSD-2-Clause
--
-- Copyright(c) 2025 The FreeBSD Foundation.
--
-- This software was developed by Tuukka Pasanen <tuukka.pasanen@ilmi.fi>
-- under sponsorship from the FreeBSD Foundation.
--
-- Tool can be used for validating OSVf files against schema and
-- merging JSON files in one big array of OSVf files (and validate
-- them all)
--
-- !! Heavy WIP warning !!
--

local Logging = require("logging")
local ucl = require("ucl")

require("ports-make")

-- FreeBSD Officially supported Schema
local osvf_schema_url =
	"https://raw.githubusercontent.com/ossf/osv-schema/094e5ca4fdf4b115bbdaaaf519b4c20809661ee2/validation/schema.json"
local logger = Logging.new(nil, "INFO")
local schema_file_location = ""
local schema_remoce = false
local osvf_files_location = "../vuln"

-------------------------------------------------------------------------------
-- Validate OSVf JSON against OSVf schema. This is done using libUCL
-- validation.
-- @param schema_location Schema to use for validation
-- @param package_name JSON file to validate
-- @return False is not valid and true is it's correct OSVf 1.7.0 file
-------------------------------------------------------------------------------
local function osvf_tool_validate(schema_location, json_location)
	local parser = ucl.parser()
	local is_error, err = parser:parse_file(json_location)

	if is_error == false then
		logger:error("osvf_tool_validate: Can't parse OSVf JSON file: " .. err)
		return false
	end

	is_error, err = parser:validate(schema_location)

	if is_error == false then
		logger:error("osvf_tool_validate: Can't validate OSVf JSON file with '" .. schema_location .. "': " .. err)
		logger:error("osvf_tool_validate: Please see schema at: " .. osvf_schema_url)
		return false
	end

	return true
end

-------------------------------------------------------------------------------
-- Does file exist and can it be opened and read
-- @param filename Filename to be checked
-- @return False if file does not exist and true is it does
-------------------------------------------------------------------------------
local function osvf_tool_file_exist(filename)
	local is_present = true
	-- Opens a file
	hanle = io.open(filename)

	-- if file is not present, f will be nil
	if not handle then
		isPresent = false
	else
		-- close the file
		hanle:close()
	end

	-- return status
	return is_present
end

-------------------------------------------------------------------------------
-- Run command and return output
-- @param command Command to be run
-- @return Output of command
-- @return True if success and false if not
-------------------------------------------------------------------------------
local function osvf_tool_run_cmd(command)
	logger:debug("Run make command: '" .. command .. "'")
	local handle = io.popen(command)
	local output = handle:read("*a")
	rtn_value = handle:close()
	return output, rtn_value
end

-------------------------------------------------------------------------------
-- Download OSVf schema to temp location with curl or fetch command
-- @return True if schema was downloaded and false if not
-- @return Location of downloaded schema or nil if it couldn't
-------------------------------------------------------------------------------
local function osvf_tool_get_schema()
	tmp_file_location = os.tmpname()
	logger:debug("Output file to: " .. tmp_file_location)
	local output = ""
	local rc = false

	if osvf_tool_file_exist("/usr/bin/curl") then
		output, rc =
			osvf_tool_run_cmd("/usr/bin/curl -o " .. tmp_file_location .. " " .. osvf_schema_url .. " 2> /dev/null")
	elseif osvf_tool_file_exist("/usr/bin/fetch") then
		logging:error("Fetch is not working yet!")
		return false, nil
	else
		logging:error("Can't locate '/usr/bin/curl' or '/usr/bin/fetch' from '/usr/bin'")
		return false, nil
	end

	if rc == false then
		logger:error("Can't download: " .. osvf_schema_url)
		return false, nil
	end

	return true, tmp_file_location
end

local function oscf_tool_find_file(osv_location)
	local output, rc = osvf_tool_run_cmd("find " .. osv_location .. " -type f -name '*.json' | sort -r")

	if rc == false then
		logger:error("Something went wrong with find in '" .. osv_location .. "'. Exiting")
		return nil
	end

	return ports_make_split_string(output, "\n")
end

local function oscf_tool_ls_last(osv_location)
	local output, rc = osvf_tool_run_cmd("ls -1 " .. osv_location .. " | sort -r")

	if rc == false then
		logger:error("Something went wrong with ls in '" .. osv_location .. "'. Exiting")
		return nil
	end

	return ports_make_split_string(output, "\n")
end

-------------------------------------------------------------------------------
-- Download schema from git or use existing one if provided
-- @param schema_location Schema location or nil wanted to download it
-- @return True if succesfully merged files and false if not
-------------------------------------------------------------------------------
local function osvf_tool_download_schema(schema_location)
	local schema_remove = false
	local file_location = schema_location

	if schema_location == nil then
		is_success, file_location = osvf_tool_get_schema()
		schema_remove = true

		if is_success == false then
			logger:error("Can't donwload schema file: '" .. osvf_schema_url .. "'. Exiting")
			return false
		end
	else
		if osvf_tool_file_exist(schema_location) == false then
			logger:error("Can't find schema file: '" .. schema_location .. "'. Exiting")
			return false
		end

		is_success = true
		schema_remove = false
	end

	return schema_remove, file_location
end

-------------------------------------------------------------------------------
-- Remove schema if wanted or bail out
-- @param schema_location Schema location or nil wanted to download it
-- @param schema_remove Remove schmea if true. Do nothing if false
-- @return True if succesfully merged files and false if not
-------------------------------------------------------------------------------
local function osvf_tool_remove_schema(schema_location, schema_remove)
	if not schema_remove then
		return true
	end

	if osvf_tool_file_exist(schema_location) then
		logging:error("Can't find schema to remove: " .. schema_location)
		return false
	end

	if schema_remove then
		local success, err = os.remove(schema_location)

		if success == false then
			logger:error("Can't delete tmp schema file: '" .. file_location .. "' (" .. err .. ")")
			return false
		end
	end

	return true
end

-------------------------------------------------------------------------------
-- Validate all files all together from directory
-- @param schema_location Schema location or nil wanted to download it
-- @param osv_location Directory location of OSVf JSON files
-- @return True if succesfully merged files and false if not
-------------------------------------------------------------------------------
local function osvf_tool_validate_osvf_files(schema_location, osv_location)
	local find_table = oscf_tool_find_file(osv_location)

	if find_table == nil then
		logger:error("Something went wrong with find in '" .. osv_location .. "'. Exiting")
		return false
	end

	local schema_remove, file_location = osvf_tool_download_schema(schema_location)
	local is_valid = false

	for find_table_pos, json_file in ipairs(find_table) do
		is_valid = osvf_tool_validate(file_location, json_file)

		if is_valid == false then
			logger:error("Can't validate file: '" .. json_file .. "'. Exiting")
			break
		end
	end

	osvf_tool_remove_schema(file_location, schema_remove)

	return is_valid
end

-------------------------------------------------------------------------------
-- Merge OSVf files together in one big JSON array and validate files when
-- merging them
-- Function does not make any other loading for JSON after validation. JSON
-- files are just pasted as if as they are valid.
-- @param schema_location Schema location or nil wanted to download it
-- @param osv_location Directory location of OSVf JSON files
-- @return True if succesfully merged files and false if not
-- @return Merged OSVf array as a string
-------------------------------------------------------------------------------
local function osvf_tool_merge_osvf_files(schema_location, osv_location)
	local find_table = oscf_tool_find_file(osv_location)

	if find_table == nil then
		logger:error("Something went wrong with find in '" .. osv_location .. "'. Exiting")
		return false, nil
	end

	local schema_remove, file_location = osvf_tool_download_schema(schema_location)

	local output_table = { "[\n" }
	local output_table_pos = 1

	-- Go thru every file that find have finded
	for find_table_pos, output_str in ipairs(find_table) do
		local pos = 1
		-- Validate file and make sure it can be loaded as JSON and
		-- it's valid OSVf 1.7.0 file. If not then don't go further
		if osvf_tool_validate(file_location, output_str) == false then
			logger:error("Can't validate: " .. output_str)
			return false, nil
		end
		local file_hanle = assert(io.open(output_str, "rb"))
		local content = file_hanle:read("*all")
		file_hanle:close()

		local content_table = ports_make_split_string(content, "\n")

		-- Add files content to be part of merged JSON array variable
		-- which is returned
		for pos, content_str in ipairs(content_table) do
			local comma_str = ""
			output_table_pos = output_table_pos + 1
			if pos == #content_table and find_table_pos < #find_table then
				comma_str = ","
			end

			output_table[output_table_pos] = "    " .. content_str .. comma_str .. "\n"
		end
	end

	osvf_tool_remove_schema(file_location, schema_remove)

	output_table[output_table_pos + 1] = "]\n"

	return true, table.concat(output_table)
end

-------------------------------------------------------------------------------
-- Convert JSON file to commonmark (Markdown)
-- @param json_location JSON location to convert
-- @return Commonmark prepresentation of JSON
-------------------------------------------------------------------------------
local function osvf_tool_convert_to_commonmark(json_location)
	local parser = ucl.parser()
	local is_error, err = parser:parse_file(json_location)

	if is_error == false then
		logger:error("osvf_tool_convert_to_commonmark: Can't parse OSVf JSON file: " .. err)
		return false
	end

	local obj = parser:get_object()
	local rtn_str = "# " .. obj["summary"] .. "\n"
	rtn_str = rtn_str .. obj["details"] .. "\n\n"

	rtn_str = rtn_str .. "## Affected packages\n"
	for find_table_pos, aff_table in ipairs(obj["affected"]) do
		rtn_str = rtn_str .. " - " .. "**" .. aff_table["package"]["name"] .. "**\n"
		if aff_table["ranges"] ~= nil then
			for find_table_pos, range_table in ipairs(aff_table["ranges"]) do
				for find_table_pos, event_table in ipairs(range_table["events"]) do
					if event_table["fixed"] ~= nil then
						rtn_str = rtn_str .. "    - **Fixed:** " .. event_table["fixed"] .. "\n"
					elseif event_table["introduced"] ~= nil and event_table["introduced"] ~= "0" then
						rtn_str = rtn_str .. "    - **Introduced:** " .. event_table["introduced"] .. "\n"
					end
				end
			end
		end
	end
	rtn_str = rtn_str .. "\n"

	rtn_str = rtn_str .. "## Details\n"
	rtn_str = rtn_str .. " - **published**: " .. obj["published"] .. "\n"
	rtn_str = rtn_str .. " - **modified**: " .. obj["modified"] .. "\n"
	if obj["database_specific"] ~= nil then
		if obj["database_specific"]["discovery"] ~= nil then
			rtn_str = rtn_str .. " - **discovery**: " .. obj["database_specific"]["discovery"] .. "\n"
		end
		if obj["database_specific"]["vid"] ~= nil then
			rtn_str = rtn_str
				.. " - **vid**: ["
				.. obj["database_specific"]["vid"]
				.. "](https://vuxml.freebsd.org/freebsd/"
				.. obj["database_specific"]["vid"]
				.. ".html)\n"
		end
	end
	rtn_str = rtn_str .. "\n"

	rtn_str = rtn_str .. "## References\n"

	for find_table_pos, ref_table in ipairs(obj["references"]) do
		rtn_str = rtn_str
			.. " - "
			.. ref_table["type"]
			.. ": ["
			.. ref_table["url"]
			.. "]("
			.. ref_table["url"]
			.. ")\n"
	end
	return rtn_str
end

-------------------------------------------------------------------------------
-- Convert all JSON file to Commonmark
-- @param osv_location Directory location of OSVf JSON files
-- @param output_dir Dir to output commonmark .md files
-- @return True if succesfully merged files and false if not
-------------------------------------------------------------------------------
local function osvf_tool_generate_commonmark(osv_location, output_dir)
	local find_table = oscf_tool_find_file(osv_location)

	if find_table == nil then
		logger:error("Something went wrong with find in '" .. osv_location .. "'. Exiting")
		return false
	end

	for find_table_pos, output_str in ipairs(find_table) do
		local commonmark_str = osvf_tool_convert_to_commonmark(output_str)
		local cut_dir = output_dir .. output_str:match(osv_location .. "(.*/).*%.json")
		local cut_file = output_str:match(osv_location .. ".*/(.*)%.json")
		commonmark_file = cut_dir .. cut_file .. ".md"

		local output, rc = osvf_tool_run_cmd("mkdir -p " .. cut_dir)

		if rc == false then
			logger:error("Something went wrong with mkdir -p with '" .. cut_dir .. "'. Exiting")
			return false
		end

		output_handle = io.open(commonmark_file, "w")

		if output_handle == nil then
			logger:error("Can't open file: '" .. commonmark_file .. "' for output")
		else
			output_handle:write(commonmark_str)
			output_handle:close()
		end
	end

	return true
end

-------------------------------------------------------------------------------
-- Add new entry to database
-- @param osv_location Directory location of OSVf JSON files
-- @return True if succesfully added ID and false if not
-- @return output name or nil if something goes wrong
-------------------------------------------------------------------------------
local function osvf_tool_new_entry(osv_location)
	local cur_year = os.date("%Y")
	local output_dir = osv_location .. "/" .. cur_year

	ls_table = oscf_tool_ls_last(output_dir)
	cur_num = 1
	cur_output_file = "FreeBSD-" .. cur_year .. "-" .. cur_num .. ".json"

	if ls_table[1] ~= nil then
		cur_num_str = ls_table[1]:match("FreeBSD%-" .. cur_year .. "%-(%d+)%.json")
		cur_num = tonumber(cur_num_str) + 1
		cur_output_file = "FreeBSD-" .. cur_year .. "-" .. string.format("%04d", cur_num)
	else
		local output, rc = osvf_tool_run_cmd("mkdir -p " .. output_dir)

		if rc == false then
			logger:error("Something went wrong with mkdir -p with '" .. output_dir .. "'. Exiting")
			return false, nil
		end
	end

	local parser = ucl.parser()
	local is_error, err = parser:parse_file("tmpl/FreeBSD-tmpl.json")

	if is_error == false then
		logger:error("osvf_tool_new_entry: Can't parse OSVf JSON file: " .. err)
		return false, nil
	end

	local obj = parser:get_object()

	local date_full = os.date("%Y-%m-%dT%XZ")

	obj["published"] = date_full
	obj["published"] = date_full
	obj["database_specific"]["discovery"] = date_full
	obj["id"] = cur_output_file

	local output, rc = osvf_tool_run_cmd("mkdir -p " .. output_dir)

	if rc == false then
		logger:error("Something went wrong with mkdir -p with '" .. output_dir .. "'. Exiting")
		return false, nil
	end

	json_output = ucl.to_format(obj, "json")
	output_filename = output_dir .. "/" .. cur_output_file .. ".json"
	output_handle = io.open(output_filename, "w")

	if output_handle == nil then
		logger:error("Can't open file: '" .. output_filename .. "' for output")
		return false, nil
	else
		output_handle:write(json_output)
		output_handle:close()
	end

	return true, output_filename
end

if #arg == 0 then
	print("Usage:\tosvf-tool.lua validate|newentry|merge|commonmark|html\n")
	print("\tvalidate\tValidate lastes entry or if last option is JSON file use that one\n")
	print("\t\t\tExample: osvf-tool.lua validate")
	print("\t\t\tWill validate all files in vuln directory\n")
	print("\t\t\tExample: osvf-tool.lua validate vuln/2025/FreeBSD-2025-0001.json")
	print("\t\t\tWill validate only file: 'vuln/2025/FreeBSD-2025-0001.json'\n")

	print("\tnewentry\tCreate new entry and set ID for it.\n")
	print("\t\t\tExample: osvf-tool.lua newentry")
	print("\t\t\tCreate new entry with next ID which is available\n")

	print("\tmerge\tMerge all files to one JSON array and print to stdout\n")
	print("\t\t\tExample: osvf-tool.lua merge")
	print("\t\t\tWill print merged JSON array to stdout\n")
	print("\t\t\tExample: osvf-tool.lua merge > db/freebsd-osv.db")
	print("\t\t\tWill direct merged OSV JSON array to db/freebsd-osv.db\n")

	print("\tcommonmark\tExport JSON files from vuln-dir to Commonmark files in md-dir\n")
	print("\t\t\tExample: osvf-tool.lua commonmark")
	print("\t\t\tWill export all files as Commonmark files\n")

	os.exit(1)
end

local commands = {
	validate = 1,
	newentry = 2,
	merge = 3,
	commonmark = 4,
	html = 5,
}

local which_command = commands[arg[1]]

if which_command == 1 then
	is_valid = osvf_tool_validate_osvf_files("schema/osvf_schema-1.7.4.json", "vuln")

	if is_valid == true then
		print("All OSVf JSON files are valid inside vuln-directory")
	else
		print("Validation of OSVf JSON files didn't succeeded please see error(s)")
	end
elseif which_command == 2 then
	is_error, output_name = osvf_tool_new_entry("vuln")

	if is_error == true then
		print("New entry file: " .. output_name)
	end
elseif which_command == 3 then
	is_error, output = osvf_tool_merge_osvf_files("schema/osvf_schema-1.7.4.json", "vuln")

	if is_error == true then
		print(output)
	end
elseif which_command == 4 then
	is_valid = osvf_tool_validate_osvf_files("schema/osvf_schema-1.7.4.json", "vuln")
	if is_valid == true then
		is_valid = osvf_tool_generate_commonmark("vuln", "md")
	else
		print("Validation of OSVf JSON files didn't succeeded please see error(s)")
	end
end

os.exit(0)
