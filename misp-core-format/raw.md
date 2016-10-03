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

date represents a reference date to the event in year-month-date format. For a more precise time reference, the timestamp key is used.

date is represented as a JSON string.

#### timestamp

timestamp represents a reference time when the event was created. timestamp is expressed in seconds (decimal) since 1st of January 1970 (Unix timestamp). The time zone MUST be UTC.

timestamp is represented as a JSON string. timestamp MUST be present.

#### publish_timestamp

publish_timestamp represents a reference time when the event was published. published_timestamp is expressed in seconds (decimal) since 1st of January 1970 (Unix timestamp). At each publication of an event, publish_timestamp MUST be updated. The time zone MUST be UTC.

publish_timestamp is represented as a JSON string. publish_timestamp MUST be present.

#### org_id

org_id represents the Universally Unique IDentifier (UUID) [@!RFC4122] of the organization which generated the event. The org_id MUST
be updated when the event is generated by a new instance.

org_id is represented as a JSON string. org_id MUST be present.

#### orgc_id

orgc_id represents the Universally Unique IDentifier (UUID) [@!RFC4122] of the organization which created the event.
The orgc_id MUST be preserved for any updates or transfer of the same event. UUID version 4 is RECOMMENDED when assigning it to a new event.
orgc_id is globally assigned to an organization and SHALL be kept overtime.

orgc_id is represented as a JSON string. orgc_id MUST be present.

#### attribute_count

attribute_count represents the number of attributes in the event. attribute_count is expressed in decimal.

attribute_count is represented as a JSON string. attribute_count SHALL be present.

<reference anchor='MISP-P' target='https://github.com/MISP'>
  <front>
   <title>MISP Project - Malware Information Sharing Platform and Threat Sharing</title>
   <author initials='' surname='MISP' fullname='MISP Community'></author>
   <date></date>
  </front>
</reference>

{backmatter}

# Acknowledgements

The authors wish to thank all the MISP community to support the creation
of open standards in threat intelligence sharing.


