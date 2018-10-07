% Title = "MISP query format"
% abbrev = "MISP query format"
% category = "info"
% docName = "draft-dulaunoy-misp-core-format"
% ipr= "trust200902"
% area = "Security"
%
% date = 2018-10-08T00:00:00Z
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
%   code = "L-1160"
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
%   street = "16, bd d'Avranches"
%   city = "Luxembourg"
%   code = "L-1160"
%   country = "Luxembourg"

.# Abstract

This document describes the MISP query format used to search MISP (Malware Information and threat Sharing Platform) [@?MISP-P] threat intelligence instances.
MISP query format is a simple format used to query MISP instances over a REST (Representational State Transfer ) interface.
The query format includes the JSON format to describe the query and the minimal API access to perform the query.  The JSON format includes the overall structure along with the semantic associated for each respective key. The goal of the format is to query MISP threat intelligence instances can feed and integrate with network security devices (such as firewall, network intrusion detection system, routers, SIEMs), endpoint security devices or monitoring devices.

{mainmatter}

# Introduction

Sharing threat information became a fundamental requirements in the Internet, security and intelligence community at large. Threat
information can include indicators of compromise, malicious file indicators, financial fraud indicators
or even detailed information about a threat actor. MISP [@?MISP-P] started as an open source project in late 2011 and
the MISP format started to be widely used as an exchange format within the community in the past years. The core format
is described in an Internet-Draft as misp-core-format [@?MISP-C] and contain the standard MISP JSON format used for threat
intelligence.

The aim of this document is to describe the specification of the MISP query format and how the query can be perform against a REST interface.

##  Conventions and Terminology

The key words "**MUST**", "**MUST NOT**", "**REQUIRED**", "**SHALL**", "**SHALL NOT**",
"**SHOULD**", "**SHOULD NOT**", "**RECOMMENDED**", "**MAY**", and "**OPTIONAL**" in this
document are to be interpreted as described in RFC 2119 [@!RFC2119].

# Format

## Overview

The MISP query format is in the JSON [@!RFC4627] format.


## query format criteria

### returnFormat

returnFormat **MUST** be present. returnFormat sets the type of output format. MISP allows multiple format (depending of the configuration):

| value         |                               Description                                 |
|---------------|:-------------------------------------------------------------------------:|
| json          | MISP JSON core format as described in [@?MISP-C]                          |
| xml           | MISP XML format                                                           |
| openioc       | OpenIOC format                                                            |
| suricata      | Suricata NIDS format                                                      |
| snort         | Snort NIDS format                                                         |
| csv           | CSV format                                                                |
| rpz           | Response policy zone format                                               |
| text          | Raw value list format                                                     |

### limit

limit **MAY** be present. If present, the page parameter **MUST** also be supplied. limit sets the number of returned elements when paginating, depending on the scope of the request (x number of attributes or x number of events) as converted into the output format.

### page

page **MAY** be present. If present, the page parameter **MUST** also be supplied. page generates the offset for the pagination and will return a result set consisting of a slice of the query results starting with offset (limit * page) + 1 and ending with (limit * (page+1)).

### value

value **MAY** be present. If set, the returned data set will be filtered on the attribute value field. value **MAY** be a string or a sub-string, the latter of which start with, ends with or is encapsulated in wildcard (\%) characters.

### type

type **MAY** be present. If set, the returned data set will be filtered on the attribute type field. type **MAY** be a string or a sub-string, the latter of which start with, ends with or is encapsulated in wildcard (\%) characters. The list of valid attribute types is described in the MISP core format [@?MISP-C] in the attribute type section.

### category

category **MAY** be present. If set, the returned data set will be filtered on the attribute category field. category **MAY** be a string or a sub-string, the latter of which start with, ends with or is encapsulated in wildcard (\%) characters. The list of valid categories is described in the MISP core format [@?MISP-C] in the attribute type section.

# Security Considerations

MISP threat intelligence instances might contain sensitive or confidential information. Adequate access control and encryption measures shall be implemented to ensure the confidentiality of the threat intelligence.

Adversaries might include malicious content in MISP queries.  Implementation **MUST** consider the input of malicious inputs beside the
standard threat information that might already include malicious intended inputs.

# Acknowledgements

The authors wish to thank all the MISP community who are supporting the creation
of open standards in threat intelligence sharing. A special thank to all the committees which
triggered us to come with better and flexible format.


<reference anchor='MISP-P' target='https://github.com/MISP'>
  <front>
   <title>MISP Project - Malware Information Sharing Platform and Threat Sharing</title>
   <author initials='' surname='MISP' fullname='MISP Community'></author>
   <date></date>
  </front>
</reference>

<reference anchor='MISP-C' target='https://tools.ietf.org/html/draft-dulaunoy-misp-core-format'>
  <front>
   <title>MISP core format</title>
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


{backmatter}
