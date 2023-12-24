%%%
Title = "MISP taxonomy format"
abbrev = "MISP taxonomy format"
category = "info"
docName = "draft-dulaunoy-misp-taxonomy-format"
ipr= "trust200902"
area = "Security"
submissiontype = "independent"

[seriesInfo]
name = "Internet-Draft"
value = "draft-08"
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
initials="A."
surname="Iklody"
fullname="Andras Iklody"
abbrev="CIRCL"
organization = "Computer Incident Response Center Luxembourg"
 [author.address]
 email = "andras.iklody@circl.lu"
 phone = "+352 247 88444"
  [author.address.postal]
  street = "122, rue Adolphe Fischer"
  city = "Luxembourg"
  code = "L-1521"
  country = "Luxembourg"
%%%

.# Abstract

This document describes the MISP taxonomy format which describes a simple JSON format to
represent machine tags (also called triple tags) vocabularies. A public directory of common vocabularies
called MISP taxonomies is available and relies on the MISP taxonomy format. MISP taxonomies are used to classify
cyber security events, threats, suspicious events, or indicators.

{mainmatter}

# Introduction

Sharing threat information became a fundamental requirements on the Internet, security and intelligence community at large. Threat
information can include indicators of compromise, malicious file indicators, financial fraud indicators
or even detailed information about a threat actor. While sharing such indicators or information, classification plays an important role
to ensure adequate distribution, understanding, validation or action of the shared information. MISP taxonomies is a public repository
of known vocabularies that can be used in threat information sharing.

Machine tags were introduced in 2007 [@?machine-tags] to allow users to be more precise when tagging their pictures with geolocation.
So a machine tag is a tag which uses a special syntax to provide more information to users and machines. Machine tags are also known
as triple tags due to their format.

In the MISP taxonomy context, machine tags help analysts to classify their cybersecurity events, indicators or threats. MISP taxonomies can be used for classification, filtering, triggering actions or visualisation depending on their use in threat intelligence platforms such as MISP [@?MISP-P].

##  Conventions and Terminology

The key words "**MUST**", "**MUST NOT**", "**REQUIRED**", "**SHALL**", "**SHALL NOT**",
"**SHOULD**", "**SHOULD NOT**", "**RECOMMENDED**", "**MAY**", and "**OPTIONAL**" in this
document are to be interpreted as described in RFC 2119 [@!RFC2119].

# Format

A machine tag is composed of a namespace (**MUST**), a predicate (**MUST**) and an optional value (**OPTIONAL**).

Machine tags are represented as a string. Below listed are a set of sample machine tags for different namespaces such as tlp, admiralty-scale and osint.

~~~~
tlp:amber
admiralty-scale:information-credibility="1"
osint:source-type="blog-post"
~~~~

The MISP taxonomy format describes how to define a machine tag namespace in a parseable format. The objective is to provide a simple format
to describe machine tag (aka triple tag) vocabularies.

## Overview

The MISP taxonomy format uses the JSON [@!RFC8259] format. Each namespace is represented as a JSON object with meta information including the following fields: namespace, description, version, type.

namespace defines the overall namespace of the machine tag. The namespace is represented as a string and **MUST** be present. The description is represented as a string and **MUST** be present. A version is represented as a unsigned integer **MUST** be present. A type defines where a specific taxonomy is applicable and a type can be applicable at event, user or org level. The type is represented as an array containing one or more type and **SHOULD** be present. If a type is not mentioned, by default, the taxonomy is applicable at event level only. An exclusive boolean property **MAY** be present and defines at namespace level if the predicates are mutually exclusive.

predicates defines all the predicates available in the namespace defined. predicates is represented as an array of JSON objects. predicates **MUST** be present and **MUST** at least content one element.

values defines all the values for each predicate in the namespace defined. values **SHOULD** be present.

## predicates

The predicates array contains one or more JSON objects which lists all the possible predicates. The JSON object contains two fields: value and expanded. value **MUST** be present. expanded **SHOULD** be present. value is represented as a string and describes the predicate value. The predicate value **MUST** not contain spaces or colons. expanded is represented as a string and describes the human-readable version of the predicate value. An exclusive property **MAY** be present and defines at namespace level if the values are mutually exclusive.

## values

The values array contain one or more JSON objects which lists all the possible values of a predicate. The JSON object contains two fields: predicate and entry. predicate is represented as a string and describes the predicate value. entry is an array with one or more JSON objects. The JSON object contains two fields: value and expanded. value **MUST** be present. expanded **SHOULD** be present. value is represented as a string and describes the machine parsable value. expanded is represented as a string and describes the human-readable version of the value.

## optional fields

### colour

colour fields **MAY** be used at predicates or values level to set a specify colour that **MAY** be used by the implementation. The colour field is described as an RGB colour fill in hexadecimal representation.

