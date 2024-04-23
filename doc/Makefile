TEXT = auger
SRC1 = $(TEXT).tex intro.tex
SRC2 = cli.tex merwin.tex util.tex g2g.tex 

date = $(shell git log | grep Date | head -n 1 | sed -r 's/Date: +[A-Z][a-z]+ ([A-Z][a-z]+) ([0-9]+) [^ ]+ ([0-9]+) .+/\2_\1_\3/')
version = $(shell git describe)

all: $(TEXT).pdf
$(TEXT).pdf: $(TEXT).tex $(SRC1) $(SRC2)
	echo $(date) | tr '_' ' ' > date.txt
	echo $(version) | tr '-' ' ' | awk '{printf "%s", $$1; if ($$2) printf "-%s", $$2; printf "\n"}' > version.txt
	latex $(TEXT).tex
	bibtex $(TEXT)
	latex $(TEXT)
	latex $(TEXT).tex
	dvips $(TEXT) -o -q
	ps2pdf -dALLOWPSTRANSPARENCY $(TEXT).ps
	if [ -d /mnt/c/Users/haubold/ownCloud\ -\ haubold@evolbio.mpg.de@owncloud.gwdg.de/docs/ ]; then \
		cp auger.pdf /mnt/c/Users/haubold/ownCloud\ -\ haubold@evolbio.mpg.de@owncloud.gwdg.de/docs/; \
	fi
%.tex: ../*/%.org $(TEXT).tex
	bash ../scripts/org2nw $< | awk -f ../scripts/preWeave.awk | noweave -n -x | sed 's/_test/\\_test/' > $@
clean:
	rm -f $(TEXT).aux $(TEXT).dvi $(TEXT).log $(TEXT).pdf $(TEXT).ps  $(TEXT).toc $(SRC2) version.txt date.txt
