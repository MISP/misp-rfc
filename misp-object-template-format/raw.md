%%%
Title = "MISP object template format"
abbrev = "MISP object template format"
category = "info"
docName = "draft-dulaunoy-misp-object-template-format"
ipr= "trust200902"
area = "Security"
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
  street = "16, bd d'Avranches"
  city = "Luxembourg"
  code = "L-1611"
  country = "Luxembourg"
[[author]]
initials="A."
surname="Iklody"
fullname="Andras Iklody"
abbrev="CIRCL"
organization = "Computer Incident Response Center Luxembourg"
 [author.address]
 email = "andras.iklody@circl.lu"
 phone = "+352 247 88444"
  [author.address.postal]
  street = " 16, bd d'Avranches"
  city = "Luxembourg"
  code = "L-1611"
  country = "Luxembourg"
%%%

.# Abstract


This document describes the MISP object template format which describes a simple JSON format to represent the various templates used to construct MISP objects. A public directory of common vocabularies MISP object templates [@?MISP-O] is available and relies on the MISP object reference format.

{mainmatter}

# Introduction

Due to the increased maturity of threat information sharing, the need arose for more complex and exhaustive data-points to be shared across the various sharing communities. MISP's information sharing in general relied on a flat structure of attributes contained within an event, where attributes served as atomic secluded data-points with some commonalities as defined by the encapsulating event. However, this flat structure restricted the use of more diverse and complex data-points described by a list of atomic values, a problem solved by the MISP object structure.

MISP objects combine a list of attributes to represent a singular object with various facets. In order to bootstrap the object creation process and to maintain uniformity among objects describing similar data-points, the MISP object template format serves as a reusable and share-able blueprint format.

MISP object templates also include a vocabulary to describe the various inter object and object to attribute relationships and are leveraged by MISP object references.

##  Conventions and Terminology

The key words "**MUST**", "**MUST NOT**", "**REQUIRED**", "**SHALL**", "**SHALL NOT**",
"**SHOULD**", "**SHOULD NOT**", "**RECOMMENDED**", "**MAY**", and "**OPTIONAL**" in this
document are to be interpreted as described in RFC 2119 [@!RFC2119].

# Format

MISP object templates are composed of the MISP object template (**MUST**) structure itself and a list of MISP object template elements (**SHOULD**) describing the list of possible attributes belonging to the resulting object, along with their context and settings.

MISP object templates themselves consist of a name (**MUST**), a meta-category (**MUST**) and a description (**SHOULD**). They are identified by a uuid (**MUST**) and a version (**MUST**). For any updates or transfer of the same object reference. UUID version 4 is **RECOMMENDED** when assigning it to a new object reference. The list of requirements when it comes to the contained MISP object template elements is defined in the requirements field (**OPTIONAL**).

MISP object template elements consist of an object\_relation (**MUST**), a type (**MUST**), an object\_template\_id (**SHOULD**), a ui\_priority (**SHOULD**), a list of categories (**MAY**), a list of sane\_default values (**MAY**) or a values\_list (**MAY**).

## Overview

The MISP object template format uses the JSON [@!RFC8259] format. Each template is represented as a JSON object with meta information including the following fields: uuid, requiredOneOf, description, version, meta-category, name.

### Object Template

#### uuid

uuid represents the Universally Unique IDentifier (UUID) [@!RFC4122] of the object template. The uuid **MUST** be preserved for to keep consistency of the templates across instances. UUID version 4 is **RECOMMENDED** when assigning it to a new object template.

uuid is represented as a JSON string. uuid **MUST** be present.

#### requiredOneOf

requiredOneOf is represented as a JSON list and contains a list of attribute relationships of which one must be present in the object to be created based on the given template. The requiredOneOf field **MAY** be present.

#### required

required is represented as a JSON list and contains a list of attribute relationships of which all must be present in the object to be created based on the given template. The required field **MAY** be present.

#### description

description is represented as a JSON string and contains the assigned meaning given to objects created using this template. The description field **MUST** be present.

#### version

version represents a numeric incrementing version of the object template. It is used to associate the object to the correct version of the template and together with the uuid field forms an association to the correct template type and version.

version is represented as a JSON string. version **MUST** be present.

#### meta-category

meta-category represents the sub-category of objects that the given object template belongs to. meta-categories are not tied to a fixed list of options but can be created on the fly.

meta-category is represented as a JSON string. meta-category **MUST** be present.

#### name

name represents the human-readable name of the objects created using the given template, describing the intent of the object package.

name is represented as a JSON string. name **MUST** be present

### attributes

attributes is represented as a JSON list and contains a list of template elements used as a template for creating the individual attributes within the object that is to be created with the object.

attributes is represented as a JSON list. attributes **MUST** be present.

#### description

description is represented as a JSON string and contains the description of the given attribute in the context of the object with the given relationship. The description field **MUST** be present.

#### ui-priority

ui-priority is represented by a numeric values in JSON string format and is meant to provide a priority for the given element in the object template visualisation. The ui-priority **MAY** be present.

#### misp-attribute

misp-attribute is represented by a JSON string or a JSON object with a list of values. The value(s) are taken from the pool of types defined by the MISP core format's Attribute Object's type list. type can contain a JSON object with a list of suggested value alternatives encapsulated in a list within a sane\_default key or a list of enforced value alternatives encapsulated in a list\_values key.

The misp-attribute field **MUST** be present.

#### disable\_correlation

disable\_correlation is represented by a JSON boolean. The disable\_correlation field flags the attribute(s) created by the given object template element to be marked as non correlating.

The misp-attribute field **MAY** be present.

#### categories

categories is represented by a JSON list containing one or several valid options from the list of verbs valid for the category field in the Attribute object within the MISP core format.

The categories field **MAY** be present.

#### multiple

multiple is represented by a JSON boolean value. It marks the MISP object template element as a multiple input field, allowing for several attributes to be created by the element within the same object.

The multiple field **MAY** be present.

#### sane\_default

sane\_default is represented by a JSON list containing one or several recommended/sane values for an attribute. sane\_default is mutually exclusive with values\_list.

The sane\_default field **MAY** be present.

#### values\_list

values\_list is represented by a JSON List containing one or several of fixed values for an attribute. values\_list is mutually exclusive with sane\_default.

The value\_list field **MAY** be present.

### Sample Object Template object

The MISP object template directory is publicly available [@?MISP-O] in a git repository and contains more than 60 object templates. As illustration, two sample objects templates are included.

#### credit-card object template

