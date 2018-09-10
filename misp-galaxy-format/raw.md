% Title = "MISP galaxy format"
% abbrev = "MISP galaxy format"
% category = "info"
% docName = "draft-dulaunoy-misp-galaxy-format"
% ipr= "trust200902"
% area = "Security"
%
% date = 2018-04-01T00:00:00Z
%
% [[author]]
% initials="A."
% surname="Dulaunoy"
% fullname="Alexandre Dulaunoy"
% abbrev="CIRCL"
% organization = "Computer Incident Response Center Luxembourg"
%  [author.address]
%  email = "alexandre.dulaunoy@circl.lu"
%  phone = "+352 247 88444"
%   [author.address.postal]
%   street = "16, bd d'Avranches"
%   city = "Luxembourg"
%   code = "L-1611"
%   country = "Luxembourg"
% [[author]]
% initials="A."
% surname="Iklody"
% fullname="Andras Iklody"
% abbrev="CIRCL"
% organization = "Computer Incident Response Center Luxembourg"
%  [author.address]
%  email = "andras.iklody@circl.lu"
%  phone = "+352 247 88444"
%   [author.address.postal]
%   street = " 16, bd d'Avranches"
%   city = "Luxembourg"
%   code = "L-1611"
%   country = "Luxembourg"
% [[author]]
% initials="D."
% surname="Servili"
% fullname="Deborah Servili"
% abbrev="CIRCL"
% organization = "Computer Incident Response Center Luxembourg"
%  [author.address]
%  email = "deborah.servili@circl.lu"
%  phone = "+352 247 88444"
%   [author.address.postal]
%   street = " 16, bd d'Avranches"
%   city = "Luxembourg"
%   code = "L-1611"
%   country = "Luxembourg"



.# Abstract

This document describes the MISP galaxy format which describes a simple JSON format to represent galaxies and clusters that can be attached to MISP events or attributes. A public directory of MISP galaxies is available and relies on the MISP galaxy format. MISP galaxies are used to add further informations on a MISP event. MISP galaxy is a public repository [@?MISP-G] [@?MISP-G-DOC] of known malware, threats actors and various other collections of data that can be used to mark, classify or label data in threat information sharing.

{mainmatter}

# Introduction

Sharing threat information became a fundamental requirements on the Internet, security and intelligence community at large. Threat information can include indicators of compromise, malicious file indicators, financial fraud indicators or even detailed information about a threat actor. Some of these informations, such as malware or threat actors are common to several security events. MISP galaxy is a public repository [@?MISP-G] of known malware, threats actors and various other collections of data that can be used to mark, classify or label data in threat information sharing.

In the MISP galaxy context, clusters help analysts to give more informations about their cybersecurity events, indicators or threats. MISP galaxies can be used for classification, filtering, triggering actions or visualisation depending on their use in threat intelligence platforms such as MISP [@?MISP-P].

##  Conventions and Terminology

The key words "**MUST**", "**MUST NOT**", "**REQUIRED**", "**SHALL**", "**SHALL NOT**",
"**SHOULD**", "**SHOULD NOT**", "**RECOMMENDED**", "**MAY**", and "**OPTIONAL**" in this
document are to be interpreted as described in RFC 2119 [@!RFC2119].

# Format

A cluster is composed of a value (**MUST**), a description (**OPTIONAL**) and metadata (**OPTIONAL**).

Clusters are represented as a JSON [@!RFC4627] dictionary.

## Overview

The MISP galaxy format uses the JSON [@!RFC4627] format. Each galaxy is represented as a JSON object with meta information including the following fields: name, uuid, description, version, type, authors, source, values.

name defines the name of the galaxy. The name is represented as a string and **MUST** be present. The uuid represents the Universally Unique IDentifier (UUID) [@!RFC4122] of the object reference. The uuid **MUST** be preserved. For any updates or transfer of the same object reference. UUID version 4 is **RECOMMENDED** when assigning it to a new object reference and **MUST** be present. The description is represented as a string and **MUST** be present. The uuid is represented as a string and **MUST** be present. The version is represented as a decimal and **MUST** be present. The type is represented as a string and **MUST** be present and **MUST** match the name of the galaxy file. The source is represented as a string and **MUST** be present. Authors are represented as an array containing one or more authors and **MUST** be present.

Values are represented as an array containing one or more values and **MUST** be present. Values defines all values available in the galaxy.

## values

