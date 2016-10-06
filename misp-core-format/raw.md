% Title = "MISP core format"
% abbrev = "MISP core format"
% category = "info"
% docName = "draft-dulaunoy-misp-core-format"
% ipr= "trust200902"
% area = "Security"
%
% date = 2016-10-01T00:00:00Z
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
%   street = "41, avenue de la gare"
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
%   street = "41, avenue de la gare"
%   city = "Luxembourg"
%   code = "L-1611"
%   country = "Luxembourg"

.# Abstract

This document describes the MISP core format used to exchange indicators and threat information between
MISP (Malware Information and threat Sharing Platform) instances.
The JSON format includes the overall structure along with the semantic associated for each
respective key. The format is described to support other implementations which reuse the
format and ensuring an interoperability with existing MISP [@?MISP-P] software and other Threat Intelligence Platforms.

{mainmatter}

# Introduction

Sharing threat information became a fundamental requirements in the Internet, security and intelligence community at large. Threat
information can include indicators of compromise, malicious file indicators, financial fraud indicators
or even detailed information about a threat actor. MISP started as an open source project in late 2011 and
the MISP format started to be widely used as an exchange format within the community in the past years. The aim of this document
is to describe the specification and the MISP core format.

##  Conventions and Terminology

The key words "**MUST**", "**MUST NOT**", "**REQUIRED**", "**SHALL**", "**SHALL NOT**",
"**SHOULD**", "**SHOULD NOT**", "**RECOMMENDED**", "**MAY**", and "**OPTIONAL**" in this
document are to be interpreted as described in RFC 2119 [@!RFC2119].

# Format

## Overview

The MISP core format is in the JSON [@!RFC4627] format. In MISP, an event is composed of a single JSON object.

A capitalized key (like Event, Org) represent a data model and a non-capitalized key is just an attribute. This nomenclature
can support an implementation to represent the MISP format in another data structure.

## Event

An event is a simple meta structure scheme where attributes and meta-data are embedded to compose a coherent set
of indicators. An event can be composed from an incident, a security analysis report or a specific threat actor
analysis. The meaning of an event only depends of the information embedded in the event.

### Event Attributes

#### uuid

uuid represents the Universally Unique IDentifier (UUID) [@!RFC4122] of the event. The uuid MUST be preserved
for any updates or transfer of the same event. UUID version 4 is RECOMMENDED when assigning it to a new event.

uuid is represented as a JSON string. uuid MUST be present.

#### id

id represents the human-readable identifier associated to the event for a specific MISP instance.

id is represented as a JSON string. id SHALL be present.

#### published

published represents the event publication state. If the event was published, the published value MUST be true.
In any other publication state, the published value MUST be false.

published is represented as a JSON boolean. published MUST be present.

#### info

info represents the information field of the event. info a free-text value to provide a human-readable summary
of the event. info SHOULD NOT be bigger than 256 characters.

info is represented as a JSON string. info MUST be present.

#### threat_level_id

threat_level_id represents the threat level.

0:
:   Undefined

1:
:   Low

2:
:   Medium

3:
:   High

If a higher granularity is required, a MISP taxonomy applied as a Tag SHOULD be preferred.

threat_level_id is represented as a JSON string. threat_level_id SHALL be present.


#### date

date represents a reference date to the event in ISO 8601 format (date only: YYYY-MM-DD). This date corresponds to the date the event occured, which may be in the past.

date is represented as a JSON string.

#### timestamp

timestamp represents a reference time when the event, or one of the attributes within the event was created, or last updated/edited on the instance. timestamp is expressed in seconds (decimal) since 1st of January 1970 (Unix timestamp). The time zone MUST be UTC.

timestamp is represented as a JSON string. timestamp MUST be present.

#### publish_timestamp

publish_timestamp represents a reference time when the event was published on the instance. published_timestamp is expressed in seconds (decimal) since 1st of January 1970 (Unix timestamp). At each publication of an event, publish_timestamp MUST be updated. The time zone MUST be UTC.

publish_timestamp is represented as a JSON string. publish_timestamp MUST be present.

#### org_id

org_id represents a human-readable identifier referencing an Org object of the organization which generated the event.

The org_id MUST be updated when the event is generated by a new instance.

org_id is represented as a JSON string. org_id MUST be present.

#### orgc_id

orgc_id represents a human-readable identifier referencing an Orgc object of the organization which created the event.

