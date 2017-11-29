% Title = "MISP taxonomy format"
% abbrev = "MISP taxonomy format"
% category = "info"
% docName = "draft-dulaunoy-misp-taxonomy-format"
% ipr= "trust200902"
% area = "Security"
%
% date = 2017-11-29T00:00:00Z
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

.# Abstract

This document describes the MISP taxonomy format which describes a simple JSON format to
represent machine tags (also called triple tags) vocabularies. A public directory of common vocabularies
MISP taxonomies is available and relies on the MISP taxonomy format. MISP taxonomies are used to classify
cyber security events, threats or indicators.

{mainmatter}

# Introduction

Sharing threat information became a fundamental requirements on the Internet, security and intelligence community at large. Threat
information can include indicators of compromise, malicious file indicators, financial fraud indicators
or even detailed information about a threat actor. While sharing such indicators or information, classification plays an important role
to ensure adequate distribution, understanding, validation or action of the shared information. MISP taxonomies is a public repository
of known vocabularies that can be used in threat information sharing.

Machine tags were introduced in 2007 [@?machine-tags] to allow users to be more precise when tagging their pictures with geolocation.
So a machine tag is a tag which uses a special syntax to provide more information to users and machines. Machine tags are also known
as triple tags due to their format.

In the MISP taxonomy context, machine tags help analysts to classify their cybersecurity events, indicators or threats. MISP taxonomies can be used for classification, filtering, triggering actions or visualisation depending on their use in threat intelligence platforms such as MISP [@?MISP-P].

##  Conventions and Terminology

The key words "**MUST**", "**MUST NOT**", "**REQUIRED**", "**SHALL**", "**SHALL NOT**",
"**SHOULD**", "**SHOULD NOT**", "**RECOMMENDED**", "**MAY**", and "**OPTIONAL**" in this
document are to be interpreted as described in RFC 2119 [@!RFC2119].

# Format

A machine tag is composed of a namespace (**MUST**), a predicate (**MUST**) and an optional value (**OPTIONAL**).

Machine tags are represented as a string. Below listed are a set of sample machine tags for different namespaces such as tlp, admiralty-scale and osint.

~~~~
tlp:amber
admiralty-scale:information-credibility="1"
osint:source-type="blog-post"
~~~~

The MISP taxonomy format describes how to define a machine tag namespace in a parseable format. The objective is to provide a simple format
to describe machine tag (aka triple tag) vocabularies.

## Overview

The MISP taxonomy format uses the JSON [@!RFC4627] format. Each namespace is represented as a JSON object with meta information including the following fields: namespace, description, version, type.

namespace defines the overall namespace of the machine tag. The namespace is represented as a string and **MUST** be present. The description is represented as a string and **MUST** be present. A version is represented as a decimal and **MUST** be present. A type defines where a specific taxonomy is applicable and a type can be applicable at event, user or org level. The type is represented as an array containing one or more type and **SHOULD** be present. If a type is not mentioned, by default, the taxonomy is applicable at event level only. An exclusive boolean property **MAY** be present and defines at namespace level if the predicates are mutually exclusive.

predicates defines all the predicates available in the namespace defined. predicates is represented as an array of JSON objects. predicates **MUST** be present and **MUST** at least content one element.

values defines all the values for each predicate in the namespace defined. values **SHOULD** be present.

## predicates

The predicates array contains one or more JSON objects which lists all the possible predicates. The JSON object contains two fields: value and expanded. value **MUST** be present. expanded **SHOULD** be present. value is represented as a string and describes the predicate value. The predicate value **MUST** not contain spaces or colons. expanded is represented as a string and describes the human-readable version of the predicate value. An exclusive property **MAY** be present and defines at namespace level if the values are mutually exclusive.

## values

The values array contain one or more JSON objects which lists all the possible values of a predicate. The JSON object contains two fields: predicate and entry. predicate is represented as a string and describes the predicate value. entry is an array with one or more JSON objects. The JSON object contains two fields: value and expanded. value **MUST** be present. expanded **SHOULD** be present. value is represented as a string and describes the machine parsable value. expanded is represented as a string and describes the human-readable version of the value.

## optional fields

### colour

colour fields **MAY** be used at predicates or values level to set a specify colour that **MAY** be used by the implementation. The colour field is described as an RGB colour fill in hexadecimal representation.

Example use of the colour field in the Traffic Light Protocol (TLP):

~~~~
"predicates": [
    {
      "colour": "#CC0033",
      "expanded": "(TLP:RED) Information exclusively and directly
                   given to (a group of) individual recipients.
                   Sharing outside is not legitimate.",
      "value": "red"
    },
    {
      "colour": "#FFC000",
      "expanded": "(TLP:AMBER) Information exclusively given
                   to an organization; sharing limited within
                   the organization to be effectively acted upon.",
      "value": "amber"
    }...]
~~~~

### description

