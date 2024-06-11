nw = $(shell which noweb)
all: pick.awk g2g.sh print.awk printKeys.awk printVal.awk
g2g.sh: g2g.org
	if [ $(nw) != "" ]; then\
		bash ../scripts/org2nw g2g.org | notangle -Rg2g > g2g.sh;\
	fi
pick.awk: g2g.org
	if [ $(nw) != "" ]; then\
		bash ../scripts/org2nw g2g.org | notangle -Rpick.awk > pick.awk;\
	fi
print.awk: g2g.org
	if [ $(nw) != "" ]; then\
		bash ../scripts/org2nw g2g.org | notangle -Rprint.awk > print.awk;\
	fi
printKeys.awk: g2g.org
	if [ $(nw) != "" ]; then\
		bash ../scripts/org2nw g2g.org | notangle -RprintKeys.awk > printKeys.awk;\
	fi
printVal.awk: g2g.org
	if [ $(nw) != "" ]; then\
		bash ../scripts/org2nw g2g.org | notangle -RprintVal.awk > printVal.awk;\
	fi
clean:
	rm -f g2g.sh pick.awk print.awk printKeys.awk