The values array contains one or more JSON objects which represent all the possible values in the galaxy. The JSON object contains four fields: value, description, uuid and meta.
The value is represented as a string and **MUST** be present. The description is represented as a string and **SHOULD** be present. The meta or metadata is represented as a JSON list and **SHOULD** be present.
The uuid represents the Universally Unique IDentifier (UUID) [@!RFC4122] of the value reference. The uuid **SHOULD** can be present and **MUST** be preserved.

## related

Related contains a list of JSON key value pairs which describe the related values in this galaxy cluster or to other galaxy clusters. The JSON object contains three fields, dest-uuid, type and tags. The dest-uuid represents the target UUID which encompasses a relation of some type. The dest-uuid is represented as a string and **MUST** be present. The type is represented as a string and **MUST** be present and **SHOULD** be selected from the relationship types available in MISP objects [@?MISP-R].  The tags is a list of string which labels the related relationship such as the level of similarities, level of certainty, trust or confidence in the relationship, false-positive. A tag is represented in machine tag format which is a string an **SHOULD** be present.

~~~~
"related": [ {
  "dest-uuid": "f873db71-3d53-41d5-b141-530675ade27a",
  "type": "similar",
  "tags": ["estimative-language:likelihood-probability=\"very-likely\""]
} ]
~~~~

## meta

Meta contains a list of custom defined JSON key value pairs. Users **SHOULD** reuse commonly used keys such as complexity, effectiveness, country, possible_issues, colour, motive, impact, refs, synonyms, status, date, encryption, extensions, ransomnotes, cfr-suspected-victims, cfr-suspected-state-sponsor, cfr-type-of-incident, cfr-target-category wherever applicable.

refs, synonyms **SHALL** be used to give further informations. refs is represented as an array containing one or more strings and **SHALL** be present. synonyms is represented as an array containing one or more strings and **SHALL** be present.

date, status **MAY** be used to give time information about an cluster. date is represented as a string describing a time or period and **SHALL** be present. status is represented as a string describing the current status of the clusters. It **MAY** also describe a time or period and **SHALL** be present.

colour fields **MAY** be used at predicates or values level to set a specify colour that **MAY** be used by the implementation. The colour field is described as an RGB colour fill in hexadecimal representation.

complexity, effectiveness, impact, possible_issues **MAY** be used to give further information in preventive-measure galaxy. complexity is represented by an enumerated value from a fixed vocabulary and **SHALL** be present. effectiveness is represented by an enumerated value from a fixed vocabulary and **SHALL** be present. impact is represented by an enumerated value from a fixed vocabulary and **SHALL** be present. possible_issues is represented as a string and **SHOULD** be present.

Example use of the complexity, effectiveness, impact, possible_issues fields in the preventive-measure galaxy:

~~~~
{
  "meta": {
    "refs": [
      "http://www.windowsnetworking.com/kbase/WindowsTips/WindowsXP/AdminTips/Customization/DisableWindowsScriptingHostWSH.html"
    ],
    "complexity": "Low",
    "effectiveness": "Medium",
    "impact": "Medium",
    "type": [
      "GPO"
    ],
    "possible_issues": "Administrative VBS scripts on Workstations"
  },
  "value": "Disable WSH",
  "description": "Disable Windows Script Host",
  "uuid": "e6df1619-f8b3-476c-b5cf-22b4c9e9dd7f"
}
~~~~

country, motive **MAY** be used to give further information in threat-actor galaxy. country is represented as a string and **SHOULD** be present. motive is represented as a string and **SHOULD** be present.

Example use of the country, motive fields in the threat-actor galaxy:

~~~~
{
  "meta": {
    "country": "CN",
    "synonyms": [
      "APT14",
      "APT 14",
      "QAZTeam",
      "ALUMINUM"
    ],
    "refs": [
      "http://www.crowdstrike.com/blog/whois-anchor-panda/"
    ],
    "motive": "Espionage"
  },
  "value": "Anchor Panda",
  "description": "PLA Navy",
  "uuid": "c82c904f-b3b4-40a2-bf0d-008912953104"
}
~~~~

encryption, extensions, ransomnotes **MAY** be used to give further information in ransomware galaxy. encryption is represented as a string and **SHALL** be present. extensions is represented as an array containing one or more strings and **SHALL** be present. ransomnotes is represented as an array containing one or more strings ans **SHALL** be present.

Example use of the encryption, extensions, ransomnotes fields in the ransomware galaxy:

