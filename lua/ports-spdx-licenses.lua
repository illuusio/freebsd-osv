-- SPDX-License-Identifier: BSD-2-Clause
--
-- Copyright(c) 2025 The FreeBSD Foundation.
--
-- This software was developed by Tuukka Pasanen <tuukka.pasanen@ilmi.fi>
-- under sponsorship from the FreeBSD Foundation.
--
-- Functions handle FreeBSD license conversion to SPDX one
--
-- !! Heavy WIP warning !!
--

FREEBSD_LICENSES = {}
FREEBSD_LICENSES["AGPLv3+"] =
	{ name = "GNU Affero General Public License version 3 (or later)", spdx_id = "AGPL-3.0-or-later" }
FREEBSD_LICENSES["AGPLv3"] = { name = "GNU Affero General Public License version 3", spdx_id = "AGPL-3.0-only" }
FREEBSD_LICENSES["APACHE10"] = { name = "Apache License 1.0", spdx_id = "Apache-1.0" }
FREEBSD_LICENSES["APACHE11"] = { name = "Apache License 1.1", spdx_id = "Apache-1.1" }
FREEBSD_LICENSES["APACHE20"] = { name = "Apache License 2.0", spdx_id = "Apache-2.0" }
FREEBSD_LICENSES["ART10"] = { name = "Artistic License version 1.0", spdx_id = "Artistic-1.0" }
FREEBSD_LICENSES["ART20"] = { name = "Artistic License version 2.0", spdx_id = "Artistic-2.0" }
FREEBSD_LICENSES["ARTPERL10"] = { name = "Artistic License (perl) version 1.0", spdx_id = "Artistic-1.0-Perl" }
FREEBSD_LICENSES["BSD0CLAUSE"] = { name = "BSD Zero Clause License", spdx_id = "0BSD" }
FREEBSD_LICENSES["BSD2CLAUSE"] = { name = "BSD 2-clause 'Simplified' License", spdx_id = "BSD-2-Clause" }
FREEBSD_LICENSES["BSD3CLAUSE"] = { name = "BSD 3-clause 'New' or 'Revised' License", spdx_id = "BSD-3-Clause" }
FREEBSD_LICENSES["BSD4CLAUSE"] = { name = "BSD 4-clause 'Original' or 'Old' License", spdx_id = "BSD-4-Clause" }
-- TODO: Check this license
FREEBSD_LICENSES["BSD"] = { name = "BSD license Generic Version (deprecated)", spdx_id = nil }
FREEBSD_LICENSES["BSL"] = { name = "Boost Software License", spdx_id = "BSL-1.0" }
FREEBSD_LICENSES["CC-BY-1.0"] = { name = "Creative Commons Attribution 1.0", spdx_id = "CC-BY-1.0" }
FREEBSD_LICENSES["CC-BY-2.0"] = { name = "Creative Commons Attribution 2.0", spdx_id = "CC-BY-1.0" }
FREEBSD_LICENSES["CC-BY-2.5"] = { name = "Creative Commons Attribution 2.5", spdx_id = "CC-BY-1.0" }
FREEBSD_LICENSES["CC-BY-3.0"] = { name = "Creative Commons Attribution 3.0", spdx_id = "CC-BY-1.0" }
FREEBSD_LICENSES["CC-BY-4.0"] = { name = "Creative Commons Attribution 4.0", spdx_id = "CC-BY-1.0" }
FREEBSD_LICENSES["CC-BY-NC-1.0"] =
	{ name = "Creative Commons Attribution Non Commercial 1.0", spdx_id = "CC-BY-NC-1.0" }
FREEBSD_LICENSES["CC-BY-NC-2.0"] =
	{ name = "Creative Commons Attribution Non Commercial 2.0", spdx_id = "CC-BY-NC-2.0" }
FREEBSD_LICENSES["CC-BY-NC-2.5"] =
	{ name = "Creative Commons Attribution Non Commercial 2.5", spdx_id = "CC-BY-NC-2.5" }
FREEBSD_LICENSES["CC-BY-NC-3.0"] =
	{ name = "Creative Commons Attribution Non Commercial 3.0", spdx_id = "CC-BY-NC-3.0" }
FREEBSD_LICENSES["CC-BY-NC-4.0"] =
	{ name = "Creative Commons Attribution Non Commercial 4.0", spdx_id = "CC-BY-NC-4.0" }
