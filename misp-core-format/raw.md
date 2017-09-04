% Title = "MISP core format"
% abbrev = "MISP core format"
% category = "info"
% docName = "draft-dulaunoy-misp-core-format"
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
%   code = "L-1160"
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
%   street = "16, bd d'Avranches"
%   city = "Luxembourg"
%   code = "L-1160"
%   country = "Luxembourg"

.# Abstract

This document describes the MISP core format used to exchange indicators and threat information between
MISP (Malware Information and threat Sharing Platform) instances.
The JSON format includes the overall structure along with the semantic associated for each
respective key. The format is described to support other implementations which reuse the
format and ensuring an interoperability with existing MISP [@?MISP-P] software and other Threat Intelligence Platforms.

{mainmatter}

# Introduction

Sharing threat information became a fundamental requirements in the Internet, security and intelligence community at large. Threat
information can include indicators of compromise, malicious file indicators, financial fraud indicators
or even detailed information about a threat actor. MISP [@?MISP-P] started as an open source project in late 2011 and
the MISP format started to be widely used as an exchange format within the community in the past years. The aim of this document
is to describe the specification and the MISP core format.

##  Conventions and Terminology

The key words "**MUST**", "**MUST NOT**", "**REQUIRED**", "**SHALL**", "**SHALL NOT**",
"**SHOULD**", "**SHOULD NOT**", "**RECOMMENDED**", "**MAY**", and "**OPTIONAL**" in this
document are to be interpreted as described in RFC 2119 [@!RFC2119].

# Format

## Overview

The MISP core format is in the JSON [@!RFC4627] format. In MISP, an event is composed of a single JSON object.

A capitalized key (like Event, Org) represent a data model and a non-capitalized key is just an attribute. This nomenclature
can support an implementation to represent the MISP format in another data structure.

## Event

An event is a simple meta structure scheme where attributes and meta-data are embedded to compose a coherent set
of indicators. An event can be composed from an incident, a security analysis report or a specific threat actor
analysis. The meaning of an event only depends of the information embedded in the event.

### Event Attributes

#### uuid

uuid represents the Universally Unique IDentifier (UUID) [@!RFC4122] of the event. The uuid **MUST** be preserved
for any updates or transfer of the same event. UUID version 4 is **RECOMMENDED** when assigning it to a new event.

uuid is represented as a JSON string. uuid **MUST** be present.

#### id

id represents the human-readable identifier associated to the event for a specific MISP instance.

id is represented as a JSON string. id **SHALL** be present.

#### published

published represents the event publication state. If the event was published, the published value **MUST** be true.
In any other publication state, the published value **MUST** be false.

published is represented as a JSON boolean. published **MUST** be present.

#### info

info represents the information field of the event. info is a free-text value to provide a human-readable summary
of the event. info **SHOULD** NOT be bigger than 256 characters and **SHOULD** NOT include new-lines.

info is represented as a JSON string. info **MUST** be present.

#### threat_level_id

threat_level_id represents the threat level.

4:
:   Undefined

3:
:   Low

2:
:   Medium

1:
:   High

If a higher granularity is required, a MISP taxonomy applied as a Tag **SHOULD** be preferred.

threat_level_id is represented as a JSON string. threat_level_id **SHALL** be present.

#### analysis

analysis represents the analysis level.

0:
:   Initial

1:
:   Ongoing

2:
:   Complete

If a higher granularity is required, a MISP taxonomy applied as a Tag **SHOULD** be preferred.

analysis is represented as a JSON string. analysis **SHALL** be present.

#### date

date represents a reference date to the event in ISO 8601 format (date only: YYYY-MM-DD). This date corresponds to the date the event occured, which may be in the past.

date is represented as a JSON string. date **MUST** be present.

#### timestamp

timestamp represents a reference time when the event, or one of the attributes within the event was created, or last updated/edited on the instance. timestamp is expressed in seconds (decimal) since 1st of January 1970 (Unix timestamp). The time zone **MUST** be UTC.

timestamp is represented as a JSON string. timestamp **MUST** be present.

#### publish_timestamp

publish_timestamp represents a reference time when the event was published on the instance. published_timestamp is expressed in seconds (decimal) since 1st of January 1970 (Unix timestamp). At each publication of an event, publish_timestamp **MUST** be updated. The time zone **MUST** be UTC.

publish_timestamp is represented as a JSON string. publish_timestamp **MUST** be present.

#### org_id

org_id represents a human-readable identifier referencing an Org object of the organization which generated the event.

The org_id **MUST** be updated when the event is generated by a new instance.

org_id is represented as a JSON string. org_id **MUST** be present.

#### orgc_id

orgc_id represents a human-readable identifier referencing an Orgc object of the organization which created the event.

The orgc_id and Orc object **MUST** be preserved for any updates or transfer of the same event.

orgc_id is represented as a JSON string. orgc_id **MUST** be present.

#### attribute_count

attribute_count represents the number of attributes in the event. attribute_count is expressed in decimal.

attribute_count is represented as a JSON string. attribute_count **SHALL** be present.

#### distribution

distribution represents the basic distribution rules of the event. The system must adhere to the distribution setting for access control and for dissemination of the event.

