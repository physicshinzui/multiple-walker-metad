#!/bin/bash 
#$ -S /bin/bash
#$ -cwd
#$ -l h_rt=@WALLTIME
#$ -l q_node=1
##$ -g hp230064
#$ -N metad_@WALKER_ID
#$ -o metad_out_@WALKER_ID
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
sed "s/@seed/$RANDOM/g" inputs/nvt.mdp > nvt_@WALKER_ID.mdp
${GMX} grompp -f nvt_@WALKER_ID.mdp \
  	      -c em2.gro \
 	      -r em2.gro \
 	      -p topol.top \
 	      -po mdout_meatd_@WALKER_ID.mdp \
 	      -o metad_@WALKER_ID.tpr

#sed -e "s/@id/@WALKER_ID/g" @PLUMED_IN > plumed_@WALKER_ID.dat
${GMX} mdrun -deffnm metad_@WALKER_ID -s metad_@WALKER_ID.tpr -plumed plumed_@WALKER_ID.dat 
