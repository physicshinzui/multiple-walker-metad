#!/bin/bash 
set -eu

xtc_traj=$1

echo 'Reweighting...'
bash 01_reweight_colvar.sh $xtc_traj
echo 'Getting probability for each snapshot...'
python 02_get_probs.py  
echo 'Getting snapshot times to be assembled into an unbiased ensemble...'
python 03_get_frametimes.py 100
echo "Put them into an unbiased ensemble..."
python 04_gen_ens.py