~~~~
{
  "meta": {
    "refs": [
      "https://www.bleepingcomputer.com/news/security/revenge-ransomware-a-cryptomix-variant-being-distributed-by-rig-exploit-kit/",
      "https://id-ransomware.blogspot.co.il/2017/03/revenge-ransomware.html"
    ],
    "ransomnotes": [
      "https://2.bp.blogspot.com/-KkPVDxjy8tk/WM7LtYHmuAI/AAAAAAAAEUw/kDJghaq-j1AZuqjzqk2Fkxpp4yr9Yeb5wCLcB/s1600/revenge-note-2.jpg",
      "===ENGLISH=== All of your files were encrypted using REVENGE Ransomware. The action required to restore the files. Your files are not lost, they can be returned to their normal state by decoding them. The only way to do this is to get the software and your personal decryption key. Using any other software that claims to be able to recover your files will result in corrupted or destroyed files. You can purchase the software and the decryption key by sending us an email with your ID. And we send instructions for payment. After payment, you receive the software to return all files. For proof, we can decrypt one file for free. Attach it to an e-mail.",
      "# !!!HELP_FILE!!! #.txt"
    ],
    "encryption": "AES-256 + RSA-1024",
    "extensions": [
      ".REVENGE"
    ],
    "date": "March 2017"
  },
  "description": "This is most likely to affect English speaking users, since the note is written in English. English is understood worldwide, thus anyone can be harmed. The hacker spread the virus using email spam, fake updates, and harmful attachments. All your files are compromised including music, MS Office, Open Office, pictures, videos, shared online files etc.. CryptoMix / CryptFile2 Variant",
  "value": "Revenge Ransomware",
  "uuid": "987d36d5-6ba8-484d-9e0b-7324cc886b0e"
}
~~~~

source-uuid, target-uuid **SHALL** be used to describe relationships. source-uuid and target-uuid represent the Universally Unique IDentifier (UUID) [@!RFC4122] of the value reference. source-uuid and target-uuid **MUST** be preserved.

Example use of the source-uuid, target-uuid fields in the mitre-enterprise-attack-relationship galaxy:
~~~~
{
  "meta": {
    "source-uuid": "222fbd21-fc4f-4b7e-9f85-0e6e3a76c33f",
    "target-uuid": "2f1a9fd0-3b7c-4d77-a358-78db13adbe78"
  },
  "uuid": "cfc7da70-d7c5-4508-8f50-1c3107269633",
  "value": "menuPass (G0045) uses EvilGrab (S0152)"
}
~~~~

cfr-suspected-victims, cfr-suspected-state-sponsor, cfr-type-of-incident and cfr-target-category **MAY** be used to report information gathered from CFR's (Council on Foreign Relations) [@?CFR] Cyber Operations Tracker.  cfr-suspected-victims is represented as an array containing one or more strings and **SHALL** be present. cfr-suspected-state-sponsor is represented as a string and **SHALL** be present. cfr-type-of-incident is represented as a string and **SHALL** be present. cfr-target-category is represented as an array containing one or more strings ans **SHALL** be present.

Example use of the cfr-suspected-victims, cfr-suspected-state-sponsor, cfr-type-of-incident, cfr-target-category fields in the threat-actor galaxy:
~~~~
{
  "meta": {
    "country": "CN",
    "refs": [
      "https://www.fireeye.com/blog/threat-research/2015/12/the_eps_awakens.html",
      "https://www.cfr.org/interactive/cyber-operations/apt-16"
    ],
    "cfr-suspected-victims": [
      "Japan",
      "Taiwan"
    ],
    "cfr-suspected-state-sponsor": "China",
    "cfr-type-of-incident": "Espionage",
    "cfr-target-category": [
      "Private sector"
    ]
  },
  "value": "APT 16",
  "uuid": "1f73e14f-b882-4032-a565-26dc653b0daf"
},
~~~~

# JSON Schema

The JSON Schema [@?JSON-SCHEMA] below defines the overall MISP galaxy formats. The main format is the MISP galaxy format used for the clusters.

## MISP galaxy format - clusters