Example use of the colour field in the Traffic Light Protocol (TLP):

~~~~
"predicates": [
    {
      "colour": "#CC0033",
      "expanded": "(TLP:RED) Information exclusively and directly
                   given to (a group of) individual recipients.
                   Sharing outside is not legitimate.",
      "value": "red"
    },
    {
      "colour": "#FFC000",
      "expanded": "(TLP:AMBER) Information exclusively given
                   to an organization; sharing limited within
                   the organization to be effectively acted upon.",
      "value": "amber"
    }...]
~~~~

### description

description fields **MAY** be used at predicates or values level to add a descriptive and human-readable information about the specific predicate or value. The field is represented as a string. Implementations **MAY** use the description field to improve more contextual information. The description at the namespace level is a **MUST** as described above.

### numerical_value

numerical_value fields **MAY** be used at a predicate or value level to add a machine-readable numeric value to a specific predicate or value.
The field is represented as a JSON number. Implementations **SHOULD** use the decimal value provided to support scoring or filtering.

The decimal range for numerical_value **SHOULD** use a range from 0 up to 100. The range is recommended to support common mathematical properties
among taxonomies.

Example use of the numerical_value in the MISP confidence level:

~~~~
    {
     "predicate": "confidence-level",
     "entry": [
        {
          "expanded": "Completely confident",
          "value": "completely-confident",
          "numerical_value": 100
        },
        {
          "expanded": "Usually confident",
          "value": "usually-confident",
          "numerical_value": 75
        },
        {
          "expanded": "Fairly confident",
          "value": "fairly-confident",
          "numerical_value": 50
        },
        {
          "expanded": "Rarely confident",
          "value": "rarely-confident",
          "numerical_value": 25
        },
        {
          "expanded": "Unconfident",
          "value": "unconfident",
          "numerical_value": 0
        },
        {
          "expanded": "Confidence cannot be evaluated",
          "value": "confidence-cannot-be-evalued"
        }
     ]
     }
~~~~


# Directory

The MISP taxonomies directory is publicly available [@?MISP-T] in a git repository. The repository
contains a directory per namespace then a file machinetag.json which contains the taxonomy as
described in the format above. In the root of the repository, a MANIFEST.json exists containing
a list of all the taxonomies.

The MANIFEST.json file is composed of an JSON object with metadata like version, license, description, url and path.
A taxonomies array describes the taxonomy available with the description, name and version field.

## Sample Manifest
~~~~
{
  "version": "20161009",
  "license": "CC-0",
  "description": "Manifest file of MISP taxonomies available.",
  "url":
    "https://raw.githubusercontent.com/MISP/misp-taxonomies/master/",
  "path": "machinetag.json",
  "taxonomies": [
    {
      "description": "The Admiralty Scale (also called the NATO System)
                      is used to rank the reliability of a source and
                      the credibility of an information.",
      "name": "admiralty-scale",
      "version": 1
    },
    {
      "description": "Open Source Intelligence - Classification.",
      "name": "osint",
      "version": 2
    }]
}
~~~~

# Sample Taxonomy in MISP taxonomy format

## Admiralty Scale Taxonomy

~~~~
  "namespace": "admiralty-scale",
  "description": "The Admiralty Scale (also called the NATO System)
                  is used to rank the reliability of a source and
                  the credibility of an information.",
  "version": 1,
  "predicates": [
    {
      "value": "source-reliability",
      "expanded": "Source Reliability"
    },
    {
      "value": "information-credibility",
      "expanded": "Information Credibility"
    }
  ],
  "values": [
    {
      "predicate": "source-reliability",
      "entry": [
        {
          "value": "a",
          "expanded": "Completely reliable"
        },
        {
          "value": "b",
          "expanded": "Usually reliable"
        },
        {
          "value": "c",
          "expanded": "Fairly reliable"
        },
        {
          "value": "d",
          "expanded": "Not usually reliable"
        },
        {
          "value": "e",
          "expanded": "Unreliable"
        },
        {
          "value": "f",
          "expanded": "Reliability cannot be judged"
        }
      ]
    },
    {
      "predicate": "information-credibility",
      "entry": [
        {
          "value": "1",
          "expanded": "Confirmed by other sources"
        },
        {
          "value": "2",
          "expanded": "Probably true"
        },
        {
          "value": "3",
          "expanded": "Possibly true"
        },
        {
          "value": "4",
          "expanded": "Doubtful"
        },
        {
          "value": "5",
          "expanded": "Improbable"
        },
        {
          "value": "6",
          "expanded": "Truth cannot be judged"
        }
      ]
    }
  ]
}
~~~~

## Open Source Intelligence - Classification

