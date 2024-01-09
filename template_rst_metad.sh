#!/bin/bash 
#$ -S /bin/bash
#$ -cwd
#$ -l h_rt=@walltime
#$ -l q_node=1
##$ -g hp230064
#$ -N restart_metad_@walker_id
#$ -o metad_out_@walker_id
set -eu 
. /etc/profile.d/modules.sh
module load cuda/11.2.146
module load python/3.8.3
module load gcc/8.3.0
module load cmake/3.21.3
module load openmpi intel-mpi/21.8.0
export CC=`which gcc`
export CXX=`which g++`
. ~/.bashrc

export PATH=/gs/hs1/hp230064/siida/software/gromacs-2022.5-plumed-2.8.3/build/bin:$PATH
export LD_LIBRARY_PATH=/gs/hs1/hp230064/siida/software/gromacs-2022.5-plumed-2.8.3/build/lib:$LD_LIBRARY_PATH

GMX=gmx_mpi 
${GMX} convert-tpr -s metad_@walker_id.tpr -until 200 -o metad_@walker_id.tpr
${GMX} mdrun -deffnm metad_@walker_id -s metad_@walker_id.tpr -cpi metad_@walker_id.cpt -plumed rst_@walker_id.dat