~~~~
{
  "requiredOneOf": [
    "cc-number"
  ],
  "attributes": {
    "version": {
      "description": "Version of the card.",
      "ui-priority": 0,
      "misp-attribute": "text"
    },
    "comment": {
      "description": "A description of the card.",
      "ui-priority": 0,
      "misp-attribute": "comment"
    },
    "card-security-code": {
      "description": "Card security code (CSC, CVD, CVV, CVC and SPC) as embossed or printed on the card.",
      "ui-priority": 0,
      "misp-attribute": "text"
    },
    "name": {
      "description": "Name of the card owner.",
      "ui-priority": 0,
      "misp-attribute": "text"
    },
    "issued": {
      "description": "Initial date of validity or issued date.",
      "ui-priority": 0,
      "misp-attribute": "datetime"
    },
    "expiration": {
      "description": "Maximum date of validity",
      "ui-priority": 0,
      "misp-attribute": "datetime"
    },
    "cc-number": {
      "description": "credit-card number as encoded on the card.",
      "ui-priority": 0,
      "misp-attribute": "cc-number"
    }
  },
  "version": 2,
  "description": "A payment card like credit card, debit card or any similar cards which can be used for financial transactions.",
  "meta-category": "financial",
  "uuid": "2b9c57aa-daba-4330-a738-56f18743b0c7",
  "name": "credit-card"
}
~~~~

#### credential object template

~~~~
{
  "requiredOneOf": [
    "password"
  ],
  "attributes": {
    "text": {
      "description": "A description of the credential(s)",
      "disable_correlation": true,
      "ui-priority": 1,
      "misp-attribute": "text"
    },
    "username": {
      "description": "Username related to the password(s)",
      "ui-priority": 1,
      "misp-attribute": "text"
    },
    "password": {
      "description": "Password",
      "multiple": true,
      "ui-priority": 1,
      "misp-attribute": "text"
    },
    "type": {
      "description": "Type of password(s)",
      "ui-priority": 1,
      "misp-attribute": "text",
      "values_list": [
        "password",
        "api-key",
        "encryption-key",
        "unknown"
      ]
    },
    "origin": {
      "description": "Origin of the credential(s)",
      "ui-priority": 1,
      "misp-attribute": "text",
      "sane_default": [
        "bruteforce-scanning",
        "malware-analysis",
        "memory-analysis",
        "network-analysis",
        "leak",
        "unknown"
      ]
    },
    "format": {
      "description": "Format of the password(s)",
      "ui-priority": 1,
      "misp-attribute": "text",
      "values_list": [
        "clear-text",
        "hashed",
        "encrypted",
        "unknown"
      ]
    },
    "notification": {
      "description": "Mention of any notification(s) towards the potential owner(s) of the credential(s)",
      "ui-priority": 1,
      "misp-attribute": "text",
      "multiple": true,
      "values_list": [
        "victim-notified",
        "service-notified",
        "none"
      ]
    }
  },
  "version": 2,
  "description": "Credential describes one or more credential(s) including password(s), api key(s) or decryption key(s).",
  "meta-category": "misc",
  "uuid": "a27e98c9-9b0e-414c-8076-d201e039ca09",
  "name": "credential"
}
~~~~

### Object Relationships

#### name

name represents the human-readable relationship type which can be used when creating MISP object relations.

name is represented as a JSON string. name **MUST** be present.

#### description

description is represented as a JSON string and contains the description of the object relationship type. The description field **MUST** be present.

#### format

format is represented by a JSON list containing a list of formats that the relationship type is valid for and can be mapped to. The format field **MUST** be present.

# Directory

The MISP object template directory is publicly available [@?MISP-O] in a git repository. The repository contains an objects directory, which contains a directory per object type, containing a file named definition.json which contains the definition of the object template in the above described format.

A relationships directory is also included, containing a definition.json file which contains a list of MISP object relation definitions. There are more than 125 existing templates object documented in [@?MISP-O-DOC].

## Existing and public MISP object templates