~~~~
{
  "values": [
    {
      "entry": [
        {
          "expanded": "Blog post",
          "value": "blog-post"
        },
        {
          "expanded": "Technical or analysis report",
          "value": "technical-report"
        },
        {
          "expanded": "News report",
          "value": "news-report"
        },
        {
          "expanded": "Pastie-like website",
          "value": "pastie-website"
        },
        {
          "expanded": "Electronic forum",
          "value": "electronic-forum"
        },
        {
          "expanded": "Mailing-list",
          "value": "mailing-list"
        },
        {
          "expanded": "Block or Filter List",
          "value": "block-or-filter-list"
        },
        {
          "expanded": "Expansion",
          "value": "expansion"
        }
      ],
      "predicate": "source-type"
    },
    {
      "predicate": "lifetime",
      "entry": [
        {
          "value": "perpetual",
          "expanded": "Perpetual",
          "description": "Information available publicly on long-term"
        },
        {
          "value": "ephemeral",
          "expanded": "Ephemeral",
          "description": "Information available publicly on short-term"
        }
      ]
    },
    {
      "predicate": "certainty",
      "entry": [
        {
          "numerical_value": 100,
          "value": "100",
          "expanded": "100% Certainty",
          "description": "100% Certainty"
        },
        {
          "numerical_value": 93,
          "value": "93",
          "expanded": "93% Almost certain",
          "description": "93% Almost certain"
        },
        {
          "numerical_value": 75,
          "value": "75",
          "expanded": "75% Probable",
          "description": "75% Probable"
        },
        {
          "numerical_value": 50,
          "value": "50",
          "expanded": "50% Chances about even",
          "description": "50% Chances about even"
        },
        {
          "numerical_value": 30,
          "value": "30",
          "expanded": "30% Probably not",
          "description": "30% Probably not"
        },
        {
          "numerical_value": 7,
          "value": "7",
          "expanded": "7% Almost certainly not",
          "description": "7% Almost certainly not"
        },
        {
          "numerical_value": 0,
          "value": "0",
          "expanded": "0% Impossibility",
          "description": "0% Impossibility"
        }
      ]
    }
  ],
  "namespace": "osint",
  "description": "Open Source Intelligence - Classification",
  "version": 3,
  "predicates": [
    {
      "value": "source-type",
      "expanded": "Source Type"
    },
    {
      "value": "lifetime",
      "expanded": "Lifetime of the information
                   as Open Source Intelligence"
    },
    {
      "value": "certainty",
      "expanded": "Certainty of the elements mentioned
                   in this Open Source Intelligence"
    }
  ]
}

~~~~

## Available taxonomies in the public directory

The public directory of MISP taxonomies [@?MISP-T] contains a variety of taxonomy in various fields such as:

CERT-XLM:
:   CERT-XLM Security Incident Classification.

DFRLab-dichotomies-of-disinformation:
:   DFRLab Dichotomies of Disinformation.

DML:
:   The Detection Maturity Level (DML) model is a capability maturity model for referencing ones maturity in detecting cyber attacks.  It's designed for organizations who perform intel-driven detection and response and who put an emphasis on having a mature detection program.

GrayZone:
:   Gray Zone of Active defense includes all elements which lay between reactive defense elements and offensive operations. It does fill the gray spot between them. Taxo may be used for active defense planning or modeling.

PAP:
:   The Permissible Actions Protocol - or short: PAP - was designed to indicate how the received information can be used.

access-method:
:   The access method used to remotely access a system.

accessnow:
:   Access Now classification to classify an issue (such as security, human rights, youth rights).

action-taken:
:   Action taken in the case of a security incident (CSIRT perspective).

admiralty-scale:
:   The Admiralty Scale or Ranking (also called the NATO System) is used to rank the reliability of a source and the credibility of an information. Reference based on FM 2-22.3 (FM 34-52) HUMAN INTELLIGENCE COLLECTOR OPERATIONS and NATO documents.

adversary:
:   An overview and description of the adversary infrastructure

ais-marking:
:   The AIS Marking Schema implementation is maintained by the National Cybersecurity and Communication Integration Center (NCCIC) of the U.S. Department of Homeland Security (DHS)

analyst-assessment:
:   A series of assessment predicates describing the analyst capabilities to perform analysis. These assessment can be assigned by the analyst him/herself or by another party evaluating the analyst.

approved-category-of-action:
:   A pre-approved category of action for indicators being shared with partners (MIMIC).

artificial-satellites:
:   This taxonomy was designed to describe artificial satellites

aviation:
:   A taxonomy describing security threats or incidents against the aviation sector.

binary-class:
:   Custom taxonomy for types of binary file.

cccs:
:   Internal taxonomy for CCCS.

circl:
:   CIRCL Taxonomy - Schemes of Classification in Incident Response and Detection.

cnsd:
:   La presente taxonomia es la primera versión disponible para el Centro Nacional de Seguridad Digital del Perú.

coa:
:   Course of action taken within organization to discover, detect, deny, disrupt, degrade, deceive and/or destroy an attack.

