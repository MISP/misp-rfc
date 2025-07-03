%%%
Title = "Recommendations on Naming Threat Actors"
abbrev = "Recommendations on Naming Threat Actors"
category = "info"
docName = "draft-dulaunoy-threat-actor-naming"
ipr= "trust200902"
area = "Security"
date = 2024-12-21T00:00:00Z
submissiontype = "independent"

[seriesInfo]
name = "Internet-Draft"
value = "draft-00"
stream = "independent"
status = "informational"

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
 street = "122, rue Adolphe Fischer"
 city = "Luxembourg"
 code = "L-1521"
 country = "Luxembourg"
[[author]]
initials="P."
surname="Bourmeau"
fullname="Pauline Bourmeau"
abbrev="Cubessa"
organization = "Cubessa"
 [author.address]
 email = "Pauline@cubessa.io"
 phone = ""
%%%

.# Abstract

This document provides advice on the naming of threat actors (also known as malicious actors).
The objective is to provide practical advice for organizations such as security vendors or organizations attributing
incidents to a group of threat actors. It also discusses the implications of naming a threat actor for intelligence analysts
and threat intelligence platforms such as MISP [@?MISP-P].

{mainmatter}

# Introduction

In threat intelligence, a name can be assigned to a threat actor without specific guidelines. This leads to issues such
as:

- A proliferation of threat actor names generating overlaps or different names for similar threat actors (e.g., some threat actors have more than 10 synonyms).
- Ambiguity in the words used to name the threat actor in different contexts (e.g., using common words).
- Lack of a clearly defined text format to describe the same threat actor (e.g., Is the threat actor name case-sensitive? Is there a dash or a space between the words?).
- Confusion between techniques/tools used by a threat actor versus its name (e.g., naming a threat actor after a specific malware used).
- Lack of source and reasoning from vendors when they describe their threat actor names (e.g., did they name the threat actor after a specific set of campaigns or a specific set of targets?).
- Lack of time-based information about the threat actor name, such as date of naming or a UUID.
- Lack of an open, mirrored "registry" of reference, accessible to all, where a new threat actor name can be registered, or where all already named threat actors can be accessed. The "registry" can contain the time-based information mentioned above; it is a tool.

This document proposes a set of guidelines for naming threat actors. The goal is to reduce the issues mentioned above.


##  Conventions and Terminology

The key words "**MUST**", "**MUST NOT**", "**REQUIRED**", "**SHALL**", "**SHALL NOT**",
"**SHOULD**", "**SHOULD NOT**", "**RECOMMENDED**", "**MAY**", and "**OPTIONAL**" in this
document are to be interpreted as described in RFC 2119 [@!RFC2119].

# Recommendations

The recommendations listed below provide a minimal set of guidelines when assigning a new name to a threat actor.

## Reusing Threat Actor Names

Before creating a new threat actor name, you **MUST** consider a review of existing threat actor names from databases such as the threat actor MISP galaxy [@!MISP-G]. Proliferation of threat actor names is a significant challenge for day-to-day analyst work. If your defined threat actor matches an existing threat actor, you **MUST** reuse an existing threat actor name. If there is no matching threat actor name, you **SHALL** create a new threat actor name, following the best practices defined in this document.

## Uniqueness

When choosing a threat actor name, uniqueness is a critical property. The threat actor name **MUST** be unique and not already in use in different contexts. The name **MUST NOT** be a word from a dictionary, which could be used in other contexts.

## Format

The name of the threat actor **SHALL** be composed of a single word. If there are multiple parts, such as a decimal value or a counter, the values **MUST** be separated with a dash. Single words are preferred to ease keyword searches by analysts in public sources.

## Encoding

The name of the threat actor **MUST** be expressed in 7-bit ASCII. Assigning a localized name to a threat actor **MAY** create ambiguity due to different localized versions of the same threat actor.

## Avoid Confusing Actor Names with Malware Names

The name of the threat actor **MUST NOT** be based on the tools, techniques, or patterns used by the threat actor. A notorious example in the threat intelligence community is Turla, which can refer to a threat actor but also to a malware used by this group or other groups.

## Directory

A reference registry of threat actors is **RECOMMENDED** to ensure consistency of names across different parties such as the threat actor MISP galaxy [@!MISP-G].

# Examples

Some known examples are included below and serve as references for good and bad practices in naming threat actors. The following threat actor names are considered good examples:

- APT-1
- TA-505

The following threat actor names are considered examples to avoid:

- GIF89a (Word also used for the GIF header)
- ShadyRAT (Confusion between the name and the tool)
- Group 3 (Common name used for other use-cases)
- ZooPark (Name is used to describe something else)

# Security Considerations

Naming a threat actor could include sensitive references to a case or an incident. Before releasing a name, the creator **MUST** review the name to ensure no sensitive information is included in the threat actor name.

# Acknowledgements

The authors wish to thank all contributors who provided feedback through the now-defunct Twitter and other new social networks.

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
