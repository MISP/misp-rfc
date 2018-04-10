% Title = "MISP galaxy format"
% abbrev = "MISP galaxy format"
% category = "info"
% docName = "draft-dulaunoy-misp-warninglists-format"
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

This document describes the MISP warninglist format which describes a simple JSON format to represent warninglists that can be used in MISP. A public directory of MISP warninglists is available and relies on the MISP warninglist format. MISP warninglists are used to detect false positives inside the attributes of a MISP event. MISP warninglists is a public repository composed of list of hostnames, ip addresses and various other collections of data that can be used to detect false positives.

{mainmatter}

# Introduction

Sharing threat information became a fundamental requirements on the Internet, security and intelligence community at large. Threat information n  include indicators of compromise, malicious file indicators, financial fraud indicators or even detailed information about a threat actor. However, it sometimes happens that analysts make mistakes and start to share informations that can be considered as false positive, leading to some errors in analysis. MISP warninglists have been created in order to detect such mistakes more easily.

MISP warninglists is a public repository of known false positives collections, such as hash values of empty files, known domains and hostnames from Google or even security providers or vendors blog domains.

##  Conventions and Terminology

The key words "**MUST**", "**MUST NOT**", "**REQUIRED**", "**SHALL**", "**SHALL NOT**",
"**SHOULD**", "**SHOULD NOT**", "**RECOMMENDED**", "**MAY**", and "**OPTIONAL**" in this
document are to be interpreted as described in RFC 2119 [@!RFC2119].

# Format

Warninglists are represented as a JSON [@!RFC4627] dictionary.

## Overview

The MISP warninglist format uses the JSON [@!RFC4627] format. Each warninglist is represented as a JSON object with meta information including the following fields: name, description, version, type, matching_attributes, list.

name defines the name of the warninglist. The name is represented as a string and **MUST** be present. The description is represented as a string and **MUST** be present. The version is represented as a decimal and **MUST** be present. matching_attributes is represented as an array containing one or more values and is **RECOMMENDED**. type is represented as a string from an non exaustive list and **MUST** be present.

list is represented as an array containing one or more values and **MUST** be present. list defines all values defined in the warninglist.

#list

The list array contains one or more strings which represents all the values referenced in the warninglist.

Example of the empty-hashes warninglist:
~~~~
{
  "name": "List of known hashes for empty files",
  "version": 2,
  "description": "Event contains one or more entries of empty files based on known hashed",
  "matching_attributes": [
    "md5",
    "sha1",
    "sha224",
    "sha256",
    "sha512",
    "filename|md5",
    "filename|sha1",
    "filename|sha224",
    "filename|sha256",
    "filename|sha512"
  ],
  "type": "string",
  "list": [
    "d41d8cd98f00b204e9800998ecf8427e",
    "da39a3ee5e6b4b0d3255bfef95601890afd80709",
    "d14a028c2a3a2bc9476102bb288234c415a2b01f828ea62ac5b3e42f",
    "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
    "cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e"
  ]
}
~~~~

# Acknowledgements

The authors wish to thank all the MISP community who are supporting the creation
of open standards in threat intelligence sharing.

{backmatter}
