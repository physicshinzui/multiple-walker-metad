#!/bin/bash
set -eu 
cat<<EOF
Usage: 
    $0 [xtc] [plumed input]

NOTE: 
    It may be better to remove the first part of your simulation (e.g., 1 ns). 
    Done this before executing this script.

EOF
xtc_traj=$1
plumed_in=$2
plumed driver --mf_xtc $xtc_traj --plumed $plumed_in --kt 2.494339 
