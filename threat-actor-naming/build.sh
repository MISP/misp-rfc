/home/adulau/git/mmark2/mmark2 -2 raw.md >threat-actor-naming.xml
xml2rfc --html threat-actor-naming.xml
xml2rfc threat-actor-naming.xml
cp threat-actor-naming.txt /home/adulau/git/misp-standard.org/rfc
cp threat-actor-naming.html /home/adulau/git/misp-standard.org/rfc
