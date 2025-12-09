> [!WARNING]
> 💥 Attention please! You've entered our testing ground! ☠ The contents of this repo are purely for testing purposes. Please don't use the files or information here for any other reason. Thank you for your cooperation! 🌟

# 

# The OSV Database
OSV (Open Source Vulnerabilities) is a relatively new initiative aimed at creating a common format for describing vulnerabilities. According to the [OSV FAQ](https://google.github.io/osv.dev/faq/#why-a-new-format-to-describe-vulnerability), it consists of three parts:

1. [The OSV Schema](https://github.com/ossf/osv-schema/blob/main/validation/schema.json)

2. [The reference infrastructure](https://osv.dev/)

3. OSV-Scanner, the officially supported frontend for OSV.dev

The primary purpose of OSV is to create a common, machine-readable format for open-source vulnerabilities that includes validation schema and tooling support for multiple programming languages. OSV shares similar goals with FreeBSD VuXML format, aiming to inform users about security vulnerabilities in FreeBSD ports or base system and FreeBSD kernel.

Integration into FreeBSD's main infrastructure is still in progress, with the current implementation available at [an unofficial repository outside of FreeBSD](https://github.com/illuusio/freebsd-osv). The OSV repository has a slightly different structure than VuXML entries:

Files are organized by year in subdirectories under the `vuln` directory. The prefix resets to `0001` on January 1st of each year, with directories changing to reflect the current year. Template for OSV ID is `FreeBSD-YYYY-NNNN` where 'Y' stands for year and 'N' stands for running number:

```
vuln/
     2024/
          FreeBSD-2024-0001.json
          FreeBSD-2024-0002.json
          FreeBSD-2024-0003.json
          FreeBSD-2024-0004.json
          ...
    2025/
          FreeBSD-2025-0001.json
          FreeBSD-2025-0002.json
          FreeBSD-2025-0003.json
          FreeBSD-2025-0004.json
          ...
```

A flattened JSON file containing all vulnerabilities is stored as `db/freebsd-osv.json`, which is consumed by the pkg(8) tool in future. Integration with pkg(8) is currently under [review at the Pull Request level](https://github.com/freebsd/pkg/pull/2558).

# A Short Introduction to OSV Format

OSV Schema documentation can be found [here](https://ossf.github.io/osv-schema/). If something in this documentation contradicts the official schema documentation, then the official documentation should be considered correct. Corrections to this documentation are welcome.

This is an example of a VuXML converted to OSV _JSON_ format, which has been chosen as the serialization language for OSV files:

```
{
    "affected": [
        {
            "package": {
                "ecosystem": "FreeBSD:ports",
                "name": "foo"
            },
            "ranges": [
                {
                    "events": [
                        {
                            "introduced": "1.6"
                        },
                        {
                            "fixed": "1.9"
                        }
                    ],
                    "type": "ECOSYSTEM"
                },
                {
                    "events": [
                        {
                            "introduced": "2.*"
                        },
                        {
                            "fixed": "2.4_1"
                        }
                    ],
                    "type": "ECOSYSTEM"
                },
                {
                    "events": [
                        {
                            "introduced": "3.0b1"
                        },
                        {
                            "last_affected": "3.0b1"
                        },
                        {
                            "fixed": "3.0b1"
                        }
                    ],
                    "type": "ECOSYSTEM"
                }
            ],
            "versions": [
                "3.0b1"
            ]
        },
        {
            "package": {
                "ecosystem": "FreeBSD:ports",
                "name": "foo-devel"
            },
            "ranges": [
                {
                    "events": [
                        {
                            "introduced": "1.6"
                        },
                        {
                            "fixed": "1.9"
                        }
                    ],
                    "type": "ECOSYSTEM"
                },
                {
                    "events": [
                        {
                            "introduced": "2.*"
                        },
                        {
                            "fixed": "2.4_1"
                        }
                    ],
                    "type": "ECOSYSTEM"
                },
                {
                    "events": [
                        {
                            "introduced": "3.0b1"
                        },
                        {
                            "last_affected": "3.0b1"
                        },
                        {
                            "fixed": "3.0b1"
                        }
                    ],
                    "type": "ECOSYSTEM"
                }
            ],
            "versions": [
                "3.0b1"
            ]
        },
        {
            "package": {
                "ecosystem": "FreeBSD:ports",
                "name": "ja-foo"
            },
            "ranges": [
                {
                    "events": [
                        {
                            "introduced": "1.6"
                        },
                        {
                            "fixed": "1.9"
                        }
                    ],
                    "type": "ECOSYSTEM"
                },
                {
                    "events": [
                        {
                            "introduced": "2.*"
                        },
                        {
                            "fixed": "2.4_1"
                        }
                    ],
                    "type": "ECOSYSTEM"
                },
                {
                    "events": [
                        {
                            "introduced": "3.0b1"
                        },
                        {
                            "last_affected": "3.0b1"
                        },
                        {
                            "fixed": "3.0b1"
                        }
                    ],
                    "type": "ECOSYSTEM"
                }
            ],
            "versions": [
                "3.0b1"
            ]
        },
        {
            "package": {
                "ecosystem": "FreeBSD:ports",
                "name": "openfoo"
            },
            "ranges": [
                {
                    "events": [
                        {
                            "fixed": "1.10_7"
                        },
                        {
                            "introduced": "0"
                        }
                    ],
                    "type": "ECOSYSTEM"
                },
                {
                    "events": [
                        {
                            "introduced": "1.2,1"
                        },
                        {
                            "fixed": "1.3_1,1"
                        }
                    ],
                    "type": "ECOSYSTEM"
                }
            ]
        }
    ],
    "database_specific": {
        "cite": [
            "http://j.r.hacker.com/advisories/1"
        ],
        "discovery": "2010-05-25T00:00:00Z",
        "references": {
            "certvu": [
                "740169"
            ],
            "cvename": [
                "CVE-2023-48795"
            ],
            "freebsdpr": [
                "ports/987654"
            ],
            "freebsdsa": [
                "SA-10:75.foo"
            ]
        },
        "vid": "f4bc80f4-da62-11d8-90ea-0004ac98a7b9"
    },
    "details": "J. Random Hacker reports:\n\n> Several issues in the Foo software may be exploited via carefully\n> crafted QUUX requests. These requests will permit the injection of Bar\n> code, mumble theft, and the readability of the Foo administrator\n> account.\n",
    "id": "FreeBSD-2010-0001",
    "modified": "2010-09-17T00:00:00Z",
    "published": "2010-07-13T00:00:00Z",
    "references": [
        {
            "type": "REPORT",
            "url": "http://j.r.hacker.com/advisories/1"
        },
        {
            "type": "ADVISORY",
            "url": "https://www.freebsd.org/security/advisories/FreeBSD-SA-10:75.foo.asc"
        },
        {
            "type": "REPORT",
            "url": "https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=987654"
        },
        {
            "type": "ADVISORY",
            "url": "https://api.osv.dev/v1/vulns/CVE-2023-48795"
        },
        {
            "type": "ADVISORY",
            "url": "https://www.kb.cert.org/vuls/id/740169"
        },
        {
            "type": "DISCUSSION",
            "url": "http://marc.theaimsgroup.com/?l=bugtraq&m=203886607825605"
        }
    ],
    "schema_version": "1.7.0",
    "summary": "Several vulnerabilities found in Foo"
}
```

Detailed documentation on tags and structure can be found in the Official OSV Schema documentation, but here are notes for this example:

1. *ID Field*: The `.id` field is mandatory at the top level of an OSV entry and specifies a unique ID for the entry. For VuXML entries converted to OSV format, it uses UUIDs (found under `.database_specific.vid`). The ID format should be `FREEBSD-YYYY-NNNN`, where YYYY is a four-digit year (e.g., 2026), and NNNN is the running number starting at 0001 every year. For example, the third vulnerability of 2026 would be `FREEBSD-2026-0004`. It should be stored in `vuln/2026/FREEBSD-2026-0004.json`.

2. *Summary Field*: The `.summary` field is a one-line description of the issue.

3. *Affected Packages*: The `.affected` field lists all affected packages as an array. Each package object contains:
    - `name`: The port or base package name.
    - `ecosystem`: Typically, this will be `FreeBSD:ports` which is for FreeBSD Ports packages. It also can be `FreeBSD:base` which is for FreeBSD base package(s) or `FreeBSD:kernel` which is for kernel modules and kernel itself.

4. *Versioning*: Version information is provided under `.affected[].ranges` array. Each range object contains:
    - An array of events `introduced`, `last_affected`, and `fixed`, similar to VuXML's `<lt>`, `<le>`, `<eq>`, `<ge>`, and `<gt>` elements.
    - `introduced`-field is used like `<ge>` attribute
    - `fixed`-field is used like `<le>`attribute
    - `last_affected`-field is used like `<lte>`attribute
    - VuXML version '*', which means all version are vunerable, is supported with `introduced: "0"`
    - The `type`-field should always be `ECOSYSTEM`.

5. *Details Field*: The `.details` field contains a multi-line detailed description of the issue, formatted in [CommonMark](https://commonmark.org/help/).

6. *References Field*: The `.references` array includes relevant documents with types such as `ADVISORY`, `DISCUSSION`, and `REPORT`. See the [official OSV documentation for all available types](https://ossf.github.io/osv-schema/#references-field).

7. *Modified Field*: The `.modified` field contains the ISO 8601 date when the issue was last modified (`YYYY-MM-DDTHH:MM:SSZ`).

8. *Published Field*: `.published` field contains The ISO 8601 date when the entry was added (`YYYY-MM-DDTHH:MM:SSZ`).

8. *Database-Specific Information*:
    - `.database_specific.discovery`: The ISO 8601 date when the issue was discovered.
    - `.database_specific.vid`: Original VuXML UUID
    - `.database_specific.references`: Object which contains original references as they are preprensented as URL in `.references`
    - `.database_specific.references.bid[]`: Array of SecurityFocus computer security news portal (current offline)  numbers as strings
    - `.database_specific.references.certsa[]`: Array of CERT Advisories reference numbers as strings
    - `.database_specific.references.certvu[]`: Array of CERT/CC Vulnerability Notes Database reference numbers as strings
    - `.database_specific.references.cvename[]`: Array of CVE Vulnerabilities connecting for this OSV entry as strings.
    - `.database_specific.references.freebsdpr[]`: Array of FreeBSD bugzilla bug references.
    - `.database_specific.references.freebsdsa[]`: Array of FreeBSD Security Advisories references.

9. *Schema Version*: The `schema_version` field indicates the version of the schema in use (FreeBSD uses 1.7.4).

Additional fields like severity, aliases, and withdrawn are mentioned but not currently used.

# Using OSV Repository Makefile Targets

In the [Unofficial outside FreeBSD repository](https://github.com/illuusio/freebsd-osv/blob/main/Makefile), there is a Makefile that makes it easier to maintain OSV Vulnerabilities. While there aren't many targets, they should be sufficient to:

1. Maintain OSV database and convert entries from VuXML XML to OSV (with `convert-vuxml`)

2. Merge OSV files into one JSON array to use in pkg(8)

3. Export OSV files to Commonmark `.md`-files which can be converted to HTML with Pandoc or a similar tool

4. In the future, maintain only the OSV repository and have [OSV Pull Request 3901](https://github.com/google/osv.dev/issues/3901) fulfilled to make FreeBSD Vulnerabilities appear through the [osv.dev API](https://osv.dev/#use-the-api)

Targets in detail are:

- `convert-vuxml`:
  Downloads VuXML from FreeBSD vuxml: https://vuxml.freebsd.org/freebsd/vuln.xml.xz, unpacks it with `xz`, and converts VuXML to OSV format. New files are saved under the `vuln` directory. If `vuxml.xml` is present then conversion is not done.

- `commonmark`:
  Exports OSV JSON files as CommonMark format into `.md` files. The directory structure remains unchanged.

- `merge`:
  Merges all OSV files in the `vuln` directory into `db/freebsd-osv.json`. Validates all OSV files against the JSON schema.

- `newentry`:
  Adds a new entry with the next available ID to the `vuln` directory.

# JSON tools to work with OSV files
These are tools that have been proven to be useful when working with JSON files. They are listed in alphabetical order:

- [fx](https://fx.wtf/) — Go language written Terminal JSON viewer & processor. Easy to see multiline strings, for example.

- [jq](https://jqlang.org/) — C language written Command-line JSON processor. Useful for examining JSON if `fx` is too much.

- [yj](https://github.com/bruceadams/yj) — Go language written command line tool that converts YAML to JSON/TOML (and back to YAML/TOML). Can be useful when editing multiline JSON details. Convert JSON to YAML, edit and convert back to JSON.