description fields **MAY** be used at predicates or values level to add a descriptive and human-readable information about the specific predicate or value. The field is represented as a string. Implementations **MAY** use the description field to improve more contextual information. The description at the namespace level is a **MUST** as described above.

### numerical_value

numerical_value fields **MAY** be used at a predicate or value level to add a machine-readable numeric value to a specific predicate or value.
The field is represented as a JSON number. Implementations **SHOULD** use the decimal value provided to support scoring or filtering.

Example use of the numerical_value in the MISP confidence level:

~~~~
    {
     "predicate": "confidence-level",
     "entry": [
        {
          "expanded": "Completely confident",
          "value": "completely-confident",
          "numerical_value": 100
        },
        {
          "expanded": "Usually confident",
          "value": "usually-confident",
          "numerical_value": 75
        },
        {
          "expanded": "Fairly confident",
          "value": "fairly-confident",
          "numerical_value": 50
        },
        {
          "expanded": "Rarely confident",
          "value": "rarely-confident",
          "numerical_value": 25
        },
        {
          "expanded": "Unconfident",
          "value": "unconfident",
          "numerical_value": 0
        },
        {
          "expanded": "Confidence cannot be evaluated",
          "value": "confidence-cannot-be-evalued"
        }
     ]
     }
~~~~


# Directory

The MISP taxonomies directory is publicly available [@?MISP-T] in a git repository. The repository
contains a directory per namespace then a file machinetag.json which contains the taxonomy as
described in the format above. In the root of the repository, a MANIFEST.json exists containing
a list of all the taxonomies.

The MANIFEST.json file is composed of an JSON object with metadata like version, license, description, url and path.
A taxonomies array describes the taxonomy available with the description, name and version field.

## Sample Manifest
~~~~
{
  "version": "20161009",
  "license": "CC-0",
  "description": "Manifest file of MISP taxonomies available.",
  "url":
    "https://raw.githubusercontent.com/MISP/misp-taxonomies/master/",
  "path": "machinetag.json",
  "taxonomies": [
    {
      "description": "The Admiralty Scale (also called the NATO System)
                      is used to rank the reliability of a source and
                      the credibility of an information.",
      "name": "admiralty-scale",
      "version": 1
    },
    {
      "description": "Open Source Intelligence - Classification.",
      "name": "osint",
      "version": 2
    }]
}
~~~~

# Sample Taxonomy in MISP taxonomy format

## Admiralty Scale Taxonomy

~~~~
  "namespace": "admiralty-scale",
  "description": "The Admiralty Scale (also called the NATO System)
                  is used to rank the reliability of a source and
                  the credibility of an information.",
  "version": 1,
  "predicates": [
    {
      "value": "source-reliability",
      "expanded": "Source Reliability"
    },
    {
      "value": "information-credibility",
      "expanded": "Information Credibility"
    }
  ],
  "values": [
    {
      "predicate": "source-reliability",
      "entry": [
        {
          "value": "a",
          "expanded": "Completely reliable"
        },
        {
          "value": "b",
          "expanded": "Usually reliable"
        },
        {
          "value": "c",
          "expanded": "Fairly reliable"
        },
        {
          "value": "d",
          "expanded": "Not usually reliable"
        },
        {
          "value": "e",
          "expanded": "Unreliable"
        },
        {
          "value": "f",
          "expanded": "Reliability cannot be judged"
        }
      ]
    },
    {
      "predicate": "information-credibility",
      "entry": [
        {
          "value": "1",
          "expanded": "Confirmed by other sources"
        },
        {
          "value": "2",
          "expanded": "Probably true"
        },
        {
          "value": "3",
          "expanded": "Possibly true"
        },
        {
          "value": "4",
          "expanded": "Doubtful"
        },
        {
          "value": "5",
          "expanded": "Improbable"
        },
        {
          "value": "6",
          "expanded": "Truth cannot be judged"
        }
      ]
    }
  ]
}
~~~~

## Open Source Intelligence - Classification

