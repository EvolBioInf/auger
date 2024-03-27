# `auger`: Analyze Unique Genomic Regions
## Description
We demonstrate our analysis of unique genomic regions in mammalian
genomes by working through the details for the human genome.
## Authors
[Beatriz Vieira
Mourato](https://www.evolbio.mpg.de/person/115992/33243) & [Bernhard
Haubold](http://guanine.evolbio.mpg.de/)
## Dependencies
On a Debian-like system, for example Ubuntu, dependencies can be
installed via `apt`.

`sudo apt install golang make noweb texlive texlive-latex-extra texlive-science texlive-pstricks`

In addition, the current version of the Go language is required, which
is hosted [here](https://go.dev/doc/install).

Having installed the `apt` packages and Go, change into the cloned
`auger` repository and make the package.

`cd auger`  
`make`

The documentation is now contained in `doc/auger.pdf`
