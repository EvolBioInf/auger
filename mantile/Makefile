VERSION = $(shell git describe)
DATE := $(shell git log | grep Date | head -n 1 | sed -r 's/Date: +[A-Z][a-z]+ ([A-Z][a-z]+) ([0-9]+) [^ ]+ ([0-9]+) .+/\2_\1_\3/')
NW = $(shell which noweb)

EXE = mantile

all: $(EXE) exp.sh man.sh obs.sh

$(EXE): $(EXE).go
	go build -ldflags "-X github.com/evolbioinf/auger/util.version=$(VERSION) -X github.com/evolbioinf/auger/util.date=$(DATE)" $(EXE).go
$(EXE).go: $(EXE).org
	if [ "$(NW)" != "" ]; then\
		bash ../scripts/org2nw $(EXE).org | notangle -R$(EXE).go | gofmt > $(EXE).go;\
	fi
exp.sh: $(EXE).org
	if [ "$(NW)" != "" ]; then\
		bash ../scripts/org2nw $(EXE).org | notangle -Rexp.sh > exp.sh;\
	fi
man.sh: $(EXE).org
	if [ "$(NW)" != "" ]; then\
		bash ../scripts/org2nw $(EXE).org | notangle -Rman.sh > man.sh;\
	fi
obs.sh: $(EXE).org
	if [ "$(NW)" != "" ]; then\
		bash ../scripts/org2nw $(EXE).org | notangle -Robs.sh > obs.sh;\
	fi
test: $(EXE) $(EXE)_test.go
	go test -v
$(EXE)_test.go: $(EXE).org
	if [ "$(NW)" != "" ]; then\
		bash ../scripts/org2nw $(EXE).org | notangle -R$(EXE)_test.go | gofmt > $(EXE)_test.go;\
	fi
clean:
	rm -f $(EXE) *.go exp.sh man.sh obs.sh
