MMARK:=mmark

docs = $(wildcard *.md)

all: $(docs)
		$(MMARK) $< > $<.xml
		xml2rfc --text $<.xml
		xml2rfc --html $<.xml
