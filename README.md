# MISP standards and RFCs

This repository is the official source of the specification and formats used in the MISP project.

The formats are described to support other implementations which reuse the format and ensuring an interoperability
with existing MISP software, other Threat Intelligence Platforms and security tools at large.

All the formats can be freely reused by everyone.

## MISP Formats in use and implemented in multiple software

* [misp-core-format](misp-core-format/raw.md.txt) ([markdown source](misp-core-format/raw.md)) which describes the core JSON format of MISP. Current Internet-Draft: [16](https://tools.ietf.org/html/draft-dulaunoy-misp-core-format)
* [misp-taxonomy-format](misp-taxonomy-format/raw.md.txt) ([markdown source](misp-taxonomy-format/raw.md)) which describes the taxonomy JSON format of MISP. Current Internet-Draft: [11](https://tools.ietf.org/html/draft-dulaunoy-misp-taxonomy-format)
* [misp-galaxy-format](misp-galaxy-format/raw.md.txt) which describes the [galaxy](https://github.com/MISP/misp-galaxy) template format used to expand the threat actor modelling of MISP. Current Internet-Draft: [06](https://datatracker.ietf.org/doc/draft-dulaunoy-misp-galaxy-format/)
* [misp-object-template-format](misp-object-template-format/raw.md.txt) which describes the [object](https://github.com/MISP/misp-objects) template format to add combined and composite object to the MISP core format. Current Internet-Draft: [03](https://datatracker.ietf.org/doc/draft-dulaunoy-misp-object-template-format/)

## MISP Format in design phase and implemented in at least one software prototype

* misp-modules-protocol which describes the [misp-modules](https://github.com/MISP/misp-modules) protocol used between MISP and misp-modules.

## MISP Format in design phase

* misp-collaborative-voting-format which describes the collaborative voting and scoring format for the feeds providers.

## Sample files

If you want to see how a threat intelligence can be easily expressed in MISP standard, the following resources might give you some ideas:

* [CIRCL OSINT MISP Feed](https://www.circl.lu/doc/misp/feed-osint/)

[Installing MISP](https://www.misp-project.org/download/) is also another option to see the MISP standards in action. The MISP standards are actively used in the MISP threat intelligence platform to support the complete chain from intelligence creation, sharing, distribution and synchronisation.

## Building the RFCs

These RFCs use [mmark](https://mmark.nl/) to generate - get a release [from the Github Repo](https://github.com/mmarkdown/mmark) and make sure it's in your PATH.

You'll also need `xml2rfc` - install using `sudo pip3 isntall xml2rfc`

```bash
for directory in $(find . -type d -iname "misp*"); do;
    echo "Building $directory...";
    cd $directory;
    make;
    cd ..;
done;
```

# Contribution

If you want to contribute to the MISP specifications, feel free to [open an issue](https://github.com/MISP/misp-rfc/issues).