distribution is represented by a JSON string. distribution **MUST** be present and be one of the following options:

0
:   Your Organisation Only

1
:   This Community Only

2
:   Connected Communities

3
:   All Communities

4
:   Sharing Group

#### sharing_group_id

sharing\_group\_id represents a human-readable identifier referencing a Sharing Group object that defines the distribution of the event, if distribution level "4" is set.

sharing\_group\_id is represented by a JSON string and **SHOULD** be present. If a distribution level other than "4" is chosen the sharing\_group\_id **MUST** be set to "0".


## Objects

### Org

An Org object is composed of an uuid, name and id.

The uuid represents the Universally Unique IDentifier (UUID) [@!RFC4122] of the organization.
The organization UUID is globally assigned to an organization and **SHALL** be kept overtime.

The name is a readable description of the organization and **SHOULD** be present.
The id is a human-readable identifier generated by the instance and used as reference in the event.

uuid, name and id are represented as a JSON string. uuid, name and id **MUST** be present.

#### Sample Org Object

~~~~
"Org": {
        "id": "2",
        "name": "CIRCL",
        "uuid": "55f6ea5e-2c60-40e5-964f-47a8950d210f"
       }
~~~~

### Orgc

An Orgc object is composed of an uuid, name and id.

The uuid **MUST** be preserved for any updates or transfer of the same event. UUID version 4 is **RECOMMENDED** when assigning it to a new event.
The organization UUID is globally assigned to an organization and **SHALL** be kept overtime.

The name is a readable description of the organization and **SHOULD** be present.
The id is a human-readable identifier generated by the instance and used as reference in the event.

uuid, name and id are represented as a JSON string. uuid, name and id **MUST** be present.

## Attribute

Attributes are used to describe the indicators and contextual data of an event. The main information contained in an attribute is made up of a category-type-value triplet,
where the category and type give meaning and context to the value. Through the various category-type combinations a wide range of information can be conveyed.

A MISP document **MUST** at least includes category-type-value triplet described in section "Attribute Attributes".

### Sample Attribute Object

~~~~
"Attribute": {
              "id": "346056",
              "type": "comment",
              "category": "Other",
              "to_ids": false,
              "uuid": "57f4f6d9-cd20-458b-84fd-109ec0a83869",
              "event_id": "3357",
              "distribution": "5",
              "timestamp": "1475679332",
              "comment": "",
              "sharing_group_id": "0",
              "deleted": false,
              "value": "Hello world",
              "SharingGroup": [],
              "ShadowAttribute": [],
              "RelatedAttribute": []
             }
~~~~

### Attribute Attributes

#### uuid

uuid represents the Universally Unique IDentifier (UUID) [@!RFC4122] of the event. The uuid **MUST** be preserved
for any updates or transfer of the same event. UUID version 4 is **RECOMMENDED** when assigning it to a new event.

uuid is represented as a JSON string. uuid **MUST** be present.

#### id

id represents the human-readable identifier associated to the event for a specific MISP instance.

id is represented as a JSON string. id **SHALL** be present.

#### type

type represents the means through which an attribute tries to describe the intent of the attribute creator, using a list of pre-defined attribute types.

type is represented as a JSON string. type **MUST** be present and it **MUST** be a valid selection for the chosen category. The list of valid category-type combinations is as follows:

**Internal reference**
:   text, link, comment, other, hex

**Targeting data**
:   target-user, target-email, target-machine, target-org, target-location, target-external, comment

**Antivirus detection**
:   link, comment, text, hex, attachment, other

**Payload delivery**
:   md5, sha1, sha224, sha256, sha384, sha512, sha512/224, sha512/256, ssdeep, imphash, impfuzzy, authentihash, pehash, tlsh, filename, filename|md5, filename|sha1, filename|sha224, filename|sha256, filename|sha384, filename|sha512, filename|sha512/224, filename|sha512/256, filename|authentihash, filename|ssdeep, filename|tlsh, filename|imphash, filename|impfuzzy, filename|pehash, ip-src, ip-dst, hostname, domain, email-src, email-dst, email-subject, email-attachment, url, user-agent, AS, pattern-in-file, pattern-in-traffic, yara, attachment, malware-sample, link, malware-type, comment, text, vulnerability, x509-fingerprint-sha1, other, ip-dst|port, ip-src|port, hostname|port, email-dst-display-name, email-src-display-name, email-header, email-reply-to, email-x-mailer, email-mime-boundary, email-thread-index, email-message-id, mobile-application-id

**Artifacts dropped**
:   md5, sha1, sha224, sha256, sha384, sha512, sha512/224, sha512/256, ssdeep, imphash, impfuzzy, authentihash, filename, filename|md5, filename|sha1, filename|sha224, filename|sha256, filename|sha384, filename|sha512, filename|sha512/224, filename|sha512/256, filename|authentihash, filename|ssdeep, filename|tlsh, filename|imphash, filename|impfuzzy, filename|pehash, regkey, regkey|value, pattern-in-file, pattern-in-memory, pdb, yara, sigma, attachment, malware-sample, named pipe, mutex, windows-scheduled-task, windows-service-name, windows-service-displayname, comment, text, hex, x509-fingerprint-sha1, other