FREEBSD_LICENSES["CC-BY-NC-ND-1.0"] =
	{ name = "Creative Commons Attribution Non Commercial No Derivatives 1.0", spdx_id = "CC-BY-NC-ND-1.0" }
FREEBSD_LICENSES["CC-BY-NC-ND-2.0"] =
	{ name = "Creative Commons Attribution Non Commercial No Derivatives 2.0", spdx_id = "CC-BY-NC-ND-2.0" }
FREEBSD_LICENSES["CC-BY-NC-ND-2.5"] =
	{ name = "Creative Commons Attribution Non Commercial No Derivatives 2.5", spdx_id = "CC-BY-NC-ND-2.5" }
FREEBSD_LICENSES["CC-BY-NC-ND-3.0"] =
	{ name = "Creative Commons Attribution Non Commercial No Derivatives 3.0", spdx_id = "CC-BY-NC-ND-3.0" }
FREEBSD_LICENSES["CC-BY-NC-ND-4.0"] =
	{ name = "Creative Commons Attribution Non Commercial No Derivatives 4.0", spdx_id = "CC-BY-NC-ND-4.0" }
FREEBSD_LICENSES["CC-BY-NC-SA-1.0"] =
	{ name = "Creative Commons Attribution Non Commercial Share Alike 1.0", spdx_id = "CC-BY-NC-SA-1.0" }
FREEBSD_LICENSES["CC-BY-NC-SA-2.0"] =
	{ name = "Creative Commons Attribution Non Commercial Share Alike 2.0", spdx_id = "CC-BY-NC-SA-2.0" }
FREEBSD_LICENSES["CC-BY-NC-SA-2.5"] =
	{ name = "Creative Commons Attribution Non Commercial Share Alike 2.5", spdx_id = "CC-BY-NC-SA-2.5" }
FREEBSD_LICENSES["CC-BY-NC-SA-3.0"] =
	{ name = "Creative Commons Attribution Non Commercial Share Alike 3.0", spdx_id = "CC-BY-NC-SA-3.0" }
FREEBSD_LICENSES["CC-BY-NC-SA-4.0"] =
	{ name = "Creative Commons Attribution Non Commercial Share Alike 4.0", spdx_id = "CC-BY-NC-SA-4.0" }
FREEBSD_LICENSES["CC-BY-ND-1.0"] =
	{ name = "Creative Commons Attribution No Derivatives 1.0", spdx_id = "CC-BY-NC-1.0" }
FREEBSD_LICENSES["CC-BY-ND-2.0"] =
	{ name = "Creative Commons Attribution No Derivatives 2.0", spdx_id = "CC-BY-NC-2.0" }
FREEBSD_LICENSES["CC-BY-ND-2.5"] =
	{ name = "Creative Commons Attribution No Derivatives 2.5", spdx_id = "CC-BY-NC-2.5" }
FREEBSD_LICENSES["CC-BY-ND-3.0"] =
	{ name = "Creative Commons Attribution No Derivatives 3.0", spdx_id = "CC-BY-NC-3.0" }
FREEBSD_LICENSES["CC-BY-ND-4.0"] =
	{ name = "Creative Commons Attribution No Derivatives 4.0", spdx_id = "CC-BY-NC-4.0" }
