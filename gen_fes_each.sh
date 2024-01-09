#!/bin/bash 

nhills=`ls HILLS.* | wc -l`
for i in `seq 0 $((nhills - 1))`; do
    plumed sum_hills --hills HILLS.$i --mintozero --outfile fes_$i.dat
done
