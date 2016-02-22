# Generic make file for LaTeX: requires GNU make

LATEX = latex
BIBTEX = bibtex
PDFLATEX = pdflatex --file-line-error-style --shell-escape
TEXFILE = main.tex
INCLUDES = \
	parts/abstract.tex \
	parts/intro.tex \
	parts/legend.tex \
	parts/titlepage.tex \
	parts/main-part.tex \
	parts/conclusions.tex \
	parts/end.tex
BIBLIO = \
	citations.bib
STYLES = \
	thesisby.cls \
	utf8gost71u.bst
TARGZ = tar zcvf
EXTRA_DIST = *.eps *.bib Makefile

.PHONY: pdf clean veryclean dist

pdf: $(TEXFILE:.tex=.pdf)
# $(INCLUDES)

%.pdf: %.tex $(INCLUDES) $(STYLES) $(BIBLIO)
	( \
	$(PDFLATEX) $<; \
	while grep -q "Rerun to get cross-references right." $(<:.tex=.log); \
	do \
		$(PDFLATEX) $<; \
	done \
	)
	$(BIBTEX) $(<:.tex=)
	( \
	$(PDFLATEX) $<; \
	while grep -q "Rerun to get cross-references right." $(<:.tex=.log); \
	do \
		$(PDFLATEX) $<; \
	done \
	)

clean:
	@rm -f \
	$(INCLUDES:.tex=.aux) \
	$(TEXFILE:.tex=.aux) \
	$(TEXFILE:.tex=.log) \
	$(TEXFILE:.tex=.out) \
	$(TEXFILE:.tex=.pdf) \
	$(TEXFILE:.tex=.toc) 

veryclean: clean
	@rm -f \
	$(TEXFILE:.tex=.bbl) \
	$(TEXFILE:.tex=.blg) \
	$(TEXFILE:.tex=.brf) \
	$(TEXFILE:.tex=.bm)

dist:
	$(TARGZ) \
	$(TEXFILE:.tex=.tgz) \
	$(TEXFILE) \
	$(INCLUDES) \
	$(EXTRA_DIST) \
	$(TEXFILE:.tex=.pdf)

