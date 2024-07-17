package main

import (
	"flag"
	"fmt"
	"github.com/evolbioinf/clio"
	"github.com/evolbioinf/sus"
	"log"
	"math"
	"os"
	"text/tabwriter"
)

func main() {
	clio.PrepLog("mantile")
	u := "mantile -l <sequence length> -w <window length> " +
		"-g <GC content> -p <probability>"
	p := "Calculate quantiles of the C_m distribution."
	e := "mantile -l 2937655681 -w 20000 -g 0.408679 -p 0.05"
	clio.Usage(u, p, e)
	optL := flag.Int("l", -1, "sequence length")
	optW := flag.Int("w", -1, "window length")
	optG := flag.Float64("g", -1.0, "GC content")
	optP := flag.Float64("p", -1.0, "probability")
	flag.Parse()
	if *optL < 0 {
		log.Fatal("please set a sequence length")
	}
	if *optW < 0 {
		log.Fatal("please set a window length")
	}
	if *optG < 0 {
		log.Fatal("please set a GC content")
	}
	if *optP < 0 {
		log.Fatal("please set the probability")
	}
	l := *optL
	g := *optG
	var m, v float64
	for x := 1; x <= l; x++ {
		p := sus.Prob(l, g, x)
		if p <= math.SmallestNonzeroFloat32 && m > 1 {
			break
		}
		m += float64(x-1) * p
	}
	for x := 1; x <= l; x++ {
		p := sus.Prob(l, g, x)
		if p <= math.SmallestNonzeroFloat32 && v > 1 {
			break
		}
		x2 := float64(x * x)
		v += x2 * p
	}
	m2 := (m + 1.0) * (m + 1.0)
	v -= m2
	w := float64(*optW)
	P := *optP
	v = v / m / w
	s := math.Sqrt(v)
	q := 1 + s*math.Sqrt(2)*math.Erfinv(2.0*P-1.0)
	fq := 1. / math.Sqrt(2.*math.Pi) / s *
		math.Exp(-1./2.*(q-1.)*(q-1.)/s/s)
	wr := tabwriter.NewWriter(os.Stdout, 0, 1, 2, ' ', 0)
	fmt.Fprintf(wr, "#SeqLen\tWinLen\tP\tQ\tF(Q)\n")
	fmt.Fprintf(wr, "%g\t%d\t%g\t%g\t%g\n",
		float64(l), int(w), P, q, fq)
	wr.Flush()
}
