% Title = "MISP noticelist format"
% abbrev = "MISP noticelist format"
% category = "info"
% docName = "draft-dulaunoy-misp-noticelist-format"
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

This document describes the MISP noticelist format which describes a simple JSON format to represent list of elements

represent galaxies and clusters that can be attached to MISP events or attributes. A public directory of MISP galaxies is available and relies on the MISP galaxy format. MISP galaxies are used to add further informations on a MISP event. MISP galaxy is a public repository [@?MISP-G] of known malware, threats actors and various other collections of data that can be used to mark, classify or label data in threat information sharing.

{mainmatter}

# Introduction
Sharing threat information became a fundamental requirements on the Internet, security and intelligence community at large. Threat information can include indicators of compromise, malicious file indicators, financial fraud indicators or even detailed information about a threat actor. Therefore, there are still information that can not be shared freely to everyone, for several reasons, and it is essential for the user to have a way to know about which information he have to be cautious, as well as an easy way for administrators to give user a reminder of it.

MISP noticelist is a public repository of list of notices to show to the user about the information he uses or share.

##  Conventions and Terminology

The key words "**MUST**", "**MUST NOT**", "**REQUIRED**", "**SHALL**", "**SHALL NOT**",
"**SHOULD**", "**SHOULD NOT**", "**RECOMMENDED**", "**MAY**", and "**OPTIONAL**" in this
document are to be interpreted as described in RFC 2119 [@!RFC2119].

# Format

Noticelist are represented as a JSON [@!RFC4627] dictionary.

## Overview

The MISP noticelist format uses the JSON [@!RFC4627] format. Each noticelist is represented as a JSON object with meta information including the following fields: name, expended_name, ref, geographical_area and notice.

name defines the name of the noticelist. It **MUST** match the name of the folder containing the list. The name is represented as a string and **MUST** be present. expended_name defines the full name of the noticelist. The expended_name is represented by a string and **MUST** be present. ref defines the references used to create the notice list. ref is represented as an array containing one or more references and **MUST** pe present. Each reference is a string and **MUST** be present. geographical_area defines the geographical area affected by this noticelist. geographical_area is represented as an array containing one or more descriptions of geographical area ans **SHOULD** be present. Each geographical area is a string and **SHOULD** be present.

notice is represented as an array containing one or more values and **MUST** be present. notice defines all values available in the noticelist.

## notice

The notice array contains one or more JSON objects which represent all the possible values in the noticelist. The JSON object contains five fields: scope,
field, value, tags and message.

scope is represented as an array containing one or more scopes to apply the notice ans **MUST** be present. Each scope is a string and **MUST** be present. field is represented as an array containing one or more fields to apply the notice ans **MUST** be present. Each field is a string and **MUST** be present. value is represented as an array containing one or more values and **MUST** be present. Each value is a string and **MUST** be present. tags is represented as an array containing one or more values and **MUST** be present. Each tag is a string and **MUST** be present. message is represented as a JSON dictionary containing one or more messages translated in different languages and **MUST** be present. Each element in the message dictionary is a couple name/value where the name designate a language and the value contains a string representing a message to display to the user. These elements **MUST** be present.

Example of an element of the notice array

~~~~
{
   "scope": ["attribute"],
   "field": ["category", "meta-category"],
   "value": [
      "Targeting data",
      "Attribution",
      "Financial fraud",
      "Social network",
      "Person"
   ],
   "tags": ["fpf:degrees-of-identifiability='explicitly-personal'"],
   "message": {
      "en": "This attribute is likely to contain personal data and the data subject is likely to be directly identifiable. Please verify that the processing of personal data is necessary and proportionate to the purposes (e.g. ensuring network and information security) and that you have a legal ground to share those personal data. Where applicable, please ensure that you have taken the necessary steps to ensure transparency towards the data subject in relation to the processing of their personal data."
   }
}
~~~~
