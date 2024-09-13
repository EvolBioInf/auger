dirs = cli g2g mantile merwin util
all: util/util.go build/cli.sh build/g2g.sh build/mantile build/merwin build/pick.awk build/print.awk


util/util.go: util/util.org
	make -C util
build/cli.sh: cli/cli.org
	make -C cli
	test -d build || mkdir build
	cp cli/cli.sh build
build/g2g.sh: g2g/g2g.org
	make -C g2g
	cp g2g/g2g.sh build
build/mantile: mantile/mantile.org
	make -C mantile
	cp mantile/mantile build
build/merwin: merwin/merwin.org
	make -C merwin
	cp merwin/merwin build
build/pick.awk: g2g/g2g.org
	make -C g2g
	cp g2g/pick.awk build
build/print.awk: g2g/g2g.org
	make -C g2g
	cp g2g/print.awk build

.PHONY: doc
doc:
	make -C doc
clean:
	for dir in $(dirs); do \
		make clean -C $$dir; \
	done
	make clean -C doc
	rm -f build/*
