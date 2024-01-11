import numpy as np 
import sys 
sample_size = int(sys.argv[1])
data = np.loadtxt('frame_ids_w_weight.out', comments='#')
ids, ws = data[:,0], data[:,1]

print("Normalised?:", np.sum(ws))
ids_for_unbiased_ensemble = np.random.choice(ids, size=sample_size, p=ws, replace=False)
# ^ I intend not to sample the same time more than twice, that's why replace=False

ids_for_unbiased_ensemble = sorted(ids_for_unbiased_ensemble)
with open('reweighted_frame_ids.out','w') as fout:
    for frame_id in ids_for_unbiased_ensemble:
        fout.write(f"{int(frame_id)}\n")
#np.savetxt('frameids.out', ids_for_unbiased_ensemble, header='frameid')