collaborative-intelligence:
:   Collaborative intelligence support language is a common language to support analysts to perform their analysis to get crowdsourced support when using threat intelligence sharing platform like MISP. The objective of this language is to advance collaborative analysis and to share earlier than later.

common-taxonomy:
:   Common Taxonomy for Law enforcement and CSIRTs

copine-scale:
:   The COPINE Scale is a rating system created in Ireland and used in the United Kingdom to categorise the severity of images of child sex abuse. The scale was developed by staff at the COPINE (Combating Paedophile Information Networks in Europe) project. The COPINE Project was founded in 1997, and is based in the Department of Applied Psychology, University College Cork, Ireland.

course-of-action:
:   A Course Of Action analysis considers six potential courses of action for the development of a cyber security capability.

crowdsec:
:   Crowdsec IP address classifications and behaviors taxonomy.

cryptocurrency-threat:
:   Threats targetting cryptocurrency, based on CipherTrace report.

csirt-americas:
:   Taxonomía CSIRT Américas.

csirt_case_classification:
:   It is critical that the CSIRT provide consistent and timely response to the customer, and that sensitive information is handled appropriately.  This document provides the guidelines needed for CSIRT Incident Managers (IM) to classify the case category, criticality level, and sensitivity level for each CSIRT case.  This information will be entered into the Incident Tracking System (ITS) when a case is created.  Consistent case classification is required for the CSIRT to provide accurate reporting to management on a regular basis.  In addition, the classifications will provide CSIRT IM’s with proper case handling procedures and will form the basis of SLA’s between the CSIRT and other Company departments.

cssa:
:   The CSSA agreed sharing taxonomy.

cti:
:   Cyber Threat Intelligence cycle to control workflow state of your process.

current-event:
:   Current events - Schemes of Classification in Incident Response and Detection

cyber-threat-framework:
:   Cyber Threat Framework was developed by the US Government to enable consistent characterization and categorization of cyber threat events, and to identify trends or changes in the activities of cyber adversaries. https://www.dni.gov/index.php/cyber-threat-framework

cycat:
:   Taxonomy used by CyCAT, the Universal Cybersecurity Resource Catalogue, to categorize the namespaces it supports and uses.

cytomic-orion:
:   Taxonomy to describe desired actions for Cytomic Orion

dark-web:
:   Criminal motivation and content detection the dark web: A categorisation model for law enforcement. ref: Janis Dalins, Campbell Wilson, Mark Carman. Taxonomy updated by MISP Project and extended by the JRC (Joint Research Centre) of the European Commission.

data-classification:
:   Data classification for data potentially at risk of exfiltration based on table 2.1 of Solving Cyber Risk book.

dcso-sharing:
:   Taxonomy defined in the DCSO MISP Event Guide. It provides guidance for the creation and consumption of MISP events in a way that minimises the extra effort for the sending party, while enhancing the usefulness for receiving parties.

ddos:
:   Distributed Denial of Service - or short: DDoS - taxonomy supports the description of Denial of Service attacks and especially the types they belong too.

de-vs:
:   German (DE) Government classification markings (VS).

death-possibilities:
:   Taxonomy of Death Possibilities

deception:
:   Deception is an important component of information operations, valuable for both offense and defense. 

dga:
:   A taxonomy to describe domain-generation algorithms often called DGA. Ref: A Comprehensive Measurement Study of Domain Generating Malware Daniel Plohmann and others.

dhs-ciip-sectors:
:   DHS critical sectors as in https://www.dhs.gov/critical-infrastructure-sectors

diamond-model:
:   The Diamond Model for Intrusion Analysis establishes the basic atomic element of any intrusion activity, the event, composed of four core features: adversary, infrastructure, capability, and victim.

diamond-model-for-influence-operations:
:   The diamond model for influence operations analysis is a framework that leads analysts and researchers toward a comprehensive understanding of a malign influence campaign by addressing the socio-political, technical, and psychological aspects of the campaign. The diamond model for influence operations analysis consists of 5 components: 4 corners and a core element. The 4 corners are divided into 2 axes: influencer and audience on the socio-political axis, capabilities and infrastructure on the technical axis. Narrative makes up the core of the diamond.

dni-ism:
:   A subset of Information Security Marking Metadata ISM as required by Executive Order (EO) 13526. As described by DNI.gov as Data Encoding Specifications for Information Security Marking Metadata in Controlled Vocabulary Enumeration Values for ISM

domain-abuse:
:   Domain Name Abuse - taxonomy to tag domain names used for cybercrime.

doping-substances:
:   This taxonomy aims to list doping substances

drugs:
:   A taxonomy based on the superclass and class of drugs. Based on https://www.drugbank.ca/releases/latest

economical-impact:
:   Economical impact is a taxonomy to describe the financial impact as positive or negative gain to the tagged information (e.g. data exfiltration loss, a positive gain for an adversary).

