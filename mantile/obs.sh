l=$(wc -l cm.dat |
          awk '{print $1}')
n=100
for a in $(seq $n); do
    p=$(echo "$a / $n" |
              bc -l)
    c=$(echo "$l * $p" |
              bc -l |
              awk '{printf "%d", $1}')
    q=$(head -n $c cm.dat |
              tail -n 1)
    printf "%f\t%f\to\n" $p $q
done
