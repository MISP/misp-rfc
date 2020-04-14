%%%
Title = "SightingDB query format"
abbrev = "SightingDB query format"
category = "info"
docName = "draft-tricaud-sightingdb-format"
ipr= "trust200902"
area = "Security"

date = 2020-13-04T00:00:00Z

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
by counting occurrences and tracking times of observability.
SightingDB was designed to provide to MISP a Scalable and Fast way to store and retrieve Attributes.

{mainmatter}

# Introduction

Adding context to any Attribute is the key that makes it useful. While there exist numerous ways of doing it,
SightingDB does it by just counting.
Whenever somebody retrieves an Attribute, this counting is provided, allowing anyone to understand whenever something
was observed few or many times.

##  Conventions and Terminology

The key words "**MUST**", "**MUST NOT**", "**REQUIRED**", "**SHALL**", "**SHALL NOT**",
"**SHOULD**", "**SHOULD NOT**", "**RECOMMENDED**", "**MAY**", and "**OPTIONAL**" in this
document are to be interpreted as described in RFC 2119 [@!RFC2119].

# Format

## Overview

The SightingDB format is in JSON [@!RFC8259] format and used to query a SightingDB compatible connector. In SightingDB, a Sighting Object is composed of a single JSON object. This object contains the following fields: value, first_seen, last_seen, count, tags, ttl and consensus.

### Attribute Storage

The fields described previously describe an Attribute and all the required characteristics. However they are stored in a Namespace. A Namespace is similar to a path in a file-system where the same file can be stored in multiple places.

### Namespace

A Namespace with multiple levels **MUST** be separated with the slash '/' character. There is no specification on how they are structured, since it depends on the use cases.

A Namespace starting with the underscore '_' character means it is private and internal to SightingDB. There are all reserved for the engine and **MUST** NOT be used.

Reserved namespaces are:

_expired/<namespace>: Which contains all the attributes that expired, preserving the origin namespace

_shadow/<namespace>: When a value is searched and does not exists, it is stored there

_stats: Statistics

_config: Configuration

_all: All the Attributes in one place, used to retrieve the 'consensus' property.

The Attribute Key MUST always be the last part of the Namespace.

#### Sample Namespaces

/Organization1/service/ipv4: Store values for ipv4 keys in /Organization1/service

/everything/domain: Store domains in /everything

### Attribute fields

#### value

The attribute value, used to store and retrieve information about an attribute. Note that value is not returned back in the JSON object, since it is queried, it is known. The Value is described in a section below, as it is very specific and can be either "as is", a hash, encoded in base64 or any other convenient mechanism.

The value implementation **MUST** offer at least: 1) Raw value 2) Base64 URL Encoded 3) SHA256 Hash

#### first_seen

Time in UTC of the first time this value was captured

#### last_seen

Time in UTC of the last time this value was captured

#### count

How many time this value was written

#### tags

Tags follow how they are defined in MISP using the MISP Taxonomy. Each Tag is separated with the ';' character.

#### ttl

Time To Live, represents the expiration in seconds since the time the Attribute was created. Once it has expired, it moves in the private Namespace _expired.

When an Attribute has this field set to 0, it means it is not set to expired. This is the default behavior.

When an Attribute has this field set to a number greater than 0, the expiration status is computed only at retrieval time.

#### consensus

When a given Attribute Value is stored in different namespaces, the consensus field keeps track of them so it returns in how many different places this attributes exists. This is a simple counter.

## SightingDB Format - One Attribute

~~~~
{
  "value":"127.0.0.1",
  "first_seen":1530394819,
  "last_seen":1572933618,
  "count":578391,
  "tags":"",
  "ttl":0,
  "consensus": 17
}
~~~~

## Value

The value submitted can be in multiple format according to the use-case. Any implementation **MUST** offer three alternatives:

1) Raw value: where nothing is encoded and the value is stored AS IS, such as show in the example above with the One Attribute in JSON.

2) SHA256: which prevents from seeing content (see Security Considerations), has a fixed size and is convenient for most requirements

3) Base64 URL: Where the specification of Base64 is followed, except the characters conflicting with an URL argument are replaced

The value is configured as part of the Namespace. The private "_config" Namespace prefix stores this value storage mechanism.

### Configuring the value format for a Namespace

If one has the Namespace "/Organization1/BU1/ip" and want to store those IP addresses in SHA256, it will be configured like this:
The Namespace is kept but prefixed by "_config" and has a json object about value format set.
"/_config/Organization1/BU1/ip"

~~~~
{
  "value_format":"SHA256"
}
~~~~

Where "value_format" is either: "SHA256", "RAW" or "BASE64URL".

## Bulk

When data must be sent and received in large amounts, it is preferable to embed in JSON all the objects at once. As such, for reading and writing, the format is the following:

~~~~
{
  "items": [
    { "<namespace>": "<value>" },
    { "<namespace>": "<value>", "timestamp": <epoch> }
  ]
}
~~~~

Where:

namespace: is the wanted namespace where to store the value

value: the value one want to track

timestamp: **OPTIONAL** epoch timestamp to set the value at.

The timestamp is how one can use SightingDB and use old datasets where the first seen and last seen is not relative to "right now". 

### Request

A Proper request with two items is made like this:

~~~~
{
  "items": [
    { "/your/namespace": "127.0.0.1" },
    { "/your/other/namespace": "110812f67fa1e1f0117f6f3d70241c1a42a7b07711a93c2477cc516d9042f9db", "timestamp": 1586825229 }
  ]
}
~~~~

Which will either store or retrieve the wanted data.

### Response 

The response when retrieving sightings also has the list of items, in order, one per line of the results:
~~~~
{
  "items": [
    {"value": "Octave_Hergebel", "first_seen":1530337182, "last_seen":1573110615, "count":93021, "tags":"", "ttl":0, "consensus": 1},
    {"value": "127.0.0.1", "first_seen":1562930418, "last_seen":1573110404, "count":1020492, "tags":"", "ttl":8912, "consensus": 3}
  ]
}
~~~~

# Security Considerations

While this document solely focuses on the format, the reference implementation is SightingDB. The authentication, the data access is not handled by SightingDB.
It is possible a value can leak if the access is too permissive.

Even a Hashed value can be discovered, as re-hashing known values would match.

# Acknowledgements

The author wish to thank all the MISP community who are supporting the creation
of open standards in threat intelligence sharing. As well as amazing feedback gathered
during the MISP Summit 2019 in Luxembourg, in particular with Alexandre Dulaunoy and
Andras Iklody.

{backmatter}
