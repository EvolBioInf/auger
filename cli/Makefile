nw = $(shell which noweb)
all: cli.sh
cli.sh: cli.org
	if [ "$(nw)" != "" ]; then\
		bash ../scripts/org2nw cli.org | notangle -Rcli > cli.sh;\
	fi
clean:
	rm -rf cli.sh genome genome.zip hs.fasta hs.idx