**Payload installation**
:   md5, sha1, sha224, sha256, sha384, sha512, sha512/224, sha512/256, ssdeep, imphash, authentihash, pehash, tlsh, filename, filename|md5, filename|sha1, filename|sha224, filename|sha256, filename|sha384, filename|sha512, filename|sha512/224, filename|sha512/256, filename|authentihash, filename|ssdeep, filename|tlsh, filename|imphash, filename|pehash, pattern-in-file, pattern-in-traffic, pattern-in-memory, yara, vulnerability, attachment, malware-sample, malware-type, comment, text, hex, x509-fingerprint-sha1, mobile-application-id, other

**Persistence mechanism**
:   filename, regkey, regkey|value, comment, text, other, text

**Network activity**
:   ip-src, ip-dst, hostname, domain, domain|ip, email-dst, url, uri, user-agent, http-method, AS, snort, pattern-in-file, pattern-in-traffic, attachment, comment, text, x509-fingerprint-sha1, other, hex, cookie

**Payload type**
:   comment, text, other

**Attribution**
:   threat-actor, campaign-name, campaign-id, whois-registrant-phone, whois-registrant-email, whois-registrant-name, whois-registrar, whois-creation-date, comment, text, x509-fingerprint-sha1, other

**External analysis**
:   md5, sha1, sha256, filename, filename|md5, filename|sha1, filename|sha256, ip-src, ip-dst, hostname, domain, domain|ip, url, user-agent, regkey, regkey|value, AS, snort, pattern-in-file, pattern-in-traffic, pattern-in-memory, vulnerability, attachment, malware-sample, link, comment, text, x509-fingerprint-sha1, github-repository, other

**Financial fraud**
:   btc, iban, bic, bank-account-nr, aba-rtn, bin, cc-number, prtn, phone-number, comment, text, other, hex

**Support tool**
:   attachment, link, comment, text, other, hex

**Social network**
:   github-username, github-repository, github-organisation, jabber-id, twitter-id, email-src, email-dst, comment, text, other

**Person**
:   first-name, middle-name, last-name, date-of-birth, place-of-birth, gender, passport-number, passport-country, passport-expiration, redress-number, nationality, visa-number, issue-date-of-the-visa, primary-residence, country-of-residence, special-service-request, frequent-flyer-number, travel-details, payment-details, place-port-of-original-embarkation, place-port-of-clearance, place-port-of-onward-foreign-destination, passenger-name-record-locator-number, comment, text, other, phone-number

**Other**
:   comment, text, other, size-in-bytes, counter, datetime, cpe, port, float, hex, phone-number

Attributes are based on the usage within their different communities. Attributes can be extended on a regular basis and this reference document is updated accordingly.

#### category

category represents the intent of what the attribute is describing as selected by the attribute creator, using a list of pre-defined attribute categories.

category is represented as a JSON string. category **MUST** be present and it **MUST** be a valid selection for the chosen type. The list of valid category-type combinations is mentioned above.

#### to\_ids

to\_ids represents whether the attribute is meant to be actionable. Actionable defined attributes that can be used in automated processes as a pattern for detection in Local or Network Intrusion Detection System, log analysis tools or even filtering mechanisms.

to\_ids is represented as a JSON boolean. to\_ids **MUST** be present.

#### event\_id

event\_id represents a human-readable identifier referencing the Event object that the attribute belongs to.

The event\_id **SHOULD** be updated when the event is imported to reflect the newly created event's id on the instance.

event\_id is represented as a JSON string. event\_id **MUST** be present.

#### distribution

distribution represents the basic distribution rules of the attribute. The system must adhere to the distribution setting for access control and for dissemination of the attribute.

distribution is represented by a JSON string. distribution **MUST** be present and be one of the following options:

0
:   Your Organisation Only

1
:   This Community Only

2
:   Connected Communities

3
:   All Communities

4
:   Sharing Group

5
:   Inherit Event

#### timestamp

timestamp represents a reference time when the attribute was created or last modified. timestamp is expressed in seconds (decimal) since 1st of January 1970 (Unix timestamp). The time zone **MUST** be UTC.

timestamp is represented as a JSON string. timestamp **MUST** be present.

#### comment

comment is a contextual comment field.

comment is represented by a JSON string. comment **MAY** be present.

#### sharing_group_id

sharing\_group\_id represents a human-readable identifier referencing a Sharing Group object that defines the distribution of the attribute, if distribution level "4" is set.

sharing\_group\_id is represented by a JSON string and **SHOULD** be present. If a distribution level other than "4" is chosen the sharing\_group\_id **MUST** be set to "0".

#### deleted

deleted represents a setting that allows attributes to be revoked. Revoked attributes are not actionable and exist merely to inform other instances of a revocation.

deleted is represented by a JSON boolean. deleted **MUST** be present.

#### data

data contains the base64 encoded contents of an attachment or a malware sample. For malware samples,
the sample **MUST** be encrypted using a password protected zip archive, with the password being "infected".