FREEBSD_LICENSES["CC-BY-SA-1.0"] = { name = "Creative Commons Attribution Share Alike 1.0", spdx_id = "CC-BY-SA-1.0" }
FREEBSD_LICENSES["CC-BY-SA-2.0"] = { name = "Creative Commons Attribution Share Alike 2.0", spdx_id = "CC-BY-SA-1.0" }
FREEBSD_LICENSES["CC-BY-SA-2.5"] = { name = "Creative Commons Attribution Share Alike 2.5", spdx_id = "CC-BY-SA-1.0" }
FREEBSD_LICENSES["CC-BY-SA-3.0"] = { name = "Creative Commons Attribution Share Alike 3.0", spdx_id = "CC-BY-SA-1.0" }
FREEBSD_LICENSES["CC-BY-SA-4.0"] = { name = "Creative Commons Attribution Share Alike 4.0", spdx_id = "CC-BY-SA-1.0" }
FREEBSD_LICENSES["CC0-1.0"] = { name = "Creative Commons Zero v1.0 Universal", spdx_id = "CC0-1.0" }
FREEBSD_LICENSES["CDDL"] = { name = "Common Development and Distribution License", spdx_id = "CDDL-1.0" }
-- TODO: Check this license
FREEBSD_LICENSES["COPYFREE"] = { name = " Complies with Copyfree Standard Definition", spdx_id = "COIL-1.0" }
FREEBSD_LICENSES["CPAL-1.0"] = { name = "Common Public Attribution License", spdx_id = "CPAL-1.0" }
FREEBSD_LICENSES["ClArtistic"] = { name = "Clarified Artistic License", spdx_id = "ClArtistic" }
FREEBSD_LICENSES["EPL"] = { name = "Eclipse Public License", spdx_id = "EPL-1.0" }
FREEBSD_LICENSES["EU"] = { name = "European Union Public Licence", spdx_id = "EUPL-1.0" }
FREEBSD_LICENSES["EUPL11"] = { name = "European Union Public Licence version 1.1", spdx_id = "EUPL-1.1" }
FREEBSD_LICENSES["EUPL12"] = { name = "European Union Public Licence version 1.2", spdx_id = "EUPL-1.2" }
-- TODO: Check this license
FREEBSD_LICENSES["FONTS"] = { name = "Font licenses", spdx_id = nil }
-- TODO: Check this license
FREEBSD_LICENSES["FSF"] = { name = "Free Software Foundation Approved", spdx_id = nil }
FREEBSD_LICENSES["GFDL"] = { name = "GNU Free Documentation License", spdx_id = "GFDL-1.1" }
-- TODO: Check this license
FREEBSD_LICENSES["GMGPL"] = { name = "GNAT Modified General Public License", spdx_id = nil }
-- TODO: Check this license
FREEBSD_LICENSES["GPL"] = { name = "GPL Compatible", spdx_id = nil }
FREEBSD_LICENSES["GPLv1+"] = { name = "GNU General Public License version 1 (or later)", spdx_id = "GPL-1.0+" }
FREEBSD_LICENSES["GPLv1"] = { name = "GNU General Public License version 1", spdx_id = "GPL-1.0" }
FREEBSD_LICENSES["GPLv2+"] = { name = "GNU General Public License version 2 (or later)", spdx_id = "GPL-2.0+" }
FREEBSD_LICENSES["GPLv2"] = { name = "GNU General Public License version 2", spdx_id = "GPL-2.0" }
FREEBSD_LICENSES["GPLv3+"] = { name = "GNU General Public License version 3 (or later)", spdx_id = "GPL-3.0+" }
FREEBSD_LICENSES["GPLv3"] = { name = "GNU General Public License version 3", spdx_id = "GPL-3.0+" }
-- TODO: Check this license
FREEBSD_LICENSES["GPLv3RLE+"] = { name = "GNU GPL version 3 Runtime Library Exception (or later)", spdx_id = nil }
FREEBSD_LICENSES["GPLv3RLE"] =
	{ name = "GNU GPL version 3 Runtime Library Exception", spdx_id = "GPL-3.0-with-GCC-exception" }
FREEBSD_LICENSES["ISCL"] = { name = "Internet Systems Consortium License", spdx_id = "ISC" }
FREEBSD_LICENSES["LGPL20+"] =
	{ name = "GNU Library General Public License version 2.0 (or later)", spdx_id = "LGPL-2.0+" }
FREEBSD_LICENSES["LGPL20"] = { name = "GNU Library General Public License version 2.0", spdx_id = "LGPL-2.0" }
FREEBSD_LICENSES["LGPL21+"] =
	{ name = "GNU Lesser General Public License version 2.1 (or later)", spdx_id = "LGPL-2.1+" }
