#!/bin/bash 
walltime='00:10:00'

# i must start with 0
for i in `seq 0 4`; do
    sed -e "s/@walker_id/${i}/g" -e "s/@walltime/${walltime}/g" template_metad.sh > metad_${i}.sh
    qsub -g hp230064 metad_${i}.sh
done
