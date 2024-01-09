import numpy as np 
import sys 
sample_size = int(sys.argv[1])
data = np.loadtxt('time_w_normedweight.out', comments='#')
ts, ws = data[:,0], data[:,1]

print("Normalised?:", np.sum(ws))
ts_for_unbiased_ensemble = np.random.choice(ts, size=sample_size, p=ws, replace=False)
# ^ I intend not to sample the same time more than twice, that's why replace=False

ts_for_unbiased_ensemble = sorted(ts_for_unbiased_ensemble)
np.savetxt('times.out', ts_for_unbiased_ensemble, header='time/ps', fmt='%.6f')
