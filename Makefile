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

pdf: $(TEXFILE:.tex=.pdf)
	evince $(TEXFILE:.tex=.pdf) &

%.pdf: %.tex $(INCLUDES) $(STYLES) $(BIBLIO) $(FIGURES)
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
	@rm -f *.pdf

