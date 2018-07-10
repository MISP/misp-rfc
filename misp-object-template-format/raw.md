% Title = "MISP object template format"
% abbrev = "MISP object template format"
% category = "info"
% docName = "draft-dulaunoy-misp-object-template-format"
% ipr= "trust200902"
% area = "Security"
%
% date = 2018-04-10T00:00:00Z
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

The MISP object template format uses the JSON [@!RFC4627] format. Each template is represented as a JSON object with meta information including the following fields: uuid, requiredOneOf, description, version, meta-category, name.

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

A relationships directory is also included, containing a definition.json file which contains a list of MISP object relation definitions

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


{backmatter}
