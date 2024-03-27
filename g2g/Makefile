all: pick.awk g2g.sh print.awk
g2g.sh: g2g.org
	bash ../scripts/org2nw g2g.org | notangle -Rg2g > g2g.sh
pick.awk: g2g.org
	bash ../scripts/org2nw g2g.org | notangle -Rpick.awk > pick.awk
print.awk: g2g.org
	bash ../scripts/org2nw g2g.org | notangle -Rprint.awk > print.awk
clean:
	rm -f g2g.sh pick.awk print.awk
