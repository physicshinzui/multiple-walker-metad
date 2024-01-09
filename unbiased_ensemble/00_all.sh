#!/bin/bash 
set -eu

echo 'Getting probability for each snapshot...'
python 01_get_probs.py  
echo 'Getting snapshot times to be assembled into an unbiased ensemble...'
python 02_get_frametimes.py 5000
echo "Put them into an unbiased ensemble..."
python 03_gen_ens.py
