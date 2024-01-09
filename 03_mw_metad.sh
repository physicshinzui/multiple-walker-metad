#!/bin/bash 
set -eu 
cat << EOF

Usage: 
    $0 [plumed input file]

EOF
PLUMED_IN=$1
WALLTIME='01:00:00'
NWAKERS=5

# walker_id must start with 0
for walker_id in `seq 0 $((NWAKERS - 1))`; do
    sed -e "s/@WALKER_ID/${walker_id}/g"\
        -e "s/@WALLTIME/${WALLTIME}/g"\
        -e "s!@PLUMED_IN!${PLUMED_IN}!g" template_metad.sh > metad_${walker_id}.sh

    # Modify plumed.dat for each walker
    sed -e "s/@WALKER_ID/${walker_id}/g" -e "s/@NWAKERS/${NWAKERS}/g" ${PLUMED_IN} > plumed_${walker_id}.dat

    qsub -g hp230064 metad_${walker_id}.sh
done
