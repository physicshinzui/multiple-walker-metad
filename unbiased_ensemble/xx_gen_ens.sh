#!/bin/bash 
set -Ceu

mkdir -p ens
ts=`cat times.out`
i=0
for t in $ts; do
    echo 'System' | gmx trjconv -s ../em2.tpr -f ../metad.xtc -dump "$t" -o ens/$i.gro | tee 'extract.log'
    i=$((i + 1))
done