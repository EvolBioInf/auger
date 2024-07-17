n=100
((it=$n-1))
for a in $(seq $it); do
    p=$(echo "$a / $n" |
              bc -l)
    q=$(./mantile -l 10000000 -g 0.5 -w 10000 -p $p |
              tail -n +2 |
              awk '{print $4}')
    printf "%f\t%f\te\n" $p $q
done
