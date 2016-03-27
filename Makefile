# Generic make file for LaTeX: requires GNU make

LATEX = latex
BIBTEX = bibtex
PDFLATEX = pdflatex --file-line-error-style --shell-escape
TEXFILE = Svichkarev_report.tex
INCLUDES = \
	parts/abstract.tex \
	parts/intro.tex \
	parts/legend.tex \
	parts/titlepage.tex \
	parts/main/theory.tex \
	parts/main/implementation.tex \
	parts/main/interpreter.tex \
	parts/main/test_function.tex \
	parts/main/experiment.tex \
	parts/main/tracker.tex \
	parts/conclusions.tex \
	parts/end.tex
BIBLIO = \
	citations.bib
STYLES = \
	thesisby.cls \
	utf8gost71u.bst
FIGURES = \
	rastrigin.eps \
	m5.eps \
	m10.eps \
	tukey.eps

.PHONY: pdf clean veryclean

build: $(TEXFILE) $(INCLUDES) $(STYLES) $(BIBLIO) $(FIGURES)
	$(PDFLATEX) $<;
	$(BIBTEX) $(<:.tex=)
	$(PDFLATEX) $<;
	$(PDFLATEX) $<;
	$(PDFLATEX) $<;

pdf: build
	evince $(TEXFILE:.tex=.pdf) &

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
	@rm -f *.pdf

