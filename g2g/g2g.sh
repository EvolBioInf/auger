datasets download genome accession GCF_000001405.40 \
           --include gff3 --filename gff3.zip
unzip -d gff3 gff3.zip
mv gff3/ncbi_dataset/data/GCF_000001405.40/genomic.gff \
   hs.gff
awk '$3 == "CDS"' hs.gff |
    tr ';' '\n' |
    grep '^Dbxref' |
    sed 's/Dbxref=//' |
    tr ':,' ' ' |
    tr [:lower:] [:upper:] |
    awk -f pick.awk > gen2pro.txt
datasets download genome accession GCF_000001405.40 \
           --include protein --filename protein.zip
unzip -d protein protein.zip
mv protein/ncbi_dataset/data/GCF_000001405.40/protein.faa hs.faa
git clone https://github.com/eggnogdb/eggnog-mapper
cd eggnog-mapper/
python setup.py install
python download_eggnog_data.py
emapper.py --cpu 64 -o human --output_dir res/ \
             --override -m diamond --sensmode ultra-sensitive \
             --dmnd_ignore_warnings -i hs.faa \
             --evalue 0.001 --score 60 --pident 40 \
             --query_cover 20 --subject_cover 20 \
             --itype proteins --tax_scope inner_narrowest \
             --target_orthologs all \
             --go_evidence non-electronic --dbmem \
             --tax_scope eukaryota --pfam_realign none \
             --report_orthologs --decorate_gff yes
grep -v '^#' human.emapper.annotations |
    cut -f 1,10 |
    tr ',' ' ' |
    awk '{for(i=2;i<=NF;i++)printf "%s\t%s\n", $1, $i}' \
          > pro2go.txt
wget http://purl.obolibrary.org/obo/go/go-basic.obo
awk '/^\[Term\]/{o=1}/^$/{o=0}o{print}' \
    go-basic.obo | head
grep -c '^id: GO' go-basic.obo
awk -f printKeys.awk go-basic.obo |
    sort |
    uniq
awk -f printVal.awk go-basic.obo > go2term.txt
wc -l go2term.txt
awk '$2 ~ /^obsolete/' go2term.txt | wc -l
awk '$2 !~ /^obsolete/' go2term.txt > t
mv t go2term.txt
sort -k 2,2 gen2pro.txt > t; mv t gen2pro.txt
sort -k 1,1 pro2go.txt  > t; mv t pro2go.txt
join -1 2 gen2pro.txt pro2go.txt |
    awk '{printf "%s\t%s\n", $2, $3}' > gen2go.txt
sort -k 2,2 gen2go.txt  > t; mv t gen2go.txt
sort -k 1,1 go2term.txt > t; mv t go2term.txt
join -t '      ' -1 2 gen2go.txt go2term.txt |
    awk -F '\t' -f print.awk  > hs.g2g
