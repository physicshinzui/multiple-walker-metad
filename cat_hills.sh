#!/bin/bash 
set -eu
n=`ls HILLS.* | wc -l`
echo "Concatinated files:"
ls HILLS.*

echo "No. of HILLS files = $n" 
for i in `seq 0 $((n-1))`; do
    cat HILLS.$i >> HILLS_all
done
