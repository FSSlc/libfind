#
# simple makefile
#

docs: Use-LibFindMacros.html CMake-Module-Standard.html

ASCIIDOCTOR_ARGS = -a toc=right -a icons=font -a source-highlighter=pygments

%.html: %.adoc
	asciidoctor $(ASCIIDOCTOR_ARGS) -o $@ $<

%.html: %.md
	pandoc -f markdown -t asciidoc -o $*.adoc $<
	asciidoctor $(ASCIIDOCTOR_ARGS) -o $@ $*.adoc
	rm -f $*.adoc

clean:
	rm -f *.html
