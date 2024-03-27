all: cli.sh
cli.sh: cli.org
	bash ../scripts/org2nw cli.org | notangle -Rcli > cli.sh
clean:
	rm -rf cli.sh genome genome.zip hs.fasta hs.idx
