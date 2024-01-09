#!/bin/bash 
set -eu
cat<<EOF
Usage: 
    $0 [xtc file] [plumed input]

EOF

xtc_traj=$1
plumed_in=$2

echo 'Reweighting...'
plumed driver --mf_xtc $xtc_traj --plumed $plumed_in --kt 2.494339

echo 'Getting probability for each snapshot...'
python 02_get_probs.py  

echo 'Getting snapshot times to be assembled into an unbiased ensemble...'
python 03_get_frametimes.py 2000

echo "Put them into an unbiased ensemble..."
python 04_gen_ens.py ../em2.tpr $xtc_traj 
