dirs = cli g2g mewin util
all: util/util.go build/cli.sh build/g2g.sh build/mewin build/pick.awk build/print.awk


util/util.go: util/util.org
	make -C util
build/cli.sh: cli/cli.org
	make -C cli
	test -d build || mkdir build
	cp cli/cli.sh build
build/g2g.sh: g2g/g2g.org
	make -C g2g
	cp g2g/g2g.sh build
build/mewin: mewin/mewin.org
	make -C mewin
	cp mewin/mewin build
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
