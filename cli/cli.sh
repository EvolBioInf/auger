datasets download genome accession GCF_000001405.40 \
           --dehydrated --filename genome.zip
unzip genome.zip -d genome
datasets rehydrate --directory genome
p="genome/ncbi_dataset/data/GCF_000001405.40"
p="$p/GCF_000001405.40_GRCh38.p14_genomic.fna"
getSeq NC_ $p > hs.fasta
macle -s hs.fasta > hs.idx
macle -w 10000 -i hs.idx > hs.cm
macle -l hs.idx
macle2go quantile -l 3088286401 -g 0.4087 -w 10000 -p 0.05
merwin -w 10000 -t 0.9954 hs.cm > hs_iv.txt
datasets download genome accession GCF_000001405.40 \
           --dehydrated --filename gff.zip --include gff3
unzip -d gff gff.zip
datasets rehydrate --directory gff
p="gff/ncbi_dataset/data/GCF_000001405.40/"
mv $p/genomic.gff hs.gff
annotate -c hs.gff hs_iv.txt > hsObsId.txt
ego -g hs.gff -o hs.g2g hsObsId.txt > hsGoSym.txt
shuffle -n 100000 hs.gff hs_iv.txt |
    annotate -c hs.gff |
    ego -o hs.g2g hsObsId.txt > hsEnr.txt
