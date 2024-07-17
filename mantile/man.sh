ranseq -l 10000000 |
    macle -w 10000 |
    cut -f 3 |
    sort -n > cm.dat
bash obs.sh > man.dat
bash exp.sh >> man.dat
plotLine -x "Cumulative Probability" -y "Quantile" man.dat
