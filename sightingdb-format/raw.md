%%%
Title = "SightingDB format"
abbrev = "SightingDB format"
category = "info"
docName = "draft-tricaud-sightingdb-format"
ipr= "trust200902"
area = "Security"

date = 2019-03-03T00:00:00Z

[[author]]
initials="S."
surname="Tricaud"
fullname="Sebastien Tricaud"
abbrev="Devo Inc."
organization = "Devo Inc."
 [author.address]
 email = "sebastien.tricaud@devo.com"
 phone = "+1 866-221-2254"
 [author.address.postal]
 street = "150 Cambridgepark Drive"
 city = "Cambridge, MA"
 code = "02140"
 country = "USA"
%%%

.# Abstract

This document describes the format used by SightingDB to give automated context to a given Attribute
by counting occurences and tracking times of observability.
SightingDB was designed to provide to MISP a Scalable and Fast way to store and retrive Attributes.

{mainmatter}

# Introduction

Adding context to any Attribute is the key that makes it useful. While there exist numerous ways of doing it,
SightingDB does it by just counting.
Whenever somebody retrieves an Attribute, this counting is provided, allowing anyone to understand wether something
was observed few or many times.

##  Conventions and Terminology

The key words "**MUST**", "**MUST NOT**", "**REQUIRED**", "**SHALL**", "**SHALL NOT**",
"**SHOULD**", "**SHOULD NOT**", "**RECOMMENDED**", "**MAY**", and "**OPTIONAL**" in this
document are to be interpreted as described in RFC 2119 [@!RFC2119].

# Format

## Overview

The SightingDB format is in the JSON [@!RFC8259] format. In SightingDB, a Sighting Object is composed of a single JSON object.

# Acknowledgements

The author wish to thank all the MISP community who are supporting the creation
of open standards in threat intelligence sharing. As well as amazing feedback gathered
during the MISP Summit 2019 in Luxembourg, in particular with Alexandre Dulaunoy and
Andras Iklody.

{backmatter}