data is represented by a JSON string in base64 encoding. data **MUST** be set for attributes of type malware-sample and attachment.

#### RelatedAttribute

RelatedAttribute is an array of attributes correlating with the current attribute. Each element in the array represents an JSON object which contains an Attribute dictionnary with the external attributes who correlate. Each Attribute **MUST** include the id, org_id, info and a value. Only the correlations found on the local instance are shown in RelatedAttribute.

RelatedAttribute **MAY** be present.

#### ShadowAttribute

ShadowAttribute is an array of shadow attributes that serve as proposals by third parties to alter the containing attribute. The structure of a ShadowAttribute is similar to that of an Attribute,
which can be accepted or discarded by the event creator. If accepted, the original attribute containing the shadow attribute is removed and the shadow attribute is converted into an attribute.

Each shadow attribute that references an attribute **MUST** contain the containing attribute's ID in the old_id field and the event's ID in the event_id field.

#### value

value represents the payload of an attribute. The format of the value is dependent on the type of the attribute.

value is represented by a JSON string. value **MUST** be present.

## ShadowAttribute

ShadowAttributes are 3rd party created attributes that either propose to add new information to an event or modify existing information. They are not meant to be actionable until the event creator accepts them - at which point they will be converted into attributes or modify an existing attribute.

They are similar in structure to Attributes but additionally carry a reference to the creator of the ShadowAttribute as well as a revocation flag.

### Sample Attribute Object

~~~~
"ShadowAttribute":  {
                       "id": "8",
                       "type": "ip-src",
                       "category": "Network activity",
                       "to_ids": false,
                       "uuid": "57d475f1-da78-4569-89de-1458c0a83869",
                       "event_uuid": "57d475e6-41c4-41ca-b450-145ec0a83869",
                       "event_id": "9",
                       "old_id": "319",
                       "comment": "",
                       "org_id": "1",
                       "proposal_to_delete": false,
                       "value": "5.5.5.5",
                       "deleted": false,
                       "Org": {
                           "id": "1",
                           "name": "MISP",
                           "uuid": "568cce5a-0c80-412b-8fdf-1ffac0a83869"
                       }
                   }
~~~~

### ShadowAttribute Attributes

#### uuid

uuid represents the Universally Unique IDentifier (UUID) [@!RFC4122] of the event. The uuid **MUST** be preserved
for any updates or transfer of the same event. UUID version 4 is **RECOMMENDED** when assigning it to a new event.

uuid is represented as a JSON string. uuid **MUST** be present.

#### id

id represents the human-readable identifier associated to the event for a specific MISP instance.

id is represented as a JSON string. id **SHALL** be present.

#### type

type represents the means through which an attribute tries to describe the intent of the attribute creator, using a list of pre-defined attribute types.

type is represented as a JSON string. type **MUST** be present and it **MUST** be a valid selection for the chosen category. The list of valid category-type combinations is as follows:

**Internal reference**
:   text, link, comment, other, hex

**Targeting data**
:   target-user, target-email, target-machine, target-org, target-location, target-external, comment

**Antivirus detection**
:   link, comment, text, hex, attachment, other

**Payload delivery**
:   md5, sha1, sha224, sha256, sha384, sha512, sha512/224, sha512/256, ssdeep, imphash, impfuzzy, authentihash, pehash, tlsh, filename, filename|md5, filename|sha1, filename|sha224, filename|sha256, filename|sha384, filename|sha512, filename|sha512/224, filename|sha512/256, filename|authentihash, filename|ssdeep, filename|tlsh, filename|imphash, filename|impfuzzy, filename|pehash, ip-src, ip-dst, hostname, domain, email-src, email-dst, email-subject, email-attachment, url, user-agent, AS, pattern-in-file, pattern-in-traffic, yara, attachment, malware-sample, link, malware-type, comment, text, vulnerability, x509-fingerprint-sha1, other, ip-dst|port, ip-src|port, hostname|port, email-dst-display-name, email-src-display-name, email-header, email-reply-to, email-x-mailer, email-mime-boundary, email-thread-index, email-message-id, mobile-application-id

**Artifacts dropped**
:   md5, sha1, sha224, sha256, sha384, sha512, sha512/224, sha512/256, ssdeep, imphash, impfuzzy, authentihash, filename, filename|md5, filename|sha1, filename|sha224, filename|sha256, filename|sha384, filename|sha512, filename|sha512/224, filename|sha512/256, filename|authentihash, filename|ssdeep, filename|tlsh, filename|imphash, filename|impfuzzy, filename|pehash, regkey, regkey|value, pattern-in-file, pattern-in-memory, pdb, yara, sigma, attachment, malware-sample, named pipe, mutex, windows-scheduled-task, windows-service-name, windows-service-displayname, comment, text, hex, x509-fingerprint-sha1, other

**Payload installation**
:   md5, sha1, sha224, sha256, sha384, sha512, sha512/224, sha512/256, ssdeep, imphash, authentihash, pehash, tlsh, filename, filename|md5, filename|sha1, filename|sha224, filename|sha256, filename|sha384, filename|sha512, filename|sha512/224, filename|sha512/256, filename|authentihash, filename|ssdeep, filename|tlsh, filename|imphash, filename|pehash, pattern-in-file, pattern-in-traffic, pattern-in-memory, yara, vulnerability, attachment, malware-sample, malware-type, comment, text, hex, x509-fingerprint-sha1, mobile-application-id, other

