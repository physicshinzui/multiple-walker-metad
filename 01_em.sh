#!/bin/bash 
## #$ -S /bin/bash
## #$ -cwd
## #$ -l h_rt=00:10:00
## #$ -l q_node=1
## ##$ -g hp230064
## #$ -N metad
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

# export PATH=/gs/hs1/hp230064/siida/software/gro-plumed/build/bin:$PATH
# export LD_LIBRARY_PATH=/gs/hs1/hp230064/siida/software/gro-plumed/build/lib:$LD_LIBRARY_PATH
export PATH=/gs/hs1/hp230064/siida/software/gromacs-2022.5-plumed-2.8.3/build/bin:$PATH
export LD_LIBRARY_PATH=/gs/hs1/hp230064/siida/software/gromacs-2022.5-plumed-2.8.3/build/lib:$LD_LIBRARY_PATH

GMX=gmx_mpi 

fin=inputs/decaAla.pdb
${GMX} pdb2gmx -f $fin -o processed.gro -water tip3p

echo Protein | ${GMX} editconf -f processed.gro \
                -o newbox.gro    \
                -d 1.0           \
                -princ           \
                -bt dodecahedron

${GMX} solvate -cp newbox.gro \
               -cs spc216.gro \
               -o  solv.gro   \
               -p  topol.top

${GMX} grompp -f templates/ions.mdp \
              -c solv.gro  \
              -p topol.top \
              -po mdout_ion.mdp \
              -o ions.tpr

echo "SOL" | ${GMX} genion \
             -s ions.tpr \
             -o solv_ions.gro \
             -p topol.top \
             -pname NA -nname CL \
             -neutral 
             #-conc 0.1 -neutral 

echo "Energy minimisation 1 ..."
${GMX} grompp -f templates/em1.mdp \
              -c solv_ions.gro \
              -r solv_ions.gro \
              -p topol.top \
              -po mdout_em1.mdp \
              -o em1.tpr -maxwarn 1
${GMX} mdrun -deffnm em1

echo "Energy minimisation 2 ..."
${GMX} grompp -f templates/em2.mdp \
            -c em1.gro \
            -p topol.top \
            -po mdout_em2.mdp \
            -o em2.tpr -maxwarn 1
${GMX} mdrun -deffnm em2 