ecsirt:
:   Incident Classification by the ecsirt.net version mkVI of 31 March 2015 enriched with IntelMQ taxonomy-type mapping.

enisa:
:   The present threat taxonomy is an initial version that has been developed on the basis of available ENISA material. This material has been used as an ENISA-internal structuring aid for information collection and threat consolidation purposes. It emerged in the time period 2012-2015.

estimative-language:
:   Estimative language to describe quality and credibility of underlying sources, data, and methodologies based Intelligence Community Directive 203 (ICD 203) and JP 2-0, Joint Intelligence

eu-marketop-and-publicadmin:
:   Market operators and public administrations that must comply to some notifications requirements under EU NIS directive

eu-nis-sector-and-subsectors:
:   Sectors, subsectors, and digital services as identified by the NIS Directive

euci:
:   EU classified information (EUCI) means any information or material designated by a EU security classification, the unauthorised disclosure of which could cause varying degrees of prejudice to the interests of the European Union or of one or more of the Member States.

europol-event:
:   This taxonomy was designed to describe the type of events

europol-incident:
:   This taxonomy was designed to describe the type of incidents by class.

event-assessment:
:   A series of assessment predicates describing the event assessment performed to make judgement(s) under a certain level of uncertainty.

event-classification:
:   Classification of events as seen in tools such as RT/IR, MISP and other

exercise:
:   Exercise is a taxonomy to describe if the information is part of one or more cyber or crisis exercise.

extended-event:
:   Reasons why an event has been extended. This taxonomy must be used on the extended event. The competitive analysis aspect is from Psychology of Intelligence Analysis by Richard J. Heuer, Jr. ref:http://www.foo.be/docs/intelligence/PsychofIntelNew.pdf

failure-mode-in-machine-learning:
:   The purpose of this taxonomy is to jointly tabulate both the of these failure modes in a single place. Intentional failures wherein the failure is caused by an active adversary attempting to subvert the system to attain her goals – either to misclassify the result, infer private training data, or to steal the underlying algorithm. Unintentional failures wherein the failure is because an ML system produces a formally correct but completely unsafe outcome.

false-positive:
:   This taxonomy aims to ballpark the expected amount of false positives.

file-type:
:   List of known file types.

financial:
:   Financial taxonomy to describe financial services, infrastructure and financial scope.

flesch-reading-ease:
:   Flesch Reading Ease is a revised system for determining the comprehension difficulty of written material. The scoring of the flesh score can have a maximum of 121.22 and there is no limit on how low a score can be (negative score are valid).