**Persistence mechanism**
:   filename, regkey, regkey|value, comment, text, other, text

**Network activity**
:   ip-src, ip-dst, hostname, domain, domain|ip, email-dst, url, uri, user-agent, http-method, AS, snort, pattern-in-file, pattern-in-traffic, attachment, comment, text, x509-fingerprint-sha1, other, hex, cookie

**Payload type**
:   comment, text, other

**Attribution**
:   threat-actor, campaign-name, campaign-id, whois-registrant-phone, whois-registrant-email, whois-registrant-name, whois-registrar, whois-creation-date, comment, text, x509-fingerprint-sha1, other

**External analysis**
:   md5, sha1, sha256, filename, filename|md5, filename|sha1, filename|sha256, ip-src, ip-dst, hostname, domain, domain|ip, url, user-agent, regkey, regkey|value, AS, snort, pattern-in-file, pattern-in-traffic, pattern-in-memory, vulnerability, attachment, malware-sample, link, comment, text, x509-fingerprint-sha1, github-repository, other

**Financial fraud**
:   btc, iban, bic, bank-account-nr, aba-rtn, bin, cc-number, prtn, phone-number, comment, text, other, hex

**Support tool**
:   attachment, link, comment, text, other, hex

**Social network**
:   github-username, github-repository, github-organisation, jabber-id, twitter-id, email-src, email-dst, comment, text, other

**Person**
:   first-name, middle-name, last-name, date-of-birth, place-of-birth, gender, passport-number, passport-country, passport-expiration, redress-number, nationality, visa-number, issue-date-of-the-visa, primary-residence, country-of-residence, special-service-request, frequent-flyer-number, travel-details, payment-details, place-port-of-original-embarkation, place-port-of-clearance, place-port-of-onward-foreign-destination, passenger-name-record-locator-number, comment, text, other, phone-number

**Other**
:   comment, text, other, size-in-bytes, counter, datetime, cpe, port, float, hex, phone-number

Attributes are based on the usage within their different communities. Attributes can be extended on a regular basis and this reference document is updated accordingly.

#### category

category represents the intent of what the attribute is describing as selected by the attribute creator, using a list of pre-defined attribute categories.

category is represented as a JSON string. category **MUST** be present and it **MUST** be a valid selection for the chosen type. The list of valid category-type combinations is mentioned above.

#### to\_ids

to\_ids represents whether the Attribute to be created if the ShadowAttribute is accepted is meant to be actionable. Actionable defined attributes that can be used in automated processes as a pattern for detection in Local or Network Intrusion Detection System, log analysis tools or even filtering mechanisms.

to\_ids is represented as a JSON boolean. to\_ids **MUST** be present.

#### event\_id

event\_id represents a human-readable identifier referencing the Event object that the ShadowAttribute belongs to.

The event\_id **SHOULD** be updated when the event is imported to reflect the newly created event's id on the instance.

event\_id is represented as a JSON string. event\_id **MUST** be present.

#### old\_id

old\_id represents a human-readable identifier referencing the Attribute object that the ShadowAttribute belongs to. A ShadowAttribute can this way target an existing Attribute, implying that it is a proposal to modify an existing Attribute, or alternatively it can be a proposal to create a new Attribute for the containing Event.

The old\_id **SHOULD** be updated when the event is imported to reflect the newly created Attribute's id on the instance. Alternatively, if the ShadowAttribute proposes the creation of a new Attribute, it should be set to 0.

old\_id is represented as a JSON string. old\_id **MUST** be present.

#### timestamp

timestamp represents a reference time when the attribute was created or last modified. timestamp is expressed in seconds (decimal) since 1st of January 1970 (Unix timestamp). The time zone **MUST** be UTC.

timestamp is represented as a JSON string. timestamp **MUST** be present.

#### comment

comment is a contextual comment field.

comment is represented by a JSON string. comment **MAY** be present.

#### org\_id

org\_id represents a human-readable identifier referencing the proposal creator's Organisation object.

Whilst attributes can only be created by the event creator organisation, shadow attributes can be created by third parties. org\_id tracks the creator organisation.

org\_id is represented by a JSON string and **MUST** be present.

#### proposal\_to\_delete

proposal\_to\_delete is a boolean flag that sets whether the shadow attribute proposes to alter an attribute, or whether it proposes to remove it completely.

Accepting a shadow attribute with this flag set will remove the target attribute.

proposal\_to\_delete is a JSON boolean and it **MUST** be present. If proposal\_to\_delete is set to true, old\_id **MUST NOT** be 0.

#### deleted

deleted represents a setting that allows shadow attributes to be revoked. Revoked shadow attributes only serve to inform other instances that the shadow attribute is no longer active.

deleted is represented by a JSON boolean. deleted **SHOULD** be present.

#### data

data contains the base64 encoded contents of an attachment or a malware sample. For malware samples,
the sample **MUST** be encrypted using a password protected zip archive, with the password being "infected".