The orgc_id and Orc object MUST be preserved for any updates or transfer of the same event.

orgc_id is represented as a JSON string. orgc_id MUST be present.

#### attribute_count

attribute_count represents the number of attributes in the event. attribute_count is expressed in decimal.

attribute_count is represented as a JSON string. attribute_count SHALL be present.

## Objects

### Org

An Org object is composed of an uuid, name and id.

The uuid represents the Universally Unique IDentifier (UUID) [@!RFC4122] of the organization.
The organization UUID is globally assigned to an organization and SHALL be kept overtime.

The name is a readable description of the organization and SHOULD be present.
The id is a human-readable identifier generated by the instance and used as reference in the event.

uuid, name and id are represented as a JSON string. uuid, name and id MUST be present.

#### Sample Org Object

~~~~
"Org": {
        "id": "2",
        "name": "CIRCL",
        "uuid": "55f6ea5e-2c60-40e5-964f-47a8950d210f"
       }
~~~~

### Orgc

An Orgc object is composed of an uuid, name and id.

The uuid MUST be preserved for any updates or transfer of the same event. UUID version 4 is RECOMMENDED when assigning it to a new event.
The organization UUID is globally assigned to an organization and SHALL be kept overtime.

The name is a readable description of the organization and SHOULD be present.
The id is a human-readable identifier generated by the instance and used as reference in the event.

uuid, name and id are represented as a JSON string. uuid, name and id MUST be present.


## Attribute

Attributes are used to describe the indicators and contextual data of an event. The main information contained in an attribute is made up of a category-type-value triplet,
where the category and type give meaning and context to the value. Through the various category-type combinations a wide range of information can be conveyed.

### Sample Attribute Object

~~~~
"Attribute": {
              "id": "346056",
              "type": "comment",
              "category": "Other",
              "to_ids": false,
              "uuid": "57f4f6d9-cd20-458b-84fd-109ec0a83869",
              "event_id": "3357",
              "distribution": "5",
              "timestamp": "1475679332",
              "comment": "",
              "sharing_group_id": "0",
              "deleted": false,
              "value": "Hello world",
              "SharingGroup": [],
              "ShadowAttribute": []
             }
~~~~

### Attribute Attributes

#### uuid

uuid represents the Universally Unique IDentifier (UUID) [@!RFC4122] of the event. The uuid MUST be preserved
for any updates or transfer of the same event. UUID version 4 is RECOMMENDED when assigning it to a new event.

uuid is represented as a JSON string. uuid MUST be present.

#### id

id represents the human-readable identifier associated to the event for a specific MISP instance.

id is represented as a JSON string. id SHALL be present.

#### type

type represents the means through which an attribute tries to describe the intent of the attribute creator, using a list of pre-defined attribute types.

type is represented as a JSON string. type MUST be present and it MUST be a valid selection for the chosen category. The list of valid category-type combinations is as follows:

**Internal reference**
:   text, link, comment, other

**Targeting data**
:   target-user, target-email, target-machine, target-org, target-location, target-external, comment

**Antivirus detection**
:   link, comment, text, attachment, other

**Payload delivery**
:   md5, sha1, sha224, sha256, sha384, sha512, sha512/224, sha512/256, ssdeep, imphash, authentihash, pehash, tlsh, filename, filename|md5, filename|sha1, filename|sha224, filename|sha256, filename|sha384, filename|sha512, filename|sha512/224, filename|sha512/256, filename|authentihash, filename|ssdeep, filename|tlsh, filename|imphash, filename|pehash, ip-src, ip-dst, hostname, domain, email-src, email-dst, email-subject, email-attachment, url, user-agent, AS, pattern-in-file, pattern-in-traffic, yara, attachment, malware-sample, link, malware-type, comment, text, vulnerability, x509-fingerprint-sha1, other

**Artifacts dropped**
:   md5, sha1, sha224, sha256, sha384, sha512, sha512/224, sha512/256, ssdeep, imphash, authentihash, filename, filename|md5, filename|sha1, filename|sha224, filename|sha256, filename|sha384, filename|sha512, filename|sha512/224, filename|sha512/256, filename|authentihash, filename|ssdeep, filename|tlsh, filename|imphash, filename|pehash, regkey, regkey|value, pattern-in-file, pattern-in-memory, pdb, yara, attachment, malware-sample, named pipe, mutex, windows-scheduled-task, windows-service-name, windows-service-displayname, comment, text, x509-fingerprint-sha1, other

