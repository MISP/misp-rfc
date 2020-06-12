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

In threat intelligence, a name can be assigned to a threat actor without specific guidelines. This leads to issues such
as a:

- A proliferation of threat actor names generating overlaps or different names for similar threat actors (e.g. some threat actors have more than 10 synonyms)
- Ambiguity in the words used to name the threat actor in different contexts (e.g. using common words)
- No clearly defined text format to describe the same threat actor (e.g. Is the threat actor name case sensitive? Is there a dash or a space between the two words?)
- Confusion between techniques/tools used by a threat actor versus its name (e.g. naming a threat actor after a specific malware used)
- Lack of source and list from vendors to describe their threat actor names and the reasoning behind the naming (e.g. did they name the threat actor after a specific set of campaigns? or specific set of targets?)

This document proposes a set of guidelines to name threat actors. The goal is to reduce the above mentioned issues.


##  Conventions and Terminology

The key words "**MUST**", "**MUST NOT**", "**REQUIRED**", "**SHALL**", "**SHALL NOT**",
"**SHOULD**", "**SHOULD NOT**", "**RECOMMENDED**", "**MAY**", and "**OPTIONAL**" in this
document are to be interpreted as described in RFC 2119 [@!RFC2119].

# Recommendations

The recommendations listed below provide a minimal set of guidelines while assigning a new name to a threat actor.

## Reusing threat actor naming

Before creating a new threat actor name, you **MUST** consider a review of existing threat actor names from databases such as the threat actor
MISP galaxy [@!MISP-G]. Proliferation of threat actor names is a significant challenge for the day-to-day analyst work. If your threat actor defined an existing threat actor, you **MUST**
reuse an existing threat actor name. If there is no specific threat actor name, you **SHALL** create a new threat actor following the best
practices defined in this document.

## Uniqueness

When choosing a threat actor name, uniqueness is a critical property. The threat actor name **MUST** be unique and not existing in different contexts. The name **MUST** not be a word from a dictionary which can be used in other contexts.

## Format

The name of the threat actor **SHALL** be composed of a single word. If there is multiple part like a decimal value such as a counter, the values **MUST** be separated with a dash. Single words are preferred to ease search of keywords by analysts in public sources.

## Encoding

The name of the threat actor **MUST** be expressed in ASCII 7-bit. Assigning a localized name to a threat actor **MAY** create a set of ambiguity about different localized version of the same threat actor.

## Don't confuse actor naming with malware naming

The name of the threat actor **MUST NOT** be assigned based on the tools, techniques or patterns used by the threat actor. A notorious example in the threat intelligence community is Turla which can name a threat actor but also a malware used by this group or other groups.

## Directory

# Examples

Some known examples are included below and serve as reference for good practices in naming threat actors. The below threat actor names can be considered good example:

- APT-1
- TA-505

The below threat actor names can be considered as example to not follow:

- GIF89a (Word also used for the GIF header)
- ShadyRAT (Confusion between the name and the tool)
- Group 3 (Common name used for other use-cases)
- ZooPark (Name is used to describe something else)

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
