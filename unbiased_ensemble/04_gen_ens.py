import MDAnalysis as mda
from MDAnalysis.coordinates.XTC import XTCWriter
import numpy as np 
from tqdm import tqdm 
import sys

ref = sys.argv[1]
traj = sys.argv[2]
# Load the universe
u = mda.Universe(ref, traj)
# e.g., ref: em.tpr, traj: metad.xtc

# Time points to extract (in picoseconds)
times_to_extract = np.loadtxt('times.out')  # Adjust these values as needed
size = len(times_to_extract)
# Create a writer for the output file
with XTCWriter('unbiased_ensemble.xtc', n_atoms=u.atoms.n_atoms) as W:
    counter = 0
    for ts in tqdm(u.trajectory):
        if ts.time in times_to_extract:
            #print(f"Extraction at {ts.time}")
            W.write(u)
            counter += 1

if  counter != size:
    print("ERROR:")
    print(f"No. of extracted frames {counter} are not the same as the size {size}")
    print("You may not set correctly the COLVAR SLIDE value to the value of snapshot writing inverval. This must be the same.")
    print("You should read an input file probably named `plumed_driver.dat`")

print("Extraction complete.")
