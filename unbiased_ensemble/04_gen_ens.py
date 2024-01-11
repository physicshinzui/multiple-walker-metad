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
frame_ids = np.loadtxt('reweighted_frame_ids.out')  # Adjust these values as needed
size = len(frame_ids)
# Create a writer for the output file
with XTCWriter('unbiased_ensemble.xtc', n_atoms=u.atoms.n_atoms) as W:
    counter = 0
    for i, ts in tqdm(enumerate(u.trajectory)):
        if i in frame_ids:
            print(f"Extraction at {ts.time}")
            W.write(u)
            counter += 1

if  counter != size:
    print("ERROR:")
    print(f"    No. of extracted frames {counter} are not the same as the size {size}")
    print("    You may not set correctly the COLVAR SLIDE value to the value of snapshot writing inverval. This must be the same.")
    print("    You should check the given input file, probably named `reweight.dat`")
    sys.exit()

print("Extraction complete.")