data is represented by a JSON string in base64 encoding. data **MUST** be set for shadow attributes of type malware-sample and attachment.

### Org

An Org object is composed of an uuid, name and id.

The uuid represents the Universally Unique IDentifier (UUID) [@!RFC4122] of the organization.
The organization UUID is globally assigned to an organization and **SHALL** be kept overtime.

The name is a readable description of the organization and **SHOULD** be present.
The id is a human-readable identifier generated by the instance and used as reference in the event.

uuid, name and id are represented as a JSON string. uuid, name and id **MUST** be present.

#### Sample Org Object

~~~~
"Org": {
        "id": "2",
        "name": "CIRCL",
        "uuid": "55f6ea5e-2c60-40e5-964f-47a8950d210f"
       }
~~~~

#### value

value represents the payload of an attribute. The format of the value is dependent on the type of the attribute.

value is represented by a JSON string. value **MUST** be present.


## Tag

A tag is a simple method to classify an event with a simple string. The tag name can be freely chosen. The tag name can be also chosen from a fixed machine-tag vocabulary called MISP taxonomies[[@?MISP-T]]. When an event is distributed outside an organisation, the use of MISP taxonomies[[@?MISP-T]] is **RECOMMENDED** to ensure a coherent naming of the tags. A tag is represented as a JSON array where each element describes each tag associated. A tag array **SHALL** be at event level or attribute level. A tag element is described with a name, id, colour and exportable flag.

exportable represents a setting if the tag is kept local or exportable to other MISP instances. exportable is represented by a JSON boolean. id is a human-readable identifier that references the tag on the local instance. colour represents an RGB value of the tag.

name **MUST** be present. colour, id and exportable **SHALL** be present.

### Sample Tag

~~~~
"Tag": [{
        "exportable": true,
        "colour": "#ffffff",
        "name": "tlp:white",
        "id": "2" }]
~~~~

## Galaxy

A galaxy is a simple method to express a large object called cluster that can be attached to MISP events. A cluster can be composed of one or more elements. Elements are expressed as key-values.

### Sample Galaxy

~~~~
"Galaxy": [ {
           "id": "18",
           "uuid": "698774c7-8022-42c4-917f-8d6e4f06ada3",
           "name": "Threat Actor",
           "type": "threat-actor",
           "description": "Threat actors are characteristics of malicious actors
                          (or adversaries) representing a cyber attack threat
                          including presumed intent and historically observed behaviour.",
                "version": "1",
        "GalaxyCluster": [
            {
                "id": "1699",
                "uuid": "7cdff317-a673-4474-84ec-4f1754947823",
                "type": "threat-actor",
                "value": "Anunak",
                "tag_name": "misp-galaxy:threat-actor=\"Anunak\"",
                "description": "Groups targeting financial organizations
                    or people with significant financial assets.",
                "galaxy_id": "18",
                "source": "MISP Project",
                "authors": [
                    "Alexandre Dulaunoy",
                    "Florian Roth",
                    "Thomas Schreck",
                    "Timo Steffens",
                    "Various"
                ],
                "tag_id": "111",
                        "meta": {
                            "synonyms": [
                                "Carbanak",
                                "Carbon Spider"
                            ],
                            "country": [
                                "RU"
                            ],
                            "motive": [
                                "Cybercrime"
                            ]
                        }
                    }
                ]
            }
        ]
~~~~

# JSON Schema

The JSON Schema [@?JSON-SCHEMA] below defines the structure of the MISP core format
as literally described before. The JSON Schema is used to validate MISP events at creation time
or parsing.