**Payload installation**
:   md5, sha1, sha224, sha256, sha384, sha512, sha512/224, sha512/256, ssdeep, imphash, authentihash, pehash, tlsh, filename, filename|md5, filename|sha1, filename|sha224, filename|sha256, filename|sha384, filename|sha512, filename|sha512/224, filename|sha512/256, filename|authentihash, filename|ssdeep, filename|tlsh, filename|imphash, filename|pehash, pattern-in-file, pattern-in-traffic, pattern-in-memory, yara, vulnerability, attachment, malware-sample, malware-type, comment, text, x509-fingerprint-sha1, other

**Persistence mechanism**
:   filename, regkey, regkey|value, comment, text, other

**Network activity**
:   ip-src, ip-dst, hostname, domain, domain|ip, email-dst, url, uri, user-agent, http-method, AS, snort, pattern-in-file, pattern-in-traffic, attachment, comment, text, x509-fingerprint-sha1, other

**Payload type**
:   comment, text, other

**Attribution**
:   threat-actor, campaign-name, campaign-id, whois-registrant-phone, whois-registrant-email, whois-registrant-name, whois-registrar, whois-creation-date, comment, text, x509-fingerprint-sha1, other

**External analysis**
:   md5, sha1, sha256, filename, filename|md5, filename|sha1, filename|sha256, ip-src, ip-dst, hostname, domain, domain|ip, url, user-agent, regkey, regkey|value, AS, snort, pattern-in-file, pattern-in-traffic, pattern-in-memory, vulnerability, attachment, malware-sample, link, comment, text, x509-fingerprint-sha1, other

**Financial fraud**
:   btc, iban, bic, bank-account-nr, aba-rtn, bin, cc-number, prtn, comment, text, other

**Other**
:   comment, text, other

#### category

category represents the intent of what the attribute is describing as selected by the attribute creator, using a list of pre-defined attribute categories.

category is represented as a JSON string. category MUST be present and it MUST be a valid selection for the chosen type. The list of valid category-type combinations is mentioned above.

#### to\_ids

to\_ids represents whether the attribute is meant to be actionable.

to\_ids is represented as a JSON boolean. to\_ids MUST be present.

#### event\_id

event\_id represents a human-readable identifier referencing the Event object that the attribute belongs to.

The event\_id SHOULD be updated when the event is imported to reflect the newly created event's id on the instance.

event\_id is represented as a JSON string. event\_id MUST be present.

#### distribution

distribution represents the basic distribution rules of the attribute. The system must adhere to the distribution setting for access control and for dissemination of the attribute.

distribution is represented by a JSON string. distribution MUST be present and be one of the following options:

0
:   Your Organisation Only

1
:   This Community Only

2
:   Connected Communities

3
:   All Communities

4
:   Sharing Group

5
:   Inherit Event

#### timestamp

timestamp represents a reference time when the attribute was created or last modified. timestamp is expressed in seconds (decimal) since 1st of January 1970 (Unix timestamp). The time zone MUST be UTC.

timestamp is represented as a JSON string. timestamp MUST be present.

#### comment

comment is a contextual comment field. 

comment is represented by a JSON string. comment MAY be present.

#### sharing_group_id

sharing\_group\_id represents a human-readable identifier referencing a Sharing Group object that defines the distribution of the attribute, if distribution level "4" is set.

sharing\_group\_id is represented by a JSON string and MUST be present. If a distribution level other than "4" is chosen the sharing\_group\_id MUST be set to "0".

#### deleted

deleted represents a setting that allows attributes to be revoked. Revoked attributes are not actionable and exist merely to inform other instances of a revocation.

deleted is represented by a JSON boolean. deleted MUST be present.

#### value

value represents the payload of an attribute. The format of the value is dependent on the type of the attribute.

value is represented by a JSON string. value MUST be present.

# Acknowledgements

The authors wish to thank all the MISP community to support the creation
of open standards in threat intelligence sharing.

<reference anchor='MISP-P' target='https://github.com/MISP'>
  <front>
   <title>MISP Project - Malware Information Sharing Platform and Threat Sharing</title>
   <author initials='' surname='MISP' fullname='MISP Community'></author>
   <date></date>
  </front>
</reference>


{backmatter}


