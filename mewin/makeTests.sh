t=../data/test.cm
./mewin $t > r1.txt
./mewin -t 0.9954 $t > r2.txt
./mewin -w 50000 -t 0.9954 $t > r3.txt
./mewin -t 0.49 -i $t > r4.txt
