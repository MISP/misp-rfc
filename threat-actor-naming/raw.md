%%%
Title = "Recommendations on Naming Threat Actors"
abbrev = "Recommendations on Naming Threat Actors"
category = "info"
docName = "draft-dulaunoy-threat-actor-naming"
ipr= "trust200902"
area = "Security"
date = 2026-01-07T00:00:00Z
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
[[author]]
initials="A. Iklody"
surname="Iklody"
fullname="Andras Iklody"
abbrev="CIRCL"
organization = "Computer Incident Response Center Luxembourg"
 [author.address]
 email = "andras.iklody@circl.lu"
 phone = "+352 247 88444"
%%%

.# Abstract

This document provides advice on the naming of threat actors (also known as malicious actors).
The objective is to provide practical advice for organizations such as security vendors or organizations attributing
incidents to a group of threat actors. It also discusses the implications of naming a threat actor for intelligence analysts
and threat intelligence platforms such as MISP [@?MISP-P].

{mainmatter}

# Introduction

In threat intelligence, threat actor names are often assigned without specific or consistent guidelines. This leads to several issues, such as:

- A proliferation of threat actor names, generating overlaps or multiple names for the same or very similar threat actors (e.g., some threat actors have more than 10 known synonyms).
- Ambiguity in the words used to name threat actors across different contexts (e.g., the use of common or generic words).
- A lack of clearly defined naming conventions to describe the same threat actor (e.g., is the threat actor name case-sensitive? Should words be separated by a dash or a space?).
- Confusion between the techniques or tools used by a threat actor and the threat actor’s name itself (e.g., naming a threat actor after a specific malware family).
- A lack of transparency regarding the source and rationale used by vendors when assigning threat actor names (e.g., was the name derived from a specific campaign, a codename for a country, or a particular set of targets?).
- The absence of an open, mirrored reference “registry” accessible to all, where new threat actor names can be registered and existing ones can be consulted. Such a registry could also include time-based information and serve as a practical reference tool.

This document proposes a set of recommendations and guidelines for naming threat actors. The objective is not to provide a silver bullet that solves all of the issues mentioned above, but rather to suggest approaches that reduce the burden on analysts when searching for and cross-correlating threat intelligence.

##  Conventions and Terminology

The key words "**MUST**", "**MUST NOT**", "**REQUIRED**", "**SHALL**", "**SHALL NOT**",
"**SHOULD**", "**SHOULD NOT**", "**RECOMMENDED**", "**MAY**", and "**OPTIONAL**" in this
document are to be interpreted as described in RFC 2119 [@!RFC2119].

# Recommendations

The recommendations below specify a minimal set of guidelines to be applied when assigning a new name to a threat actor.

## Reusing Threat Actor Names

Before creating a new threat actor name, you **SHOULD** review existing threat actor names in reference databases, such as the Threat Actor MISP Galaxy [@!MISP-G]. The proliferation of threat actor names is a significant challenge in day-to-day analyst work. If the threat actor you have identified matches an existing entry, you **SHOULD** reuse the existing threat actor name. If no matching threat actor name exists, you **SHALL** create a new one, following the best practices defined in this document.

Due to the volatile nature of threat correlation, threat actor profiles may be merged or split over time based on new information or further analysis. Analysts defining threat actors **SHOULD** use their best judgment to consolidate threat actor profiles whenever possible and retain previously defined names as aliases within the merged object, along with any previously established relationships.

## Threat Actor Types

The boundaries between threat actors, campaigns, and intrusion sets are frequently blurred, which can lead to the reclassification of the underlying concept. Such reclassification **SHOULD NOT** affect the existing naming convention. The previously assigned name **SHOULD** be retained in order to avoid losing correlations with historical data.

## Uniqueness

When choosing a threat actor name, uniqueness is a critical requirement. The threat actor name **MUST** be unique and not already in use in other contexts. The name **SHOULD** be selected with rarity in mind; common words are best avoided to facilitate searching and automated processing of information. If the use of common words is unavoidable, the threat actor name **SHOULD** consist of a combination of multiple words to increase uniqueness.

## Additional unique identifier

Threat actor definitions **SHOULD** include a unique identifier expressed as a UUID. When creating threat actor information, a prior check for an existing matching threat actor definition **SHOULD** be performed, and the UUID of the matching threat actor **SHOULD** be reused when a match is inferred. The inclusion of a UUID does not restrict the ability to retain vendor-specific threat actor naming conventions and **SHOULD** be treated as a separately expressed attribute of the threat actor.

## Format

The threat actor name **SHOULD** ideally consist of a single word. If the name is composed of multiple words or includes additional identifiers such as decimal values or counters, these elements **SHOULD** be combined into a single word without whitespace to facilitate searching. Single-word names are preferred to improve the efficiency of keyword searches by analysts in public sources.

## Encoding

The threat actor name **MUST** be expressed using 7-bit ASCII characters. Assigning localized or non-ASCII names to threat actors **MAY** introduce ambiguity due to the existence of multiple localized versions of the same name.

## Avoid Confusing Actor Names with Malware Names

The threat actor name **MUST NOT** be derived from the tools, techniques, or patterns used by the threat actor. A well-known example in the threat intelligence community is *Turla*, which can refer both to a threat actor and to malware used by that group or by other groups, leading to ambiguity.

## Directory

A reference registry of threat actors is **RECOMMENDED** to ensure consistency of naming across different parties, such as the Threat Actor MISP Galaxy [@!MISP-G].

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

The authors wish to thank all contributors who provided feedback through the now-defunct Twitter, other social networks such as Mastodon, Linkedin or via GitHub Issues.

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
