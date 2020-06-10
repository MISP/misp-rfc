%%%
Title = "Recommendations on naming threat actors"
abbrev = "Recommendations on naming threat actors"
category = "info"
docName = "draft-dulaunoy-threat-actor-naming"
ipr= "trust200902"
area = "Security"

date = 2020-06-09T00:00:00Z

[[author]]
initials="A."
surname="Dulaunoy"
fullname="Alexandre Dulaunoy"
abbrev="CIRCL"
organization = "Computer Incident Response Center Luxembourg"
 [author.address]
 email = "alexandre.dulaunoy@circl.lu"
 phone = "+352 247 88444"
 [author.address.postal]
 street = "16, bd d'Avranches"
 city = "Luxembourg"
 code = "L-1160"
 country = "Luxembourg"
[[author]]
initials="P."
surname="Bourmeau"
fullname="Pauline Bourmeau"
abbrev="CIRCL"
organization = "Corexalys"
 [author.address]
 email = "info@corexalys.com"
 phone = ""
 [author.address.postal]
 street = "26 Rue de la Bienfaisance"
 city = "Paris"
 code = "75008"
 country = "France"
%%%

.# Abstract

This document provides advice on the naming of threat actors (also known as malicious actors).
The objective is to provide practical advices for organisations such as security vendors or organisations attributing
incidents to a group of threat actor. It also discusses the implication of naming a threat actor towards intelligence analysts
and threat intelligence platforms such as MISP [@?MISP-P]].

{mainmatter}

# Introduction

##  Conventions and Terminology

The key words "**MUST**", "**MUST NOT**", "**REQUIRED**", "**SHALL**", "**SHALL NOT**",
"**SHOULD**", "**SHOULD NOT**", "**RECOMMENDED**", "**MAY**", and "**OPTIONAL**" in this
document are to be interpreted as described in RFC 2119 [@!RFC2119].

# Recommendations

## Reusing threat actor naming

Before creating a new threat actor name, you **MUST** consider a review of existing threat actor names from databases such as the threat actor
MISP galaxy [@!MISP-G]. Proliferation of threat actor names is a significant challenge for the day-to-day analyst work. If your threat actor defined an existing threat actor, you **MUST**
reuse an existing threat actor name. If there is no specific threat actor name, you **SHALL** create a new threat actor following the best
practices defined in this document.

## Don't confuse actor naming with malware naming

## Format

## Encoding

## Directory
 
# Examples

# Security Considerations

Naming a threat actor could include specific sensitive reference to a case or an incident. Before releasing the naming, the creator
**MUST** review the name to ensure no sensitive information is included in the threat actor name.

# Acknowledgements

The authors wish to thank all contributors who provided feedback via Twitter.

# References


<reference anchor='MISP-P' target='https://github.com/MISP'>
  <front>
   <title>MISP Project - Open Source Threat Intelligence Platform and Open Standards For Threat Information Sharing</title>
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
   <title>MISP Galaxy - Public repository </title>
   <author initials='' surname='MISP' fullname='MISP Community'></author>
   <date></date>
  </front>
</reference>


{backmatter}