fpf:
:   The Future of Privacy Forum (FPF) [visual guide to practical de-identification](https://fpf.org/2016/04/25/a-visual-guide-to-practical-data-de-identification/) taxonomy is used to evaluate the degree of identifiability of personal data and the types of pseudonymous data, de-identified data and anonymous data. The work of FPF is licensed under a creative commons attribution 4.0 international license.

fr-classif:
:   French gov information classification system

gdpr:
:   Taxonomy related to the REGULATION (EU) 2016/679 OF THE EUROPEAN PARLIAMENT AND OF THE COUNCIL on the protection of natural persons with regard to the processing of personal data and on the free movement of such data, and repealing Directive 95/46/EC (General Data Protection Regulation)

gea-nz-activities:
:   Information needed to track or monitor moments, periods or events that occur over time. This type of information is focused on occurrences that must be tracked for business reasons or represent a specific point in the evolution of ‘The Business’.

gea-nz-entities:
:   Information relating to instances of entities or things.

gea-nz-motivators:
:   Information relating to authority or governance.

gsma-attack-category:
:   Taxonomy used by GSMA for their information sharing program with telco describing the attack categories

gsma-fraud:
:   Taxonomy used by GSMA for their information sharing program with telco describing the various aspects of fraud

gsma-network-technology:
:   Taxonomy used by GSMA for their information sharing program with telco describing the types of infrastructure. WiP

honeypot-basic:
:   Updated (CIRCL, Seamus Dowling and EURECOM) from Christian Seifert, Ian Welch, Peter Komisarczuk, ‘Taxonomy of Honeypots’, Technical Report CS-TR-06/12, VICTORIA UNIVERSITY OF WELLINGTON, School of Mathematical and Computing Sciences, June 2006, http://www.mcs.vuw.ac.nz/comp/Publications/archive/CS-TR-06/CS-TR-06-12.pdf

ics:
:   FIRST.ORG CTI SIG - MISP Proposal for ICS/OT Threat Attribution (IOC) Project

iep:
:   Forum of Incident Response and Security Teams (FIRST) Information Exchange Policy (IEP) framework

iep2-policy:
:   Forum of Incident Response and Security Teams (FIRST) Information Exchange Policy (IEP) v2.0 Policy

iep2-reference:
:   Forum of Incident Response and Security Teams (FIRST) Information Exchange Policy (IEP) v2.0 Reference

ifx-vetting:
:   The IFX taxonomy is used to categorise information (MISP events and attributes) to aid in the intelligence vetting process

incident-disposition:
:   How an incident is classified in its process to be resolved. The taxonomy is inspired from NASA Incident Response and Management Handbook. https://www.nasa.gov/pdf/589502main_ITS-HBK-2810.09-02%20%5bNASA%20Information%20Security%20Incident%20Management%5d.pdf#page=9

infoleak:
:   A taxonomy describing information leaks and especially information classified as being potentially leaked. The taxonomy is based on the work by CIRCL on the AIL framework. The taxonomy aim is to be used at large to improve classification of leaked information.

information-origin:
:   Taxonomy for tagging information by its origin: human-generated or AI-generated.

information-security-data-source:
:   Taxonomy to classify the information security data sources.

information-security-indicators:
:   A full set of operational indicators for organizations to use to benchmark their security posture.

interactive-cyber-training-audience:
:   Describes the target of cyber training and education.

interactive-cyber-training-technical-setup:
:   The technical setup consists of environment structure, deployment, and orchestration.

interactive-cyber-training-training-environment:
:   The training environment details the environment around the training, consisting of training type and scenario.

interactive-cyber-training-training-setup:
:   The training setup further describes the training itself with the scoring, roles, the training mode as well as the customization level.

interception-method:
:   The interception method used to intercept traffic.

ioc:
:   An IOC classification to facilitate automation of malicious and non malicious artifacts

iot:
:   Internet of Things taxonomy, based on IOT UK report https://iotuk.org.uk/wp-content/uploads/2017/01/IOT-Taxonomy-Report.pdf

kill-chain:
:   The Cyber Kill Chain, a phase-based model developed by Lockheed Martin, aims to help categorise and identify the stage of an attack.

maec-delivery-vectors:
:   Vectors used to deliver malware based on MAEC 5.0

maec-malware-behavior:
:   Malware behaviours based on MAEC 5.0

maec-malware-capabilities:
:   Malware Capabilities based on MAEC 5.0

maec-malware-obfuscation-methods:
:   Obfuscation methods used by malware based on MAEC 5.0

malware_classification:
:   Classification based on different categories. Based on https://www.sans.org/reading-room/whitepapers/incident/malware-101-viruses-32848

misinformation-website-label:
:   classification for the identification of type of misinformation among websites. Source:False, Misleading, Clickbait-y, and/or Satirical News Sources by Melissa Zimdars 2019

misp:
:   MISP taxonomy to infer with MISP behavior or operation.

misp-workflow:
:   MISP workflow taxonomy to support result of workflow execution.

monarc-threat:
:   MONARC Threats Taxonomy

ms-caro-malware:
:   Malware Type and Platform classification based on Microsoft's implementation of the Computer Antivirus Research Organization (CARO) Naming Scheme and Malware Terminology. Based on https://www.microsoft.com/en-us/security/portal/mmpc/shared/malwarenaming.aspx, https://www.microsoft.com/security/portal/mmpc/shared/glossary.aspx, https://www.microsoft.com/security/portal/mmpc/shared/objectivecriteria.aspx, and http://www.caro.org/definitions/index.html. Malware families are extracted from Microsoft SIRs since 2008 based on https://www.microsoft.com/security/sir/archive/default.aspx and https://www.microsoft.com/en-us/security/portal/threat/threats.aspx. Note that SIRs do NOT include all Microsoft malware families.

ms-caro-malware-full:
:   Malware Type and Platform classification based on Microsoft's implementation of the Computer Antivirus Research Organization (CARO) Naming Scheme and Malware Terminology. Based on https://www.microsoft.com/en-us/security/portal/mmpc/shared/malwarenaming.aspx, https://www.microsoft.com/security/portal/mmpc/shared/glossary.aspx, https://www.microsoft.com/security/portal/mmpc/shared/objectivecriteria.aspx, and http://www.caro.org/definitions/index.html. Malware families are extracted from Microsoft SIRs since 2008 based on https://www.microsoft.com/security/sir/archive/default.aspx and https://www.microsoft.com/en-us/security/portal/threat/threats.aspx. Note that SIRs do NOT include all Microsoft malware families.

mwdb:
:   Malware Database (mwdb) Taxonomy - Tags used across the platform

nato:
:   NATO classification markings.

nis:
:   The taxonomy is meant for large scale cybersecurity incidents, as mentioned in the Commission Recommendation of 13 September 2017, also known as the blueprint. It has two core parts: The nature of the incident, i.e. the underlying cause, that triggered the incident, and the impact of the incident, i.e. the impact on services, in which sector(s) of economy and society.

nis2:
:   The taxonomy is meant for large scale cybersecurity incidents, as mentioned in the Commission Recommendation of 13 May 2022, also known as the provisional agreement. It has two core parts: The nature of the incident, i.e. the underlying cause, that triggered the incident, and the impact of the incident, i.e. the impact on services, in which sector(s) of economy and society.

open_threat:
:   Open Threat Taxonomy v1.1 base on James Tarala of SANS http://www.auditscripts.com/resources/open_threat_taxonomy_v1.1a.pdf, https://files.sans.org/summit/Threat_Hunting_Incident_Response_Summit_2016/PDFs/Using-Open-Tools-to-Convert-Threat-Intelligence-into-Practical-Defenses-James-Tarala-SANS-Institute.pdf, https://www.youtube.com/watch?v=5rdGOOFC_yE, and https://www.rsaconference.com/writable/presentations/file_upload/str-r04_using-an-open-source-threat-model-for-prioritized-defense-final.pdf

osint:
:   Open Source Intelligence - Classification (MISP taxonomies)

pandemic:
:   Pandemic

passivetotal:
:   Tags from RiskIQ's PassiveTotal service

pentest:
:   Penetration test (pentest) classification.

phishing:
:   Taxonomy to classify phishing attacks including techniques, collection mechanisms and analysis status.

poison-taxonomy:
:   Non-exhaustive taxonomy of natural poison

political-spectrum:
:   A political spectrum is a system to characterize and classify different political positions in relation to one another.

priority-level:
:   After an incident is scored, it is assigned a priority level. The six levels listed below are aligned with NCCIC, DHS, and the CISS to help provide a common lexicon when discussing incidents. This priority assignment drives NCCIC urgency, pre-approved incident response offerings, reporting requirements, and recommendations for leadership escalation. Generally, incident priority distribution should follow a similar pattern to the graph below. Based on https://www.us-cert.gov/NCCIC-Cyber-Incident-Scoring-System.

pyoti:
:   PyOTI automated enrichment schemes for point in time classification of indicators.

ransomware:
:   Ransomware is used to define ransomware types and the elements that compose them.

ransomware-roles:
:   The seven roles seen in most ransomware incidents.

retention:
:   Add a retenion time to events to automatically remove the IDS-flag on ip-dst or ip-src attributes. We calculate the time elapsed based on the date of the event. Supported time units are: d(ays), w(eeks), m(onths), y(ears). The numerical_value is just for sorting in the web-interface and is not used for calculations.

rsit:
:   Reference Security Incident Classification Taxonomy

rt_event_status:
:   Status of events used in Request Tracker.

runtime-packer:
:   Runtime or software packer used to combine compressed or encrypted data with the decompression or decryption code. This code can add additional obfuscations mechanisms including polymorphic-packer or other obfuscation techniques. This taxonomy lists all the known or official packer used for legitimate use or for packing malicious binaries.

scrippsco2-fgc:
:   Flags describing the sample

scrippsco2-fgi:
:   Flags describing the sample for isotopic data (C14, O18)

scrippsco2-sampling-stations:
:   Sampling stations of the Scripps CO2 Program

sentinel-threattype:
:   Sentinel indicator threat types.

smart-airports-threats:
:   Threat taxonomy in the scope of securing smart airports by ENISA. https://www.enisa.europa.eu/publications/securing-smart-airports

social-engineering-attack-vectors:
:   Attack vectors used in social engineering as described in 'A Taxonomy of Social Engineering Defense Mechanisms' by Dalal Alharthi and others.

srbcert:
:   SRB-CERT Taxonomy - Schemes of Classification in Incident Response and Detection

state-responsibility:
:   A spectrum of state responsibility to more directly tie the goals of attribution to the needs of policymakers.

stealth_malware:
:   Classification based on malware stealth techniques. Described in https://vxheaven.org/lib/pdf/Introducing%20Stealth%20Malware%20Taxonomy.pdf

stix-ttp:
:   TTPs are representations of the behavior or modus operandi of cyber adversaries.

targeted-threat-index:
:   The Targeted Threat Index is a metric for assigning an overall threat ranking score to email messages that deliver malware to a victim’s computer. The TTI metric was first introduced at SecTor 2013 by Seth Hardy as part of the talk “RATastrophe: Monitoring a Malware Menagerie” along with Katie Kleemola and Greg Wiseman.

thales_group:
:   Thales Group Taxonomy - was designed with the aim of enabling desired sharing and preventing unwanted sharing between Thales Group security communities.

threatmatch:
:   The ThreatMatch Sectors, Incident types, Malware types and Alert types are applicable for any ThreatMatch instances and should be used for all CIISI and TIBER Projects.

threats-to-dns:
:   An overview of some of the known attacks related to DNS as described by Torabi, S., Boukhtouta, A., Assi, C., & Debbabi, M. (2018) in Detecting Internet Abuse by Analyzing Passive DNS Traffic: A Survey of Implemented Systems. IEEE Communications Surveys & Tutorials, 1–1. doi:10.1109/comst.2018.2849614

tlp:
:   The Traffic Light Protocol (TLP) (v2.0) was created to facilitate greater sharing of potentially sensitive information and more effective collaboration. Information sharing happens from an information source, towards one or more recipients. TLP is a set of four standard labels (a fifth label is included in amber to limit the diffusion) used to indicate the sharing boundaries to be applied by the recipients. Only labels listed in this standard are considered valid by FIRST. This taxonomy includes additional labels for backward compatibility which are no more validated by FIRST SIG.

tor:
:   Taxonomy to describe Tor network infrastructure

trust:
:   The Indicator of Trust provides insight about data on what can be trusted and known as a good actor. Similar to a whitelist but on steroids, reusing features one would use with Indicators of Compromise, but to filter out what is known to be good.

type:
:   Taxonomy to describe different types of intelligence gathering discipline which can be described the origin of intelligence.

unified-kill-chain:
:   The Unified Kill Chain is a refinement to the Kill Chain.

use-case-applicability:
:   The Use Case Applicability categories reflect standard resolution categories, to clearly display alerting rule configuration problems.

veris:
:   Vocabulary for Event Recording and Incident Sharing (VERIS)

vmray:
:   VMRay taxonomies to map VMRay Thread Identifier scores and artifacts.

vocabulaire-des-probabilites-estimatives:
:   Ce vocabulaire attribue des valeurs en pourcentage à certains énoncés de probabilité

workflow:
:   Workflow support language is a common language to support intelligence analysts to perform their analysis on data and information.


# JSON Schema

The JSON Schema [@?JSON-SCHEMA] below defines the structure of the MISP taxonomy document
as literally described before. The JSON Schema is used validating a MISP taxonomy. The validation
is a *MUST* if the taxonomy is included in the MISP taxonomies directory.

~~~~
{
  "$schema": "http://json-schema.org/schema#",
  "title": "Validator for misp-taxonomies",
  "id": "https://www.github.com/MISP/misp-taxonomies/schema.json",
  "defs": {
    "entry": {
      "type": "array",
      "uniqueItems": true,
      "items": {
        "type": "object",
        "additionalProperties": false,
        "properties": {
          "numerical_value": {
            "type": "number"
          },
          "expanded": {
            "type": "string"
          },
          "description": {
            "type": "string"
          },
          "colour": {
            "type": "string"
          },
          "value": {
            "type": "string"
          },
          "required": [
            "value"
          ]
        }
      }
    },
    "values": {
      "type": "array",
      "uniqueItems": true,
      "items": {
        "type": "object",
        "additionalProperties": false,
        "properties": {
          "entry": {
            "$ref": "#/defs/entry"
          },
          "predicate": {
            "type": "string"
          }
        },
        "required": [
          "predicate"
        ]
      }
    },
    "predicates": {
      "type": "array",
      "uniqueItems": true,
      "items": {
        "type": "object",
        "additionalProperties": false,
        "properties": {
          "numerical_value": {
            "type": "number"
          },
          "colour": {
            "type": "string"
          },
          "description": {
            "type": "string"
          },
          "expanded": {
            "type": "string"
          },
          "value": {
            "type": "string"
          },
          "exclusive": {
            "type": "boolean"
          },
          "required": [
            "value"
          ]
        }
      }
    }
  },
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "version": {
      "type": "integer"
    },
    "description": {
      "type": "string"
    },
    "expanded": {
      "type": "string"
    },
    "namespace": {
      "type": "string"
    },
    "exclusive": {
      "type": "boolean"
    },
    "type": {
      "type": "array",
      "uniqueItems": true,
      "items": {
        "type": "string",
        "enum": [
          "org",
          "user",
          "attribute",
          "event"
        ]
      }
    },
    "refs": {
      "type": "array",
      "uniqueItems": true,
      "items": {
        "type": "string"
      }
    },
    "predicates": {
      "$ref": "#/defs/predicates"
    },
    "values": {
      "$ref": "#/defs/values"
    }
  },
  "required": [
    "namespace",
    "description",
    "version",
    "predicates"
  ]
}
~~~~

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

<reference anchor='MISP-T' target='https://github.com/MISP/misp-taxonomies'>
  <front>
   <title>MISP Taxonomies - shared and common vocabularies of tags</title>
   <author initials='' surname='MISP' fullname='MISP Community'></author>
   <date></date>
  </front>
</reference>

<reference anchor='machine-tags' target='https://www.flickr.com/groups/51035612836@N01/discuss/72157594497877875/'>
  <front>
   <title>Machine tags</title>
   <author initials='' surname='' fullname='Aaron Straup Cope'></author>
   <date year="2007"></date>
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