~~~~
{
  "values": [
    {
      "entry": [
        {
          "expanded": "Blog post",
          "value": "blog-post"
        },
        {
          "expanded": "Technical or analysis report",
          "value": "technical-report"
        },
        {
          "expanded": "News report",
          "value": "news-report"
        },
        {
          "expanded": "Pastie-like website",
          "value": "pastie-website"
        },
        {
          "expanded": "Electronic forum",
          "value": "electronic-forum"
        },
        {
          "expanded": "Mailing-list",
          "value": "mailing-list"
        },
        {
          "expanded": "Block or Filter List",
          "value": "block-or-filter-list"
        },
        {
          "expanded": "Expansion",
          "value": "expansion"
        }
      ],
      "predicate": "source-type"
    },
    {
      "predicate": "lifetime",
      "entry": [
        {
          "value": "perpetual",
          "expanded": "Perpetual",
          "description": "Information available publicly on long-term"
        },
        {
          "value": "ephemeral",
          "expanded": "Ephemeral",
          "description": "Information available publicly on short-term"
        }
      ]
    },
    {
      "predicate": "certainty",
      "entry": [
        {
          "numerical_value": 100,
          "value": "100",
          "expanded": "100% Certainty",
          "description": "100% Certainty"
        },
        {
          "numerical_value": 93,
          "value": "93",
          "expanded": "93% Almost certain",
          "description": "93% Almost certain"
        },
        {
          "numerical_value": 75,
          "value": "75",
          "expanded": "75% Probable",
          "description": "75% Probable"
        },
        {
          "numerical_value": 50,
          "value": "50",
          "expanded": "50% Chances about even",
          "description": "50% Chances about even"
        },
        {
          "numerical_value": 30,
          "value": "30",
          "expanded": "30% Probably not",
          "description": "30% Probably not"
        },
        {
          "numerical_value": 7,
          "value": "7",
          "expanded": "7% Almost certainly not",
          "description": "7% Almost certainly not"
        },
        {
          "numerical_value": 0,
          "value": "0",
          "expanded": "0% Impossibility",
          "description": "0% Impossibility"
        }
      ]
    }
  ],
  "namespace": "osint",
  "description": "Open Source Intelligence - Classification",
  "version": 3,
  "predicates": [
    {
      "value": "source-type",
      "expanded": "Source Type"
    },
    {
      "value": "lifetime",
      "expanded": "Lifetime of the information
                   as Open Source Intelligence"
    },
    {
      "value": "certainty",
      "expanded": "Certainty of the elements mentioned
                   in this Open Source Intelligence"
    }
  ]
}

~~~~

# JSON Schema

The JSON Schema [@?JSON-SCHEMA] below defines the structure of the MISP taxonomy document
as literally described before. The JSON Schema is used validating a MISP taxonomy. The validation
is a *MUST* if the taxonomy is included in the MISP taxonomies directory.

~~~~
{
  "$schema": "http://json-schema.org/schema#",
  "title": "Validator for misp-taxonomies",
  "id": "https://www.github.com/MISP/misp-taxonomies/schema.json",
  "defs": {
    "entry": {
      "type": "array",
      "uniqueItems": true,
      "items": {
        "type": "object",
        "additionalProperties": false,
        "properties": {
          "numerical_value": {
            "type": "number"
          },
          "expanded": {
            "type": "string"
          },
          "description": {
            "type": "string"
          },
          "colour": {
            "type": "string"
          },
          "value": {
            "type": "string"
          },
          "required": [
            "value"
          ]
        }
      }
    },
    "values": {
      "type": "array",
      "uniqueItems": true,
      "items": {
        "type": "object",
        "additionalProperties": false,
        "properties": {
          "entry": {
            "$ref": "#/defs/entry"
          },
          "predicate": {
            "type": "string"
          }
        },
        "required": [
          "predicate"
        ]
      }
    },
    "predicates": {
      "type": "array",
      "uniqueItems": true,
      "items": {
        "type": "object",
        "additionalProperties": false,
        "properties": {
          "numerical_value": {
            "type": "number"
          },
          "colour": {
            "type": "string"
          },
          "description": {
            "type": "string"
          },
          "expanded": {
            "type": "string"
          },
          "value": {
            "type": "string"
          },
          "exclusive": {
            "type": "boolean"
          },
          "required": [
            "value"
          ]
        }
      }
    }
  },
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "version": {
      "type": "integer"
    },
    "description": {
      "type": "string"
    },
    "expanded": {
      "type": "string"
    },
    "namespace": {
      "type": "string"
    },
    "exclusive": {
      "type": "boolean"
    },
    "type": {
      "type": "array",
      "uniqueItems": true,
      "items": {
        "type": "string",
        "enum": [
          "org",
          "user",
          "attribute",
          "event"
        ]
      }
    },
    "refs": {
      "type": "array",
      "uniqueItems": true,
      "items": {
        "type": "string"
      }
    },
    "predicates": {
      "$ref": "#/defs/predicates"
    },
    "values": {
      "$ref": "#/defs/values"
    }
  },
  "required": [
    "namespace",
    "description",
    "version",
    "predicates"
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

<reference anchor='machine-tags' target='https://www.flickr.com/groups/51035612836@N01/discuss/72157594497877875/'>
  <front>
   <title>Machine tags</title>
   <author initials='' surname='' fullname='Aaron Straup Cope'></author>
   <date year="2007"></date>
  </front>
</reference>

<reference anchor='JSON-SCHEMA' target='https://tools.ietf.org/html/draft-wright-json-schema'>
  <front>
    <title>JSON Schema: A Media Type for Describing JSON Documents</title>
    <author initials='' surname='' fullname='Austin Wright'></author>
    <date year="2016"></date>
  </front>
</reference>


{backmatter}
