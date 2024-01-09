#!/bin/bash 
set -eu

walltime='00:10:00'

for i in `seq 0 4`; do
    sed -e "s/@walker_id/${i}/g" -e "s/@walltime/$walltime/g" template_rst_metad.sh > rst_metad_${i}.sh
    sed -e "s/@walker_id/${i}/g" inputs/rst.dat > rst_${i}.dat
    qsub -g hp230064 rst_metad_${i}.sh
done