~~~~
{
  "$schema": "http://json-schema.org/schema#",
  "title": "Validator for misp-galaxies - Clusters",
  "id": "https://www.github.com/MISP/misp-galaxies/schema_clusters.json",
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "description": {
      "type": "string"
    },
    "type": {
      "type": "string"
    },
    "version": {
      "type": "integer"
    },
    "name": {
      "type": "string"
    },
    "uuid": {
      "type": "string"
    },
    "source": {
      "type": "string"
    },
    "values": {
      "type": "array",
      "uniqueItems": true,
      "items": {
        "type": "object",
        "additionalProperties": false,
        "properties": {
          "description": {
            "type": "string"
          },
          "value": {
            "type": "string"
          },
          "uuid": {
            "type": "string"
          },
          "related": {
            "type": "array",
            "additionalProperties": false,
            "items": {
              "type": "object"
            },
            "properties": {
              "dest-uuid": {
                "type": "string"
              },
              "type": {
                "type": "string"
              },
              "tags": {
                "type": "array",
                "uniqueItems": true,
                "items": {
                  "type": "string"
                }
              }
            }
          },
          "meta": {
            "type": "object",
            "additionalProperties": true,
            "properties": {
              "type": {
                "type": "array",
                "uniqueItems": true,
                "items": {
                  "type": "string"
                }
              },
              "complexity": {
                "type": "string"
              },
              "effectiveness": {
                "type": "string"
              },
              "country": {
                "type": "string"
              },
              "possible_issues": {
                "type": "string"
              },
              "colour": {
                "type": "string"
              },
              "motive": {
                "type": "string"
              },
              "impact": {
                "type": "string"
              },
              "refs": {
                "type": "array",
                "uniqueItems": true,
                "items": {
                  "type": "string"
                }
              },
              "synonyms": {
                "type": "array",
                "uniqueItems": true,
                "items": {
                  "type": "string"
                }
              },
              "derivated_from": {
                "type": "array",
                "uniqueItems": true,
                "items": {
                  "type": "string"
                }
              },
              "status": {
                "type": "string"
              },
              "date": {
                "type": "string"
              },
              "encryption": {
                "type": "string"
              },
              "extensions": {
                "type": "array",
                "uniqueItems": true,
                "items": {
                  "type": "string"
                }
              },
              "ransomnotes": {
                "type": "array",
                "uniqueItems": true,
                "items": {
                  "type": "string"
                }
              }
            }
          }
        },
        "required": [
          "value"
        ]
      }
    },
    "authors": {
      "type": "array",
      "uniqueItems": true,
      "items": {
        "type": "string"
      }
    }
  },
  "required": [
    "description",
    "type",
    "version",
    "name",
    "uuid",
    "values",
    "authors",
    "source"
  ]
}
~~~~

# Acknowledgements

The authors wish to thank all the MISP community who are supporting the creation
of open standards in threat intelligence sharing.

<reference anchor='MISP-P' target='https://github.com/MISP'>
  <front>
   <title>MISP Project - Malware Information Sharing Platform and Threat Sharing</title>
   <author initials='' surname='MISP' fullname='MISP Community'></author>
   <date></date>
  </front>
</reference>

<reference anchor='MISP-T' target='https://github.com/MISP/misp-taxonomies'>
  <front>
   <title>MISP Taxonomies - shared and common vocabularies of tags</title>
   <author initials='' surname='MISP' fullname='MISP Community'></author>
   <date></date>
  </front>
</reference>

<reference anchor='MISP-G' target='https://github.com/MISP/misp-galaxy'>
  <front>
   <title>MISP Galaxy - Public Repository</title>
   <author initials='' surname='MISP' fullname='MISP Community'></author>
   <date></date>
  </front>
</reference>

<reference anchor='MISP-G-DOC' target='https://www.misp-project.org/galaxy.html'>
  <front>
   <title>MISP Galaxy - Documentation of the Public Repository</title>
   <author initials='' surname='MISP' fullname='MISP Community'></author>
   <date></date>
  </front>
</reference>


<reference anchor='MISP-R' target='https://github.com/MISP/misp-objects/tree/master/relationships'>
  <front>
   <title>MISP Object Relationship Types - common vocabulary of relationships</title>
   <author initials='' surname='MISP' fullname='MISP Community'></author>
   <date></date>
  </front>
</reference>

<reference anchor='JSON-SCHEMA' target='https://tools.ietf.org/html/draft-wright-json-schema'>
  <front>
    <title>JSON Schema: A Media Type for Describing JSON Documents</title>
    <author initials='' surname='' fullname='Austin Wright'></author>
    <date year="2016"></date>
  </front>
</reference>

<reference anchor='CFR' target='https://www.cfr.org/interactive/cyber-operations'>
  <front>
     <title>Cyber Operations Tracker - Council on Foreign Relations</title>
     <author initials='' surname='CFR' fullname='Council on Foreign Relations'></author>
     <date year="2018"></date>
  </front>
</reference>

{backmatter}
