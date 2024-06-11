# [`auger`](https://owncloud.gwdg.de/index.php/s/WeGEnx8WrfuPqWX): Analyze Unique Genomic Regions
## Description
We demonstrate our analysis of unique genomic regions in mammalian
genomes by working through the details for the human genome.
## Authors
[Beatriz Vieira
Mourato](https://www.evolbio.mpg.de/person/115992/33243) & [Bernhard
Haubold](http://guanine.evolbio.mpg.de/)
## Installation
Before we can install the programs of `auger`, we install `git`,
`make`, and `unzip`. On Debian-type systems like Ubuntu, we can use
`apt`.

```
sudo apt install make unzip
```

In addition, we need the [Go compiler](https://go.dev/doc/install), [`datasets`](https://www.ncbi.nlm.nih.gov/datasets/docs/v2/reference-docs/command-line/datasets/), [`macle`](https://github.com/EvolBioInf/macle), [`biobox`](https://github.com/EvolBioInf/biobox),
[`gin`](https://github.com/EvolBioInf/gin), and [`eggnog-mapper`](https://github.com/eggnogdb/eggnog-mapper).

Having installed these dependencies, we clone the `auger` repo, change
into it, and make the programs. They are now located in the directory
`build`.

```
git clone https://github.com/evolbioinf/auger
cd auger
make
```
