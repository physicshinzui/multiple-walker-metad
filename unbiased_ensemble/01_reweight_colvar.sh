#!/bin/bash
set -eu 
xtc_traj=$1
plumed_in=$2
plumed driver --mf_xtc $xtc_traj --plumed $plumed_in --kt 2.494339