- [objects/ail-leak](https://github.com/MISP/misp-objects/blob/main/objects/ail-leak/definition.json) - An information leak as defined by the AIL Analysis Information Leak framework.
- [objects/ais-info](https://github.com/MISP/misp-objects/blob/main/objects/ais-info/definition.json) - Automated Indicator Sharing (AIS) Information Source Markings.
- [objects/android-app](https://github.com/MISP/misp-objects/blob/main/objects/android-app/definition.json) - Indicators related to an Android app.
- [objects/android-permission](https://github.com/MISP/misp-objects/blob/main/objects/android-permission/definition.json) - A set of android permissions - one or more permission(s) which can be linked to other objects (e.g. malware, app).
- [objects/annotation](https://github.com/MISP/misp-objects/blob/main/objects/annotation/definition.json) - An annotation object allowing analysts to add annotations, comments, executive summary to a MISP event, objects or attributes.
- [objects/anonymisation](https://github.com/MISP/misp-objects/blob/main/objects/anonymisation/definition.json) - Anonymisation object describing an anonymisation technique used to encode MISP attribute values. Reference: https://www.caida.org/tools/taxonomy/anonymization.xml.
- [objects/asn](https://github.com/MISP/misp-objects/blob/main/objects/asn/definition.json) - Autonomous system object describing an autonomous system which can include one or more network operators management an entity (e.g. ISP) along with their routing policy, routing prefixes or alike.
- [objects/attack-pattern](https://github.com/MISP/misp-objects/blob/main/objects/attack-pattern/definition.json) - Attack pattern describing a common attack pattern enumeration and classification.
- [objects/authentication-failure-report](https://github.com/MISP/misp-objects/blob/main/objects/authentication-failure-report/definition.json) - Authentication Failure Report.
- [objects/authenticode-signerinfo](https://github.com/MISP/misp-objects/blob/main/objects/authenticode-signerinfo/definition.json) - Authenticode Signer Info.
- [objects/av-signature](https://github.com/MISP/misp-objects/blob/main/objects/av-signature/definition.json) - Antivirus detection signature.
- [objects/bank-account](https://github.com/MISP/misp-objects/blob/main/objects/bank-account/definition.json) - An object describing bank account information based on account description from goAML 4.0.
- [objects/bgp-hijack](https://github.com/MISP/misp-objects/blob/main/objects/bgp-hijack/definition.json) - Object encapsulating BGP Hijack description as specified, for example, by bgpstream.com.
- [objects/bgp-ranking](https://github.com/MISP/misp-objects/blob/main/objects/bgp-ranking/definition.json) - BGP Ranking object describing the ranking of an ASN for a given day, along with its position, 1 being the most malicious ASN of the day, with the highest ranking. This object is meant to have a relationship with the corresponding ASN object and represents its ranking for a specific date.
- [objects/blog](https://github.com/MISP/misp-objects/blob/main/objects/blog/definition.json) - Blog post like Medium or WordPress.
- [objects/boleto](https://github.com/MISP/misp-objects/blob/main/objects/boleto/definition.json) - A common form of payment used in Brazil.
- [objects/btc-transaction](https://github.com/MISP/misp-objects/blob/main/objects/btc-transaction/definition.json) - An object to describe a Bitcoin transaction. Best to be used with bitcoin-wallet.
- [objects/btc-wallet](https://github.com/MISP/misp-objects/blob/main/objects/btc-wallet/definition.json) - An object to describe a Bitcoin wallet. Best to be used with bitcoin-transactions.
- [objects/cap-alert](https://github.com/MISP/misp-objects/blob/main/objects/cap-alert/definition.json) - Common Alerting Protocol Version (CAP) alert object.
- [objects/cap-info](https://github.com/MISP/misp-objects/blob/main/objects/cap-info/definition.json) - Common Alerting Protocol Version (CAP) info object.
- [objects/cap-resource](https://github.com/MISP/misp-objects/blob/main/objects/cap-resource/definition.json) - Common Alerting Protocol Version (CAP) resource object.
- [objects/coin-address](https://github.com/MISP/misp-objects/blob/main/objects/coin-address/definition.json) - An address used in a cryptocurrency.
- [objects/command](https://github.com/MISP/misp-objects/blob/main/objects/command/definition.json) - Command functionalities related to specific commands executed by a program, whether it is malicious or not. Command-line are attached to this object for the related commands.
- [objects/command-line](https://github.com/MISP/misp-objects/blob/main/objects/command-line/definition.json) - Command line and options related to a specific command executed by a program, whether it is malicious or not.
- [objects/cookie](https://github.com/MISP/misp-objects/blob/main/objects/cookie/definition.json) - An HTTP cookie (web cookie, browser cookie) is a small piece of data that a server sends to the user's web browser. The browser may store it and send it back with the next request to the same server. Typically, it's used to tell if two requests came from the same browser — keeping a user logged-in, for example. It remembers stateful information for the stateless HTTP protocol. (as defined by the Mozilla foundation.
- [objects/cortex](https://github.com/MISP/misp-objects/blob/main/objects/cortex/definition.json) - Cortex object describing a complete cortex analysis. Observables would be attribute with a relationship from this object.
- [objects/cortex-taxonomy](https://github.com/MISP/misp-objects/blob/main/objects/cortex-taxonomy/definition.json) - Cortex object describing an Cortex Taxonomy (or mini report).
- [objects/course-of-action](https://github.com/MISP/misp-objects/blob/main/objects/course-of-action/definition.json) - An object describing a specific measure taken to prevent or respond to an attack.
- [objects/covid19-csse-daily-report](https://github.com/MISP/misp-objects/blob/main/objects/covid19-csse-daily-report/definition.json) - CSSE COVID-19 Daily report.
- [objects/covid19-dxy-live-city](https://github.com/MISP/misp-objects/blob/main/objects/covid19-dxy-live-city/definition.json) - COVID 19 from dxy.cn - Aggregation by city.
- [objects/covid19-dxy-live-province](https://github.com/MISP/misp-objects/blob/main/objects/covid19-dxy-live-province/definition.json) - COVID 19 from dxy.cn - Aggregation by province.
- [objects/cowrie](https://github.com/MISP/misp-objects/blob/main/objects/cowrie/definition.json) - Cowrie honeypot object template.
- [objects/cpe-asset](https://github.com/MISP/misp-objects/blob/main/objects/cpe-asset/definition.json) - An asset which can be defined by a CPE. This can be a generic asset. CPE is a structured naming scheme for information technology systems, software, and packages.
- [objects/credential](https://github.com/MISP/misp-objects/blob/main/objects/credential/definition.json) - Credential describes one or more credential(s) including password(s), api key(s) or decryption key(s).
- [objects/credit-card](https://github.com/MISP/misp-objects/blob/main/objects/credit-card/definition.json) - A payment card like credit card, debit card or any similar cards which can be used for financial transactions.
- [objects/crypto-material](https://github.com/MISP/misp-objects/blob/main/objects/crypto-material/definition.json) - Cryptographic materials such as public or/and private keys.
- [objects/cytomic-orion-file](https://github.com/MISP/misp-objects/blob/main/objects/cytomic-orion-file/definition.json) - Cytomic Orion File Detection.
- [objects/cytomic-orion-machine](https://github.com/MISP/misp-objects/blob/main/objects/cytomic-orion-machine/definition.json) - Cytomic Orion File at Machine Detection.
- [objects/dark-pattern-item](https://github.com/MISP/misp-objects/blob/main/objects/dark-pattern-item/definition.json) - An Item whose User Interface implements a dark pattern.
- [objects/ddos](https://github.com/MISP/misp-objects/blob/main/objects/ddos/definition.json) - DDoS object describes a current DDoS activity from a specific or/and to a specific target. Type of DDoS can be attached to the object as a taxonomy.
- [objects/device](https://github.com/MISP/misp-objects/blob/main/objects/device/definition.json) - An object to define a device.
- [objects/diameter-attack](https://github.com/MISP/misp-objects/blob/main/objects/diameter-attack/definition.json) - Attack as seen on diameter authentication against a GSM, UMTS or LTE network.
- [objects/dns-record](https://github.com/MISP/misp-objects/blob/main/objects/dns-record/definition.json) - A set of DNS records observed for a specific domain.
- [objects/domain-crawled](https://github.com/MISP/misp-objects/blob/main/objects/domain-crawled/definition.json) - A domain crawled over time.
- [objects/domain-ip](https://github.com/MISP/misp-objects/blob/main/objects/domain-ip/definition.json) - A domain/hostname and IP address seen as a tuple in a specific time frame.
- [objects/elf](https://github.com/MISP/misp-objects/blob/main/objects/elf/definition.json) - Object describing a Executable and Linkable Format.
- [objects/elf-section](https://github.com/MISP/misp-objects/blob/main/objects/elf-section/definition.json) - Object describing a section of an Executable and Linkable Format.
- [objects/email](https://github.com/MISP/misp-objects/blob/main/objects/email/definition.json) - Email object describing an email with meta-information.
- [objects/employee](https://github.com/MISP/misp-objects/blob/main/objects/employee/definition.json) - An employee and related data points.
- [objects/exploit-poc](https://github.com/MISP/misp-objects/blob/main/objects/exploit-poc/definition.json) - Exploit-poc object describing a proof of concept or exploit of a vulnerability. This object has often a relationship with a vulnerability object.
- [objects/facebook-account](https://github.com/MISP/misp-objects/blob/main/objects/facebook-account/definition.json) - Facebook account.
- [objects/facebook-group](https://github.com/MISP/misp-objects/blob/main/objects/facebook-group/definition.json) - Public or private facebook group.
- [objects/facebook-page](https://github.com/MISP/misp-objects/blob/main/objects/facebook-page/definition.json) - Facebook page.
- [objects/facebook-post](https://github.com/MISP/misp-objects/blob/main/objects/facebook-post/definition.json) - Post on a Facebook wall.
- [objects/facial-composite](https://github.com/MISP/misp-objects/blob/main/objects/facial-composite/definition.json) - An object which describes a facial composite.
- [objects/fail2ban](https://github.com/MISP/misp-objects/blob/main/objects/fail2ban/definition.json) - Fail2ban event.
- [objects/favicon](https://github.com/MISP/misp-objects/blob/main/objects/favicon/definition.json) - A favicon, also known as a shortcut icon, website icon, tab icon, URL icon, or bookmark icon, is a file containing one or more small icons, associated with a particular website or web page. The object template can include the murmur3 hash of the favicon to facilitate correlation.
- [objects/file](https://github.com/MISP/misp-objects/blob/main/objects/file/definition.json) - File object describing a file with meta-information.
- [objects/forensic-case](https://github.com/MISP/misp-objects/blob/main/objects/forensic-case/definition.json) - An object template to describe a digital forensic case.
- [objects/forensic-evidence](https://github.com/MISP/misp-objects/blob/main/objects/forensic-evidence/definition.json) - An object template to describe a digital forensic evidence.
- [objects/forged-document](https://github.com/MISP/misp-objects/blob/main/objects/forged-document/definition.json) - Object describing a forged document.
- [objects/ftm-Airplane](https://github.com/MISP/misp-objects/blob/main/objects/ftm-Airplane/definition.json) - .
- [objects/ftm-Assessment](https://github.com/MISP/misp-objects/blob/main/objects/ftm-Assessment/definition.json) - .
- [objects/ftm-Asset](https://github.com/MISP/misp-objects/blob/main/objects/ftm-Asset/definition.json) - .
- [objects/ftm-Associate](https://github.com/MISP/misp-objects/blob/main/objects/ftm-Associate/definition.json) - Non-family association between two people.
- [objects/ftm-Audio](https://github.com/MISP/misp-objects/blob/main/objects/ftm-Audio/definition.json) - .
- [objects/ftm-BankAccount](https://github.com/MISP/misp-objects/blob/main/objects/ftm-BankAccount/definition.json) - .
- [objects/ftm-Call](https://github.com/MISP/misp-objects/blob/main/objects/ftm-Call/definition.json) - .
- [objects/ftm-Company](https://github.com/MISP/misp-objects/blob/main/objects/ftm-Company/definition.json) - .
- [objects/ftm-Contract](https://github.com/MISP/misp-objects/blob/main/objects/ftm-Contract/definition.json) - An contract or contract lot issued by an authority. Multiple lots may be awarded to different suppliers (see ContractAward).
.
- [objects/ftm-ContractAward](https://github.com/MISP/misp-objects/blob/main/objects/ftm-ContractAward/definition.json) - A contract or contract lot as awarded to a supplier.
- [objects/ftm-CourtCase](https://github.com/MISP/misp-objects/blob/main/objects/ftm-CourtCase/definition.json) - .
- [objects/ftm-CourtCaseParty](https://github.com/MISP/misp-objects/blob/main/objects/ftm-CourtCaseParty/definition.json) - .
- [objects/ftm-Debt](https://github.com/MISP/misp-objects/blob/main/objects/ftm-Debt/definition.json) - A monetary debt between two parties.
- [objects/ftm-Directorship](https://github.com/MISP/misp-objects/blob/main/objects/ftm-Directorship/definition.json) - .
- [objects/ftm-Document](https://github.com/MISP/misp-objects/blob/main/objects/ftm-Document/definition.json) - .
- [objects/ftm-Documentation](https://github.com/MISP/misp-objects/blob/main/objects/ftm-Documentation/definition.json) - .
- [objects/ftm-EconomicActivity](https://github.com/MISP/misp-objects/blob/main/objects/ftm-EconomicActivity/definition.json) - A foreign economic activity.
- [objects/ftm-Email](https://github.com/MISP/misp-objects/blob/main/objects/ftm-Email/definition.json) - .
- [objects/ftm-Event](https://github.com/MISP/misp-objects/blob/main/objects/ftm-Event/definition.json) - .
- [objects/ftm-Family](https://github.com/MISP/misp-objects/blob/main/objects/ftm-Family/definition.json) - Family relationship between two people.
- [objects/ftm-Folder](https://github.com/MISP/misp-objects/blob/main/objects/ftm-Folder/definition.json) - .
- [objects/ftm-HyperText](https://github.com/MISP/misp-objects/blob/main/objects/ftm-HyperText/definition.json) - .
- [objects/ftm-Image](https://github.com/MISP/misp-objects/blob/main/objects/ftm-Image/definition.json) - .
- [objects/ftm-Land](https://github.com/MISP/misp-objects/blob/main/objects/ftm-Land/definition.json) - .
- [objects/ftm-LegalEntity](https://github.com/MISP/misp-objects/blob/main/objects/ftm-LegalEntity/definition.json) - A legal entity may be a person or a company.
- [objects/ftm-License](https://github.com/MISP/misp-objects/blob/main/objects/ftm-License/definition.json) - A grant of land, rights or property. A type of Contract.
- [objects/ftm-Membership](https://github.com/MISP/misp-objects/blob/main/objects/ftm-Membership/definition.json) - .
- [objects/ftm-Message](https://github.com/MISP/misp-objects/blob/main/objects/ftm-Message/definition.json) - .
- [objects/ftm-Organization](https://github.com/MISP/misp-objects/blob/main/objects/ftm-Organization/definition.json) - .
- [objects/ftm-Ownership](https://github.com/MISP/misp-objects/blob/main/objects/ftm-Ownership/definition.json) - .
- [objects/ftm-Package](https://github.com/MISP/misp-objects/blob/main/objects/ftm-Package/definition.json) - .
- [objects/ftm-Page](https://github.com/MISP/misp-objects/blob/main/objects/ftm-Page/definition.json) - .
- [objects/ftm-Pages](https://github.com/MISP/misp-objects/blob/main/objects/ftm-Pages/definition.json) - .
- [objects/ftm-Passport](https://github.com/MISP/misp-objects/blob/main/objects/ftm-Passport/definition.json) - Passport.
- [objects/ftm-Payment](https://github.com/MISP/misp-objects/blob/main/objects/ftm-Payment/definition.json) - A monetary payment between two parties.
- [objects/ftm-Person](https://github.com/MISP/misp-objects/blob/main/objects/ftm-Person/definition.json) - An individual.
- [objects/ftm-PlainText](https://github.com/MISP/misp-objects/blob/main/objects/ftm-PlainText/definition.json) - .
- [objects/ftm-PublicBody](https://github.com/MISP/misp-objects/blob/main/objects/ftm-PublicBody/definition.json) - A public body, such as a ministry, department or state company.
- [objects/ftm-RealEstate](https://github.com/MISP/misp-objects/blob/main/objects/ftm-RealEstate/definition.json) - A piece of land or property.
- [objects/ftm-Representation](https://github.com/MISP/misp-objects/blob/main/objects/ftm-Representation/definition.json) - A mediatory, intermediary, middleman, or broker acting on behalf of a legal entity.
- [objects/ftm-Row](https://github.com/MISP/misp-objects/blob/main/objects/ftm-Row/definition.json) - .
- [objects/ftm-Sanction](https://github.com/MISP/misp-objects/blob/main/objects/ftm-Sanction/definition.json) - A sanction designation.
- [objects/ftm-Succession](https://github.com/MISP/misp-objects/blob/main/objects/ftm-Succession/definition.json) - Two entities that legally succeed each other.
- [objects/ftm-Table](https://github.com/MISP/misp-objects/blob/main/objects/ftm-Table/definition.json) - .
- [objects/ftm-TaxRoll](https://github.com/MISP/misp-objects/blob/main/objects/ftm-TaxRoll/definition.json) - A tax declaration of an individual.
- [objects/ftm-UnknownLink](https://github.com/MISP/misp-objects/blob/main/objects/ftm-UnknownLink/definition.json) - .
- [objects/ftm-UserAccount](https://github.com/MISP/misp-objects/blob/main/objects/ftm-UserAccount/definition.json) - .
- [objects/ftm-Vehicle](https://github.com/MISP/misp-objects/blob/main/objects/ftm-Vehicle/definition.json) - .
- [objects/ftm-Vessel](https://github.com/MISP/misp-objects/blob/main/objects/ftm-Vessel/definition.json) - A boat or ship.
- [objects/ftm-Video](https://github.com/MISP/misp-objects/blob/main/objects/ftm-Video/definition.json) - .
- [objects/ftm-Workbook](https://github.com/MISP/misp-objects/blob/main/objects/ftm-Workbook/definition.json) - .
- [objects/geolocation](https://github.com/MISP/misp-objects/blob/main/objects/geolocation/definition.json) - An object to describe a geographic location.
- [objects/git-vuln-finder](https://github.com/MISP/misp-objects/blob/main/objects/git-vuln-finder/definition.json) - Export from git-vuln-finder.
- [objects/github-user](https://github.com/MISP/misp-objects/blob/main/objects/github-user/definition.json) - GitHub user.
- [objects/gitlab-user](https://github.com/MISP/misp-objects/blob/main/objects/gitlab-user/definition.json) - GitLab user. Gitlab.com user or self-hosted GitLab instance.
- [objects/gtp-attack](https://github.com/MISP/misp-objects/blob/main/objects/gtp-attack/definition.json) - GTP attack object as seen on a GSM, UMTS or LTE network.
- [objects/http-request](https://github.com/MISP/misp-objects/blob/main/objects/http-request/definition.json) - A single HTTP request header.
- [objects/ilr-impact](https://github.com/MISP/misp-objects/blob/main/objects/ilr-impact/definition.json) - Institut Luxembourgeois de Regulation - Impact.
- [objects/ilr-notification-incident](https://github.com/MISP/misp-objects/blob/main/objects/ilr-notification-incident/definition.json) - Institut Luxembourgeois de Regulation - Notification d'incident.
- [objects/image](https://github.com/MISP/misp-objects/blob/main/objects/image/definition.json) - Object describing an image file.
- [objects/impersonation](https://github.com/MISP/misp-objects/blob/main/objects/impersonation/definition.json) - Represent an impersonating account.
- [objects/imsi-catcher](https://github.com/MISP/misp-objects/blob/main/objects/imsi-catcher/definition.json) - IMSI Catcher entry object based on the open source IMSI cather.
- [objects/instant-message](https://github.com/MISP/misp-objects/blob/main/objects/instant-message/definition.json) - Instant Message (IM) object template describing one or more IM message.
- [objects/instant-message-group](https://github.com/MISP/misp-objects/blob/main/objects/instant-message-group/definition.json) - Instant Message (IM) group object template describing a public or private IM group, channel or conversation.
- [objects/intel471-vulnerability-intelligence](https://github.com/MISP/misp-objects/blob/main/objects/intel471-vulnerability-intelligence/definition.json) - Intel 471 vulnerability intelligence object.
- [objects/intelmq_event](https://github.com/MISP/misp-objects/blob/main/objects/intelmq_event/definition.json) - IntelMQ Event.
- [objects/intelmq_report](https://github.com/MISP/misp-objects/blob/main/objects/intelmq_report/definition.json) - IntelMQ Report.
- [objects/internal-reference](https://github.com/MISP/misp-objects/blob/main/objects/internal-reference/definition.json) - Internal reference.
- [objects/interpol-notice](https://github.com/MISP/misp-objects/blob/main/objects/interpol-notice/definition.json) - An object which describes a Interpol notice.
- [objects/iot-device](https://github.com/MISP/misp-objects/blob/main/objects/iot-device/definition.json) - An IoT device.
- [objects/iot-firmware](https://github.com/MISP/misp-objects/blob/main/objects/iot-firmware/definition.json) - A firmware for an IoT device.
- [objects/ip-api-address](https://github.com/MISP/misp-objects/blob/main/objects/ip-api-address/definition.json) - IP Address information. Useful if you are pulling your ip information from ip-api.com.
- [objects/ip-port](https://github.com/MISP/misp-objects/blob/main/objects/ip-port/definition.json) - An IP address (or domain or hostname) and a port seen as a tuple (or as a triple) in a specific time frame.
- [objects/irc](https://github.com/MISP/misp-objects/blob/main/objects/irc/definition.json) - An IRC object to describe an IRC server and the associated channels.
- [objects/ja3](https://github.com/MISP/misp-objects/blob/main/objects/ja3/definition.json) - JA3 is a new technique for creating SSL client fingerprints that are easy to produce and can be easily shared for threat intelligence. Fingerprints are composed of Client Hello packet; SSL Version, Accepted Ciphers, List of Extensions, Elliptic Curves, and Elliptic Curve Formats. https://github.com/salesforce/ja3.
- [objects/keybase-account](https://github.com/MISP/misp-objects/blob/main/objects/keybase-account/definition.json) - Information related to a keybase account, from API Users Object.
- [objects/leaked-document](https://github.com/MISP/misp-objects/blob/main/objects/leaked-document/definition.json) - Object describing a leaked document.
- [objects/legal-entity](https://github.com/MISP/misp-objects/blob/main/objects/legal-entity/definition.json) - An object to describe a legal entity.
- [objects/lnk](https://github.com/MISP/misp-objects/blob/main/objects/lnk/definition.json) - LNK object describing a Windows LNK binary file (aka Windows shortcut).
- [objects/macho](https://github.com/MISP/misp-objects/blob/main/objects/macho/definition.json) - Object describing a file in Mach-O format.
- [objects/macho-section](https://github.com/MISP/misp-objects/blob/main/objects/macho-section/definition.json) - Object describing a section of a file in Mach-O format.
- [objects/mactime-timeline-analysis](https://github.com/MISP/misp-objects/blob/main/objects/mactime-timeline-analysis/definition.json) - Mactime template, used in forensic investigations to describe the timeline of a file activity.
- [objects/malware-config](https://github.com/MISP/misp-objects/blob/main/objects/malware-config/definition.json) - Malware configuration recovered or extracted from a malicious binary.
- [objects/meme-image](https://github.com/MISP/misp-objects/blob/main/objects/meme-image/definition.json) - Object describing a meme (image).
- [objects/microblog](https://github.com/MISP/misp-objects/blob/main/objects/microblog/definition.json) - Microblog post like a Twitter tweet or a post on a Facebook wall.
- [objects/mutex](https://github.com/MISP/misp-objects/blob/main/objects/mutex/definition.json) - Object to describe mutual exclusion locks (mutex) as seen in memory or computer program.
- [objects/narrative](https://github.com/MISP/misp-objects/blob/main/objects/narrative/definition.json) - Object describing a narrative.
- [objects/netflow](https://github.com/MISP/misp-objects/blob/main/objects/netflow/definition.json) - Netflow object describes an network object based on the Netflowv5/v9 minimal definition.
- [objects/network-connection](https://github.com/MISP/misp-objects/blob/main/objects/network-connection/definition.json) - A local or remote network connection.
- [objects/network-socket](https://github.com/MISP/misp-objects/blob/main/objects/network-socket/definition.json) - Network socket object describes a local or remote network connections based on the socket data structure.
- [objects/news-agency](https://github.com/MISP/misp-objects/blob/main/objects/news-agency/definition.json) - News agencies compile news and disseminate news in bulk.
- [objects/news-media](https://github.com/MISP/misp-objects/blob/main/objects/news-media/definition.json) - News media are forms of mass media delivering news to the general public.
- [objects/organization](https://github.com/MISP/misp-objects/blob/main/objects/organization/definition.json) - An object which describes an organization.
- [objects/original-imported-file](https://github.com/MISP/misp-objects/blob/main/objects/original-imported-file/definition.json) - Object describing the original file used to import data in MISP.
- [objects/parler-account](https://github.com/MISP/misp-objects/blob/main/objects/parler-account/definition.json) - Parler account.
- [objects/parler-comment](https://github.com/MISP/misp-objects/blob/main/objects/parler-comment/definition.json) - Parler comment.
- [objects/parler-post](https://github.com/MISP/misp-objects/blob/main/objects/parler-post/definition.json) - Parler post (parley).
- [objects/passive-dns](https://github.com/MISP/misp-objects/blob/main/objects/passive-dns/definition.json) - Passive DNS records as expressed in draft-dulaunoy-dnsop-passive-dns-cof-01.
- [objects/paste](https://github.com/MISP/misp-objects/blob/main/objects/paste/definition.json) - Paste or similar post from a website allowing to share privately or publicly posts.
- [objects/pcap-metadata](https://github.com/MISP/misp-objects/blob/main/objects/pcap-metadata/definition.json) - Network packet capture metadata.
- [objects/pe](https://github.com/MISP/misp-objects/blob/main/objects/pe/definition.json) - Object describing a Portable Executable.
- [objects/pe-section](https://github.com/MISP/misp-objects/blob/main/objects/pe-section/definition.json) - Object describing a section of a Portable Executable.
- [objects/person](https://github.com/MISP/misp-objects/blob/main/objects/person/definition.json) - An object which describes a person or an identity.
- [objects/pgp-meta](https://github.com/MISP/misp-objects/blob/main/objects/pgp-meta/definition.json) - Metadata extracted from a PGP keyblock, message or signature.
- [objects/phishing](https://github.com/MISP/misp-objects/blob/main/objects/phishing/definition.json) - Phishing template to describe a phishing website and its analysis.
- [objects/phishing-kit](https://github.com/MISP/misp-objects/blob/main/objects/phishing-kit/definition.json) - Object to describe a phishing-kit.
- [objects/phone](https://github.com/MISP/misp-objects/blob/main/objects/phone/definition.json) - A phone or mobile phone object which describe a phone.
- [objects/process](https://github.com/MISP/misp-objects/blob/main/objects/process/definition.json) - Object describing a system process.
- [objects/publication](https://github.com/MISP/misp-objects/blob/main/objects/publication/definition.json) - An object to describe a book, journal, or academic publication.
- [objects/python-etvx-event-log](https://github.com/MISP/misp-objects/blob/main/objects/python-etvx-event-log/definition.json) - Event log object template to share information of the activities conducted on a system. .
- [objects/r2graphity](https://github.com/MISP/misp-objects/blob/main/objects/r2graphity/definition.json) - Indicators extracted from files using radare2 and graphml.
- [objects/reddit-account](https://github.com/MISP/misp-objects/blob/main/objects/reddit-account/definition.json) - Reddit account.
- [objects/reddit-comment](https://github.com/MISP/misp-objects/blob/main/objects/reddit-comment/definition.json) - A Reddit post comment.
- [objects/reddit-post](https://github.com/MISP/misp-objects/blob/main/objects/reddit-post/definition.json) - A Reddit post.
- [objects/reddit-subreddit](https://github.com/MISP/misp-objects/blob/main/objects/reddit-subreddit/definition.json) - Public or private subreddit.
- [objects/regexp](https://github.com/MISP/misp-objects/blob/main/objects/regexp/definition.json) - An object describing a regular expression (regex or regexp). The object can be linked via a relationship to other attributes or objects to describe how it can be represented as a regular expression.
- [objects/registry-key](https://github.com/MISP/misp-objects/blob/main/objects/registry-key/definition.json) - Registry key object describing a Windows registry key with value and last-modified timestamp.
- [objects/regripper-NTUser](https://github.com/MISP/misp-objects/blob/main/objects/regripper-NTUser/definition.json) - Regripper Object template designed to present user specific configuration details extracted from the NTUSER.dat hive.
- [objects/regripper-sam-hive-single-user](https://github.com/MISP/misp-objects/blob/main/objects/regripper-sam-hive-single-user/definition.json) - Regripper Object template designed to present user profile details extracted from the SAM hive.
- [objects/regripper-sam-hive-user-group](https://github.com/MISP/misp-objects/blob/main/objects/regripper-sam-hive-user-group/definition.json) - Regripper Object template designed to present group profile details extracted from the SAM hive.
- [objects/regripper-software-hive-BHO](https://github.com/MISP/misp-objects/blob/main/objects/regripper-software-hive-BHO/definition.json) - Regripper Object template designed to gather information of the browser helper objects installed on the system.
- [objects/regripper-software-hive-appInit-DLLS](https://github.com/MISP/misp-objects/blob/main/objects/regripper-software-hive-appInit-DLLS/definition.json) - Regripper Object template designed to gather information of the DLL files installed on the system.
- [objects/regripper-software-hive-application-paths](https://github.com/MISP/misp-objects/blob/main/objects/regripper-software-hive-application-paths/definition.json) - Regripper Object template designed to gather information of the application paths.
- [objects/regripper-software-hive-applications-installed](https://github.com/MISP/misp-objects/blob/main/objects/regripper-software-hive-applications-installed/definition.json) - Regripper Object template designed to gather information of the applications installed on the system.
- [objects/regripper-software-hive-command-shell](https://github.com/MISP/misp-objects/blob/main/objects/regripper-software-hive-command-shell/definition.json) - Regripper Object template designed to gather information of the shell commands executed on the system.
- [objects/regripper-software-hive-software-run](https://github.com/MISP/misp-objects/blob/main/objects/regripper-software-hive-software-run/definition.json) - Regripper Object template designed to gather information of the applications set to run on the system.
- [objects/regripper-software-hive-userprofile-winlogon](https://github.com/MISP/misp-objects/blob/main/objects/regripper-software-hive-userprofile-winlogon/definition.json) - Regripper Object template designed to gather user profile information when the user logs onto the system, gathered from the software hive.
- [objects/regripper-software-hive-windows-general-info](https://github.com/MISP/misp-objects/blob/main/objects/regripper-software-hive-windows-general-info/definition.json) - Regripper Object template designed to gather general windows information extracted from the software-hive.
- [objects/regripper-system-hive-firewall-configuration](https://github.com/MISP/misp-objects/blob/main/objects/regripper-system-hive-firewall-configuration/definition.json) - Regripper Object template designed to present firewall configuration information extracted from the system-hive.
- [objects/regripper-system-hive-general-configuration](https://github.com/MISP/misp-objects/blob/main/objects/regripper-system-hive-general-configuration/definition.json) - Regripper Object template designed to present general system properties extracted from the system-hive.
- [objects/regripper-system-hive-network-information](https://github.com/MISP/misp-objects/blob/main/objects/regripper-system-hive-network-information/definition.json) - Regripper object template designed to gather network information from the system-hive.
- [objects/regripper-system-hive-services-drivers](https://github.com/MISP/misp-objects/blob/main/objects/regripper-system-hive-services-drivers/definition.json) - Regripper Object template designed to gather information regarding the services/drivers from the system-hive.
- [objects/report](https://github.com/MISP/misp-objects/blob/main/objects/report/definition.json) - Metadata used to generate an executive level report.
- [objects/research-scanner](https://github.com/MISP/misp-objects/blob/main/objects/research-scanner/definition.json) - Information related to known scanning activity (e.g. from research projects).
- [objects/rogue-dns](https://github.com/MISP/misp-objects/blob/main/objects/rogue-dns/definition.json) - Rogue DNS as defined by CERT.br.
- [objects/rtir](https://github.com/MISP/misp-objects/blob/main/objects/rtir/definition.json) - RTIR - Request Tracker for Incident Response.
- [objects/sandbox-report](https://github.com/MISP/misp-objects/blob/main/objects/sandbox-report/definition.json) - Sandbox report.
- [objects/sb-signature](https://github.com/MISP/misp-objects/blob/main/objects/sb-signature/definition.json) - Sandbox detection signature.
- [objects/scheduled-event](https://github.com/MISP/misp-objects/blob/main/objects/scheduled-event/definition.json) - Event object template describing a gathering of individuals in meatspace.
- [objects/scrippsco2-c13-daily](https://github.com/MISP/misp-objects/blob/main/objects/scrippsco2-c13-daily/definition.json) - Daily average C13 concentrations (ppm) derived from flask air samples.
- [objects/scrippsco2-c13-monthly](https://github.com/MISP/misp-objects/blob/main/objects/scrippsco2-c13-monthly/definition.json) - Monthly average C13 concentrations (ppm) derived from flask air samples.
- [objects/scrippsco2-co2-daily](https://github.com/MISP/misp-objects/blob/main/objects/scrippsco2-co2-daily/definition.json) - Daily average CO2 concentrations (ppm) derived from flask air samples.
- [objects/scrippsco2-co2-monthly](https://github.com/MISP/misp-objects/blob/main/objects/scrippsco2-co2-monthly/definition.json) - Monthly average CO2 concentrations (ppm) derived from flask air samples.
- [objects/scrippsco2-o18-daily](https://github.com/MISP/misp-objects/blob/main/objects/scrippsco2-o18-daily/definition.json) - Daily average O18 concentrations (ppm) derived from flask air samples.
- [objects/scrippsco2-o18-monthly](https://github.com/MISP/misp-objects/blob/main/objects/scrippsco2-o18-monthly/definition.json) - Monthly average O18 concentrations (ppm) derived from flask air samples.
- [objects/script](https://github.com/MISP/misp-objects/blob/main/objects/script/definition.json) - Object describing a computer program written to be run in a special run-time environment. The script or shell script can be used for malicious activities but also as support tools for threat analysts.
- [objects/shell-commands](https://github.com/MISP/misp-objects/blob/main/objects/shell-commands/definition.json) - Object describing a series of shell commands executed. This object can be linked with malicious files in order to describe a specific execution of shell commands.
- [objects/shodan-report](https://github.com/MISP/misp-objects/blob/main/objects/shodan-report/definition.json) - Shodan Report for a given IP.
- [objects/short-message-service](https://github.com/MISP/misp-objects/blob/main/objects/short-message-service/definition.json) - Short Message Service (SMS) object template describing one or more SMS message. Restriction of the initial format 3GPP 23.038 GSM character set doesn't apply.
- [objects/shortened-link](https://github.com/MISP/misp-objects/blob/main/objects/shortened-link/definition.json) - Shortened link and its redirect target.
- [objects/social-media-group](https://github.com/MISP/misp-objects/blob/main/objects/social-media-group/definition.json) - Social media group object template describing a public or private group or channel.
- [objects/splunk](https://github.com/MISP/misp-objects/blob/main/objects/splunk/definition.json) - Splunk / Splunk ES object.
- [objects/ss7-attack](https://github.com/MISP/misp-objects/blob/main/objects/ss7-attack/definition.json) - SS7 object of an attack seen on a GSM, UMTS or LTE network via SS7 logging.
- [objects/ssh-authorized-keys](https://github.com/MISP/misp-objects/blob/main/objects/ssh-authorized-keys/definition.json) - An object to store ssh authorized keys file.
- [objects/stix2-pattern](https://github.com/MISP/misp-objects/blob/main/objects/stix2-pattern/definition.json) - An object describing a STIX pattern. The object can be linked via a relationship to other attributes or objects to describe how it can be represented as a STIX pattern.
- [objects/suricata](https://github.com/MISP/misp-objects/blob/main/objects/suricata/definition.json) - An object describing one or more Suricata rule(s) along with version and contextual information.
- [objects/target-system](https://github.com/MISP/misp-objects/blob/main/objects/target-system/definition.json) - Description about an targeted system, this could potentially be a compromissed internal system.
- [objects/threatgrid-report](https://github.com/MISP/misp-objects/blob/main/objects/threatgrid-report/definition.json) - ThreatGrid report.
- [objects/timecode](https://github.com/MISP/misp-objects/blob/main/objects/timecode/definition.json) - Timecode object to describe a start of video sequence (e.g. CCTV evidence) and the end of the video sequence.
- [objects/timesketch-timeline](https://github.com/MISP/misp-objects/blob/main/objects/timesketch-timeline/definition.json) - A timesketch timeline object based on mandatory field in timesketch to describe a log entry.
- [objects/timesketch_message](https://github.com/MISP/misp-objects/blob/main/objects/timesketch_message/definition.json) - A timesketch message entry.
- [objects/timestamp](https://github.com/MISP/misp-objects/blob/main/objects/timestamp/definition.json) - A generic timestamp object to represent time including first time and last time seen. Relationship will then define the kind of time relationship.
- [objects/tor-hiddenservice](https://github.com/MISP/misp-objects/blob/main/objects/tor-hiddenservice/definition.json) - Tor hidden service (onion service) object.
- [objects/tor-node](https://github.com/MISP/misp-objects/blob/main/objects/tor-node/definition.json) - Tor node (which protects your privacy on the internet by hiding the connection between users Internet address and the services used by the users) description which are part of the Tor network at a time.
- [objects/tracking-id](https://github.com/MISP/misp-objects/blob/main/objects/tracking-id/definition.json) - Analytics and tracking ID such as used in Google Analytics or other analytic platform.
- [objects/transaction](https://github.com/MISP/misp-objects/blob/main/objects/transaction/definition.json) - An object to describe a financial transaction.
- [objects/translation](https://github.com/MISP/misp-objects/blob/main/objects/translation/definition.json) - Used to keep a text and its translation.
- [objects/trustar_report](https://github.com/MISP/misp-objects/blob/main/objects/trustar_report/definition.json) - TruStar Report.
- [objects/tsk-chats](https://github.com/MISP/misp-objects/blob/main/objects/tsk-chats/definition.json) - An Object Template to gather information from evidential or interesting exchange of messages identified during a digital forensic investigation.
- [objects/tsk-web-bookmark](https://github.com/MISP/misp-objects/blob/main/objects/tsk-web-bookmark/definition.json) - An Object Template to add evidential bookmarks identified during a digital forensic investigation.
- [objects/tsk-web-cookie](https://github.com/MISP/misp-objects/blob/main/objects/tsk-web-cookie/definition.json) - An TSK-Autopsy Object Template to represent cookies identified during a forensic investigation.
- [objects/tsk-web-downloads](https://github.com/MISP/misp-objects/blob/main/objects/tsk-web-downloads/definition.json) - An Object Template to add web-downloads.
- [objects/tsk-web-history](https://github.com/MISP/misp-objects/blob/main/objects/tsk-web-history/definition.json) - An Object Template to share web history information.
- [objects/tsk-web-search-query](https://github.com/MISP/misp-objects/blob/main/objects/tsk-web-search-query/definition.json) - An Object Template to share web search query information.
- [objects/twitter-account](https://github.com/MISP/misp-objects/blob/main/objects/twitter-account/definition.json) - Twitter account.
- [objects/twitter-list](https://github.com/MISP/misp-objects/blob/main/objects/twitter-list/definition.json) - Twitter list.
- [objects/twitter-post](https://github.com/MISP/misp-objects/blob/main/objects/twitter-post/definition.json) - Twitter post (tweet).
- [objects/url](https://github.com/MISP/misp-objects/blob/main/objects/url/definition.json) - url object describes an url along with its normalized field (like extracted using faup parsing library) and its metadata.
- [objects/user-account](https://github.com/MISP/misp-objects/blob/main/objects/user-account/definition.json) - .
- [objects/vehicle](https://github.com/MISP/misp-objects/blob/main/objects/vehicle/definition.json) - Vehicle object template to describe a vehicle information and registration.
- [objects/victim](https://github.com/MISP/misp-objects/blob/main/objects/victim/definition.json) - Victim object describes the target of an attack or abuse.
- [objects/virustotal-graph](https://github.com/MISP/misp-objects/blob/main/objects/virustotal-graph/definition.json) - VirusTotal graph.
- [objects/virustotal-report](https://github.com/MISP/misp-objects/blob/main/objects/virustotal-report/definition.json) - VirusTotal report.
- [objects/vulnerability](https://github.com/MISP/misp-objects/blob/main/objects/vulnerability/definition.json) - Vulnerability object describing a common vulnerability enumeration which can describe published, unpublished, under review or embargo vulnerability for software, equipments or hardware.
- [objects/weakness](https://github.com/MISP/misp-objects/blob/main/objects/weakness/definition.json) - Weakness object describing a common weakness enumeration which can describe usable, incomplete, draft or deprecated weakness for software, equipment of hardware.
- [objects/whois](https://github.com/MISP/misp-objects/blob/main/objects/whois/definition.json) - Whois records information for a domain name or an IP address.
- [objects/x509](https://github.com/MISP/misp-objects/blob/main/objects/x509/definition.json) - x509 object describing a X.509 certificate.
- [objects/yabin](https://github.com/MISP/misp-objects/blob/main/objects/yabin/definition.json) - yabin.py generates Yara rules from function prologs, for matching and hunting binaries. ref: https://github.com/AlienVault-OTX/yabin.
- [objects/yara](https://github.com/MISP/misp-objects/blob/main/objects/yara/definition.json) - An object describing a YARA rule (or a YARA rule name) along with its version.
- [objects/youtube-channel](https://github.com/MISP/misp-objects/blob/main/objects/youtube-channel/definition.json) - A YouTube channel.
- [objects/youtube-comment](https://github.com/MISP/misp-objects/blob/main/objects/youtube-comment/definition.json) - A YouTube video comment.
- [objects/youtube-playlist](https://github.com/MISP/misp-objects/blob/main/objects/youtube-playlist/definition.json) - A YouTube playlist.
- [objects/youtube-video](https://github.com/MISP/misp-objects/blob/main/objects/youtube-video/definition.json) - A YouTube video.


# Acknowledgements

The authors wish to thank all the MISP community who are supporting the creation
of open standards in threat intelligence sharing.

<reference anchor='MISP-P' target='https://github.com/MISP'>
  <front>
   <title>MISP Project - Malware Information Sharing Platform and Threat Sharing</title>
   <author initials='' surname='MISP' fullname='MISP Community'></author>
   <date></date>
  </front>
</reference>

<reference anchor='MISP-O' target='https://github.com/MISP/misp-objects'>
  <front>
   <title>MISP Objects - shared and common object templates</title>
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

<reference anchor='MISP-O-DOC' target='https://www.misp-project.org/objects.html'>
   <front>
     <title>MISP objects directory</title>
     <author initials='' surname='' fullname='MISP community'></author>
     <date year="2018"></date>
   </front>
</reference>


{backmatter}
