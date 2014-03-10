OUTPUT=monografia
BIB=referencias

all: $(OUTPUT).pdf

$(OUTPUT).pdf: $(OUTPUT).tex $(BIB).bbl
	pdflatex $(OUTPUT) </dev/null
	pdflatex $(OUTPUT) </dev/null

$(OUTPUT).dvi: $(OUTPUT).tex $(BIB).bbl
	latex $(OUTPUT) </dev/null
	latex $(OUTPUT) </dev/null

$(OUTPUT).ps: $(OUTPUT).dvi
	dvips -o $(OUTPUT).ps $(OUTPUT).dvi

$(BIB).bbl: $(BIB).bib
	latex $(OUTPUT) </dev/null
	bibtex $(OUTPUT) </dev/null

clean:
	rm -f *.aux
	rm -f *.bbl
	rm -f *.bak
	rm -f *.log
	rm -f *.blg
	rm -f *.toc
	rm -f *.lot
	rm -f *.lof
	rm -f *.idx
	rm -f *.ilg
	rm -f *.ind
	rm -f $(OUTPUT).pdf
	rm -f $(OUTPUT).ps
	rm -f $(OUTPUT).dvi
