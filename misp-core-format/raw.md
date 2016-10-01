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
% initials="M."
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

.# Abstract

This document describes the MISP core format used to exchange indicators and threat information between
MISP (Malware Information and threat Sharing Platform) instances.
The JSON format includes the overall structure along with the semantic associated for each
respective key. The format is described to support other implementations which reuse the
format and ensuring an interoperability with existing MISP [@?MISP-P] software and other Threat Intelligence Platform.

{mainmatter}

# Introduction

Sharing threat information became a fundamental requirements in the Internet, security and intelligence community at large. Threat
information can include indicators of compromise, malicious file indicators, financial fraud indicators
or even detailed information about a threat actor. MISP started as an open source project in late 2011

# Format

## Overview

The MISP core format is in the JSON [@!RFC4627] format. In MISP, an event is composed of a single JSON object.

## Event

An event is a simple meta structure scheme where attributes are embedded 


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


