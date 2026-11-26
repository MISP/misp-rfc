MMARK:=mmark
XML2RFC ?= xml2rfc

docs = $(wildcard *.md)

all: $(docs)
		$(MMARK) $< > $<.xml
		$(XML2RFC) --text $<.xml
		$(XML2RFC) --html $<.xml