FREEBSD_LICENSES["LGPL21"] = { name = "GNU Lesser General Public License version 2.1", spdx_id = "LGPL-2.1" }
FREEBSD_LICENSES["LGPL3+"] = { name = "GNU Lesser General Public License version 3 (or later)", spdx_id = "LGPL-3.0+" }
FREEBSD_LICENSES["LGPL3"] = { name = "GNU Lesser General Public License version 3", spdx_id = "LGPL-3.0" }
FREEBSD_LICENSES["LPPL10"] = { name = "LaTeX Project Public License version 1.0", spdx_id = "LPPL-1.0" }
FREEBSD_LICENSES["LPPL11"] = { name = "LaTeX Project Public License version 1.1", spdx_id = "LPPL-1.1" }
FREEBSD_LICENSES["LPPL12"] = { name = "LaTeX Project Public License version 1.2", spdx_id = "LPPL-1.2" }
FREEBSD_LICENSES["LPPL13"] = { name = "LaTeX Project Public License version 1.3", spdx_id = "LPPL-1.3" }
FREEBSD_LICENSES["LPPL13a"] = { name = "LaTeX Project Public License version 1.3a", spdx_id = "LPPL-1.3a" }
FREEBSD_LICENSES["LPPL13b"] = { name = "LaTeX Project Public License version 1.3b", spdx_id = "LPPL-1.3b" }
FREEBSD_LICENSES["LPPL13c"] = { name = "LaTeX Project Public License version 1.3c", spdx_id = "LPPL-1.3c" }
FREEBSD_LICENSES["MIT"] = { name = "MIT license / X11 license", spdx_id = "MIT" }
FREEBSD_LICENSES["MPL10"] = { name = "Mozilla Public License version 1.0", spdx_id = "MPL-1.0" }
FREEBSD_LICENSES["MPL11"] = { name = "Mozilla Public License version 1.1", spdx_id = "MPL-1.1" }
FREEBSD_LICENSES["MPL20"] = { name = "Mozilla Public License version 2.0", spdx_id = "MPL-2.0" }
FREEBSD_LICENSES["NCSA"] = { name = "University of Illinois/NCSA Open Source License", spdx_id = "NCSA" }
-- TODO: Check this license
FREEBSD_LICENSES["NONE"] = { name = "No license specified", spdx_id = nil }
FREEBSD_LICENSES["ODbL"] = { name = "Open Database License", spdx_id = "ODbL-1.0" }
FREEBSD_LICENSES["OFL10"] =
	{ name = "SIL Open Font License version 1.0 (http://scripts.sil.org/OFL)", spdx_id = "OFL-1.0" }
FREEBSD_LICENSES["OFL11"] =
	{ name = "SIL Open Font License version 1.1 (http://scripts.sil.org/OFL)", spdx_id = "OFL-1.1" }
-- TODO: Check this license
FREEBSD_LICENSES["OSI"] = { name = "OSI Approved", spdx_id = "any_OSI" }
-- TODO: Check this license
FREEBSD_LICENSES["OWL"] = { name = "Open Works License (owl.apotheon.org)", spdx_id = nil }
FREEBSD_LICENSES["OpenSSL"] = { name = "OpenSSL License", spdx_id = "OpenSSL" }
-- TODO Check this license
FREEBSD_LICENSES["PD"] = { name = "Public Domain", spdx_id = nil }
FREEBSD_LICENSES["PHP202"] = { name = "PHP License version 2.02", spdx_id = nil }
FREEBSD_LICENSES["PHP301"] = { name = "PHP License version 3.01", spdx_id = "PHP-3.01" }
FREEBSD_LICENSES["PHP30"] = { name = "PHP License version 3.0", spdx_id = "PHP-3.0" }
FREEBSD_LICENSES["PSFL"] = { name = "Python Software Foundation License", spdx_id = "PSF-2.0" }
FREEBSD_LICENSES["PostgreSQL"] = { name = "PostgreSQL Licence", spdx_id = "PostgreSQL" }
FREEBSD_LICENSES["RUBY"] = { name = "Ruby License", spdx_id = "Ruby" }
FREEBSD_LICENSES["UNLICENSE"] = { name = "The Unlicense", spdx_id = "Unlicense" }
-- TODO Check this license
FREEBSD_LICENSES["WTFPL1"] = { name = "Do What the Fuck You Want To Public License version 1", spdx_id = "WTFPL" }
-- TODO Check this license
FREEBSD_LICENSES["WTFPL"] = { name = "Do What the Fuck You Want To Public License version 2", spdx_id = "WTFPL" }
FREEBSD_LICENSES["ZLIB"] = { name = "zlib License", spdx_id = "Zlib" }
FREEBSD_LICENSES["ZPL21"] = { name = "Zope Public License version 2.1", spdx_id = "ZPL-2.1" }

local function ports_spdx_license_print_table()
	print("FreeBSD\t\t\tSPDX\t\t\t\tName")
	print("-------------------------------------------------------------------------------------------------")
	for key, table in pairs(FREEBSD_LICENSES) do
		local output_string = table["spdx_id"]
		local tab1_string = "\t\t"
		local tab2_string = "\t\t\t"

		if string.len(key) < 8 then
			tab1_string = "\t\t\t"
		end

		if output_string == nil then
			output_string = "?"
		end

		if string.len(output_string) < 8 then
			tab2_string = "\t\t\t\t"
		end

		print(key .. tab1_string .. output_string .. tab2_string .. table["name"])
	end
end

ports_spdx_license_print_table()