~~~~
{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "title": "Validator for misp events",
  "id": "https://github.com/MISP/MISP/blob/2.4/format/2.4/schema.json",
  "defs": {
    "org": {
      "type": "object",
      "additionalProperties": false,
      "properties": {
        "id": {
          "type": "string"
        },
        "name": {
          "type": "string"
        },
        "uuid": {
          "type": "string"
        }
      },
      "required": [
        "uuid"
      ]
    },
    "orgc": {
      "type": "object",
      "additionalProperties": false,
      "properties": {
        "id": {
          "type": "string"
        },
        "name": {
          "type": "string"
        },
        "uuid": {
          "type": "string"
        }
      },
      "required": [
        "uuid"
      ]
    },
    "sharing_group": {
      "type": "object",
      "additionalProperties": false,
      "properties": {
        "id": {
          "type": "string"
        },
        "name": {
          "type": "string"
        },
        "releasability": {
          "type": "string"
        },
        "description": {
          "type": "string"
        },
        "uuid": {
          "type": "string"
        },
        "organisation_uuid": {
          "type": "string"
        },
        "org_id": {
          "type": "string"
        },
        "sync_user_id": {
          "type": "string"
        },
        "active": {
          "type": "boolean"
        },
        "created": {
          "type": "string"
        },
        "modified": {
          "type": "string"
        },
        "local": {
          "type": "boolean"
        },
        "roaming": {
          "type": "boolean"
        },
        "Organisation": {
          "$ref": "#/defs/org"
        },
        "SharingGroupOrg": {
          "type": "array",
          "uniqueItems": true,
          "items": {
            "$ref": "#/defs/sharing_group_org"
          }
        },
        "SharingGroupServer": {
          "type": "array",
          "uniqueItems": true,
          "items": {
            "$ref": "#/defs/sharing_group_server"
          }
        },
        "required": [
          "uuid"
        ]
      },
      "required": [
        "uuid"
      ]
    },
    "sharing_group_org": {
      "type": "object",
      "additionalProperties": false,
      "properties": {
        "id": {
          "type": "string"
        },
        "sharing_group_id": {
          "type": "string"
        },
        "org_id": {
          "type": "string"
        },
        "extend": {
          "type": "boolean"
        },
        "Organisation": {
          "$ref": "#/defs/org"
        }
      }
    },
    "sharing_group_server": {
      "type": "object",
      "additionalProperties": false,
      "properties": {
        "id": {
          "type": "string"
        },
        "sharing_group_id": {
          "type": "string"
        },
        "server_id": {
          "type": "string"
        },
        "all_orgs": {
          "type": "boolean"
        },
        "Server": {
          "$ref": "#/defs/server"
        }
      }
    },
    "server": {
      "type": "object",
      "additionalProperties": false,
      "properties": {
        "id": {
          "type": "string"
        },
        "url": {
          "type": "string"
        },
        "name": {
          "type": "string"
        }
      }
    },
    "attribute": {
      "type": "object",
      "additionalProperties": false,
      "properties": {
        "id": {
          "type": "string"
        },
        "type": {
          "type": "string"
        },
        "category": {
          "type": "string"
        },
        "to_ids": {
          "type": "boolean"
        },
        "uuid": {
          "type": "string"
        },
        "event_id": {
          "type": "string"
        },
        "distribution": {
          "type": "string"
        },
        "timestamp": {
          "type": "string"
        },
        "comment": {
          "type": "string"
        },
        "sharing_group_id": {
          "type": "string"
        },
        "deleted": {
          "type": "boolean"
        },
        "disable_correlation": {
          "type": "boolean"
        },
        "value": {
          "type": "string"
        },
        "data": {
          "type": "string"
        },
        "SharingGroup": {
          "$ref": "#/defs/sharing_group"
        },
        "ShadowAttribute": {
          "type": "array",
          "uniqueItems": true,
          "items": {
            "$ref": "#/defs/attribute"
          }
        },
        "Tag": {
          "type": "array",
          "uniqueItems": true,
          "items": {
            "$ref": "#/defs/tag"
          }
        }
      }
    },
    "event": {
      "type": "object",
      "additionalProperties": false,
      "properties": {
        "id": {
          "type": "string"
        },
        "orgc_id": {
          "type": "string"
        },
        "org_id": {
          "type": "string"
        },
        "date": {
          "type": "string"
        },
        "threat_level_id": {
          "type": "string"
        },
        "info": {
          "type": "string"
        },
        "published": {
          "type": "boolean"
        },
        "uuid": {
          "type": "string"
        },
        "attribute_count": {
          "type": "string"
        },
        "analysis": {
          "type": "string"
        },
        "timestamp": {
          "type": "string"
        },
        "distribution": {
          "type": "string"
        },
        "proposal_email_lock": {
          "type": "boolean"
        },
        "locked": {
          "type": "boolean"
        },
        "publish_timestamp": {
          "type": "string"
        },
        "sharing_group_id": {
          "type": "string"
        },
        "disable_correlation": {
          "type": "boolean"
        },
        "event_creator_email": {
          "type": "string"
        },
        "Org": {
          "$ref": "#/defs/org"
        },
        "Orgc": {
          "$ref": "#/defs/org"
        },
        "SharingGroup": {
          "$ref": "#/defs/sharing_group"
        },
        "Attribute": {
          "type": "array",
          "uniqueItems": true,
          "items": {
            "$ref": "#/defs/attribute"
          }
        },
        "ShadowAttribute": {
          "type": "array",
          "uniqueItems": true,
          "items": {
            "$ref": "#/defs/attribute"
          }
        },
        "RelatedEvent": {
          "type": "array",
          "uniqueItems": true,
          "items": {
            "type": "object",
            "additionalProperties": false,
            "properties": {
                "Event":{
                  "$ref": "#/defs/event"
                }
            }
          }
        },
        "Galaxy": {
          "type": "array",
          "uniqueItems": true,
          "items": {
            "$ref": "#/defs/galaxy"
          }
        },
        "Tag": {
          "type": "array",
          "uniqueItems": true,
          "items": {
            "$ref": "#/defs/tag"
          }
        }
      }
    },
    "tag": {
      "type": "object",
      "additionalProperties": false,
      "properties": {
        "id": {
          "type": "string"
        },
        "name": {
          "type": "string"
        },
        "colour": {
          "type": "string"
        },
        "exportable": {
          "type": "boolean"
        },
        "hide_tag": {
          "type": "boolean"
        }
      }
    },
    "galaxy": {
      "type": "object",
      "additionalProperties": false,
      "properties": {
        "id": {
          "type": "string"
        },
        "uuid": {
          "type": "string"
        },
        "name": {
          "type": "string"
        },
        "type": {
          "type": "string"
        },
        "description": {
          "type": "string"
        },
        "version": {
          "type": "string"
        },
        "GalaxyCluster": {
          "type": "array",
          "uniqueItems": true,
          "items": {
            "$ref": "#/defs/galaxy_cluster"
          }
        }
      }
    },
    "galaxy_cluster": {
      "type": "object",
      "additionalProperties": false,
      "properties": {
        "id": {
          "type": "string"
        },
        "uuid": {
          "type": "string"
        },
        "type": {
          "type": "string"
        },
        "value": {
          "type": "string"
        },
        "tag_name": {
          "type": "string"
        },
        "description": {
          "type": "string"
        },
        "galaxy_id": {
          "type": "string"
        },
        "source": {
          "type": "string"
        },
        "authors": {
          "type": "array",
          "uniqueItems": true,
          "items": {
            "type": "string"
          }
        },
        "tag_id": {
          "type": "string"
        },
        "meta": {
          "type": "object"
        }
      }
    }
  },
  "type": "object",
  "properties": {
    "Event": {
      "$ref": "#/defs/event"
    }
  },
  "required": [
    "Event"
  ]
}
~~~~

