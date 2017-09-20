% Title = "MISP taxonomy format"
% abbrev = "MISP taxonomy format"
% category = "info"
% docName = "draft-dulaunoy-misp-taxonomy-format"
% ipr= "trust200902"
% area = "Security"
%
% date = 2017-09-04T00:00:00Z
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

This document describes the MISP galaxy format which describes a simple JSON format to represent galaxies and clusters that can be attached to MISP events or attributes. A public directory of MISP galaxies is available and relies on the MISP galaxy format. MISP galaxies are used to add further informations on a MISP event.

{mainmatter}

# Introduction

Sharing threat information became a fundamental requirements on the Internet, security and intelligence community at large. Threat information can include indicators of compromise, malicious file indicators, financial fraud indicators or even detailed information about a threat actor. Some of these informations, such as malwares or threat actors are common to several security events. MISP galaxy is a public repository of known malwares, threats actors or methods that can be used in threat information sharing.

In the MISP galaxy context, clusters help analysts to give more informations about their cybersecurity events, indicators or threats. MISP galaxies can be used for classification, filtering, triggering actions or visualisation depending on their use in threat intelligence platforms such as MISP [@?MISP-P].

##  Conventions and Terminology

The key words "**MUST**", "**MUST NOT**", "**REQUIRED**", "**SHALL**", "**SHALL NOT**",
"**SHOULD**", "**SHOULD NOT**", "**RECOMMENDED**", "**MAY**", and "**OPTIONAL**" in this
document are to be interpreted as described in RFC 2119 [@!RFC2119].

# Format

A cluster is composed of a value (**MUST**), a description (**OPTIONAL**) and metadata (**OPTIONAL**).

Clusters are represented as a json dictionary.

## Overview

The MISP galaxy format uses the JSON [@!RFC4627] format. Each galaxy is represented as a JSON object with meta information including the following fields: name, uuid, description, version, type, authors, source, values.

name defines teh name of the galaxy. The name is represented as a string and **MUST** be present. +uuid represents the Universally Unique IDentifier (UUID) [@!RFC4122] of the object reference. The uuid **MUST** be preserved. For any updates or transfer of the same object reference. UUID version 4 is **RECOMMENDED** when assigning it to a new object reference and **MUST** be present. The description is represented as a string and **MUST** be present. The uuid is represented as a string and **MUST** be present. The version is represented as a decimal and **MUST** be present. The source is represented as a string and **MUST** be present. Authors are represented as an array containing one or more author and **MUST** be present.

Values are represented as an array containing one or more value and **MUST** be present. Values defines all values available in the galaxy.

## values

The values array contains one or more JSON objects which represents all the possible values in the galaxy. The JSON object contains three fields: value description and meta.
The value is represented as a string and **MUST** be present. The description is represented as a string and **SHOULD** be present. The meta or metadata is represented as a JSON object and **SHOULD** be present.

## meta

Meta or metadata JSON object contains one or more elements which give complementary information about the value. Meta **MAY** contains the following fields: properties, complexity, effectiveness, country, possible_issues, colour, motive, impact, refs, synonyms, derivated_from, status, date, encryption, extensions, ransomnotes.

properties is used to provide clusters with additional properties. Properties are represented as an array containing one or more strings ans **MAY** be present.

complexity, effectiveness, impact, possible_issues **MAY** be used to give further information in preventive-measure galaxy. complexity is represented by an enumerated value from a fixed vocabulary and **SHALL** be present. effectiveness is represented by an enumerated value from a fixed vocabulary and **SHALL** be present. impact is represented by an enumerated value from a fixed vocabulary and **SHALL** be present. possible_issues is represented as a string and **SHOULD** be present.

country, motive **MAY** be used to give further information in threat-actor galaxy. country is represented as a string and **SHOULD** be present. motive is represented as a string and **SHOULD** be present.

colour fields MAY be used at predicates or values level to set a specify colour that MAY be used by the implementation. The colour field is described as an RGB colour fill in hexadecimal representation.

encryption, extensions, ransomnotes **MAY** be used to give fursther information in ransomware galaxy. encryption is represented as a string and **SHALL** be present. extensions is represented as an array containing one or more strings and **SHALL** be present. ransomnotes is represented as an array containing one or more strings ans **SHALL** be present.

date, status **MAY** be used to give time information about an cluster. date is represented as a string decribing a time or period and **SHALL** be present. status is represented as a string describing the current status of the clusters. It **MAY** also describe a time or period and **SHALL** be present.

derivated_from, refs, synonyms **SHALL** be used to give further informations. refs is represented as an containing one or ore string and **SHALL** be present. synonyms is represented as an containing one or ore string and **SHALL** be present. derivated_from is represented as an containing one or ore string and **SHALL** be present.
