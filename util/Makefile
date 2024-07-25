nw = $(shell which noweb)

all : util

util: util.go
	go build util.go
util.go: util.org
	if [ "$(nw)" != "" ]; then\
		awk -f ../scripts/preTangle.awk util.org | bash ../scripts/org2nw | notangle -Rutil.go | gofmt > util.go;\
	fi

clean:
	rm -f *.go