# Manifest

MISP events can be shared over an HTTP repository, a file package or USB key. A manifest file is used to
provide an index of MISP events allowing to only fetch the recently updated files without the need to parse
each json file.

## Format

A manifest file is a simple JSON file named manifest.json in a directory where the MISP events are located.
Each MISP event is a file located in the same directory with the event uuid as filename with the json extension.

The manifest format is a JSON object composed of a dictionary where the field is the uuid of the event.

Each uuid is composed of a JSON object with the following fields which came from the original event referenced
by the same uuid:

- info (**MUST**)
- Orgc object (**MUST**)
- analysis (**SHALL**)
- timestamp (**MUST**)
- date (**MUST**)
- threat_level_id (**SHALL**)

In addition to the fields originating from the event, the following fields can be added:

- integrity:sha256 represents the SHA256 value in hexadecimal representation of the associated MISP event file to ensure integrity of the file. (**SHOULD**)
- integrity:pgp represents a detached PGP signature [@!RFC4880] of the associated MISP event file to ensure integrity of the file. (**SHOULD**)

If a detached PGP signature is used for each MISP event, a detached PGP signature is a **MUST** to ensure integrity of the manifest file.
A detached PGP signature for a manifest file is a manifest.json.pgp file containing the PGP signature.

### Sample Manifest

~~~~
{
  "57c6ac4c-c60c-4f79-a38f-b666950d210f": {
    "info": "Malspam 2016-08-31 (.wsf in .zip) - campaign: Photo",
    "Orgc": {
      "id": "2",
      "name": "CIRCL"
    },
    "analysis": "0",
    "Tag": [
      {
        "colour": "#3d7a00",
        "name": "circl:incident-classification=\"malware\""
      },
      {
        "colour": "#ffffff",
        "name": "tlp:white"
      }
    ],
    "timestamp": "1472638251",
    "date": "2016-08-31",
    "threat_level_id": "3"
  },
  "5720accd-dd28-45f8-80e5-4605950d210f": {
    "info": "Malspam 2016-04-27 - Locky",
    "Orgc": {
      "id": "2",
      "name": "CIRCL"
    },
    "analysis": "2",
    "Tag": [
      {
        "colour": "#ffffff",
        "name": "tlp:white"
      },
      {
        "colour": "#3d7a00",
        "name": "circl:incident-classification=\"malware\""
      },
      {
        "colour": "#2c4f00",
        "name": "malware_classification:malware-category=\"Ransomware\""
      }
    ],
    "timestamp": "1461764231",
    "date": "2016-04-27",
    "threat_level_id": "3"
  }
}
~~~~

# Implementation

MISP format is implemented by different software including the MISP threat sharing
platform and libraries like PyMISP [@?MISP-P]. Implementations use the format
as an export/import mechanism, staging transport format or synchronisation format
as used in the MISP core platform. MISP format doesn't impose any restriction on
the data representation of the format in data-structure of other implementations.

# Security Considerations

MISP events might contain sensitive or confidential information. Adequate
access control and encryption measures shall be implemented to ensure
the confidentiality of the MISP events.

Adversaries might include malicious content in MISP events and attributes.
Implementation **MUST** consider the input of malicious inputs beside the
standard threat information that might already include malicious intended inputs.

# Acknowledgements

The authors wish to thank all the MISP community to support the creation
of open standards in threat intelligence sharing.

# Sample MISP file


<reference anchor='MISP-P' target='https://github.com/MISP'>
  <front>
   <title>MISP Project - Malware Information Sharing Platform and Threat Sharing</title>
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

<reference anchor='JSON-SCHEMA' target='https://tools.ietf.org/html/draft-wright-json-schema'>
  <front>
    <title>JSON Schema: A Media Type for Describing JSON Documents</title>
    <author initials='' surname='' fullname='Austin Wright'></author>
    <date year="2016"></date>
  </front>
</reference>


{backmatter}
