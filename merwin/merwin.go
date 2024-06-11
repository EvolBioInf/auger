package main

import (
	"bufio"
	"flag"
	"fmt"
	"github.com/evolbioinf/auger/util"
	"github.com/evolbioinf/clio"
	"io"
	"log"
	"strconv"
	"strings"
)

func parse(r io.Reader, args ...interface{}) {
	w := args[0].(int)
	threshold := args[1].(float64)
	minimize := args[2].(bool)
	sum := 0.0
	n := 0
	is := -1
	ie := is
	prevSeq := ""
	sc := bufio.NewScanner(r)
	for sc.Scan() {
		fields := strings.Fields(sc.Text())
		curSeq := fields[0]
		mi, err := strconv.ParseFloat(fields[1], 64)
		util.Check(err)
		ws := int((mi - float64(w)/2.0) + 1.0)
		we := int(mi + float64(w)/2.0)
		cm, err := strconv.ParseFloat(fields[2], 64)
		util.Check(err)
		if cm < 0 {
			continue
		}
		if is >= 0 {
			if curSeq != prevSeq || ws > ie {
				avg := sum / float64(n)
				fmt.Printf("%s\t%d\t%d\t%.4g\n",
					prevSeq, is, ie, avg)
				is = -1
				sum = 0
				n = 0
			}
		}
		isCand := false
		if !minimize {
			if cm >= threshold {
				isCand = true
			}
		} else {
			if cm <= threshold {
				isCand = true
			}
		}
		if isCand {
			ie = we
			if is < 0 {
				is = ws
			}
			sum += cm
			n++
			if ws > ie {
				is = ws
			}
		}
		prevSeq = curSeq
	}
	if is >= 0 {
		avg := sum / float64(n)
		fmt.Printf("%s\t%d\t%d\t%.4g\n",
			prevSeq, is, ie, avg)
	}
}
func main() {
	clio.PrepLog("merwin")
	u := "merwin -t <threshold> [option]... [file]..."
	p := "Merge overlapping windows returned by macle."
	e := "merwin -t 0.9954 hs.cm"
	clio.Usage(u, p, e)
	optV := flag.Bool("v", false, "version")
	optW := flag.Int("w", 10000, "window length")
	optT := flag.Float64("t", 0.0, "C_m threshold")
	m := "minimizing, i. e. merge if C_m <= t " +
		"(default maximizing)"
	optI := flag.Bool("i", false, m)
	flag.Parse()
	if *optV {
		util.PrintInfo("merwin")
	}
	if *optT == 0.0 {
		m := "please supply a C_m threshold; this "
		m += "can be calculated with the quantile "
		m += "subprogram of macle2go available "
		m += "from github.com/evolbioinf/macle2go"
		log.Fatal(m)
	}
	files := flag.Args()
	clio.ParseFiles(files, parse, *optW, *optT, *optI)
}
