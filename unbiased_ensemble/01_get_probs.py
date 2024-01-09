import numpy as np 

kt = 2.494339 #kj/mol at 300K
times, weights = [], []
with open('../COLVAR_REWEIGHT', 'r') as fin:
    for line in fin:
        if line.startswith('#'): continue 

        cols = line.split()
        t, bias = float(cols[0]), float(cols[3])
        weight = np.exp(-bias/kt)
        #print(bias, weight)
        weights.append(weight)
        times.append(t)
#print(np.array(weights)[-1], np.sum(weights))
# probs = np.array(weights)/np.sum(weights)
normed_weight = np.array(weights) / np.sum(weights)
with open('time_w_normedweight.out', 'w') as fout:
    fout.write('# time/ps, normed_weight \in [0,1]\n')
    for t, p in zip(times, normed_weight):
        fout.write(f"{t:.6f} {p:.8E}\n")
