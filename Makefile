# SPDX-License-Identifier: BSD-2-Clause
#
# Copyright(c) 2025 The FreeBSD Foundation.
#
# This software was developed by Tuukka Pasanen <tuukka.pasanen@ilmi.fi>
# under sponsorship from the FreeBSD Foundation
#
# See documentation how to use this Makefile
#
TOP != pwd
LUA_CMD ?= "/usr/libexec/flua"
LUA_PATH := "$(TOP)/lua/?.lua;;"
LUA_TOOL := "bin/osvf-tool.lua"
PYTHON_CMD ?= "/usr/local/bin/python3.11"
FETCH_CMD ?= "/usr/bin/fetch"
VUXML_URL := "https://vuxml.freebsd.org/freebsd/vuln.xml.xz"

.PHONY: download-vuxml unpack-vuxml convert-vuxml check-lua check-python merge

variables:
	@echo "Lua command: $(LUA_CMD)"
	@echo "Python command: $(PYTHON_CMD)"
	@echo "Fetch command: $(FETCH_CMD)"

check-lua:
	@[ -x $(LUA_CMD) ] || { echo "Lua not found. Please install FreeBSD Lua or use LUA_CMD global variable on command line to locate lua intepreter (5.4 recommended)"; exit 1; }

check-python:
	@[ -x $(PYTHON_CMD) ] || { echo "Python not found. Please install at least version 3.11 or use PYTHON_CMD global variable on command line to locate python intepreter"; exit 1; }
	@$(PYTHON_CMD) -c "import lxml" || { echo "Python module 'lxml' is needed in conversion please install it"; exit 1; }
	@$(PYTHON_CMD) -c "import pypandoc" || { echo "Python module 'pypandoc' is needed in conversion please install it"; exit 1; }

download-vuxml:
	@[ -x $(FETCH_CMD) ] || { echo "fetch command not found. Override with FETCH_CMD global variable"; exit 1; }
	@curl --output vuln.xml.xz https://vuxml.freebsd.org/freebsd/vuln.xml.xz >/dev/null 2>&1 || { echo "Can't download '$(VUXML_URL)'"; exit 1; }

unpack-vuxml: download-vuxml
	@which xz >/dev/null 2>&1 || { echo "xz not found"; exit 1; }
	@xz -d vuln.xml.xz || { echo "Can't unpack vuln.xml.xz"; exit 1; }

convert-vuxml: check-python unpack-vuxml
	@$(PYTHON_CMD) bin/convert_vuxml.py -o vuln vuln.xml

merge: check-lua
	@LUA_PATH=$(LUA_PATH) $(LUA_CMD) $(LUA_TOOL) merge > db/freebsd-osv.json

commonmark: check-lua
	@LUA_PATH=$(LUA_PATH) $(LUA_CMD) $(LUA_TOOL) commonmark

newentry: check-lua
	@LUA_PATH=$(LUA_PATH) $(LUA_CMD) $(LUA_TOOL) newentry

validate: check-lua
	@LUA_PATH=$(LUA_PATH) $(LUA_CMD) $(LUA_TOOL) validate
