import numpy as np 

kt = 2.494339 #kj/mol at 300K
frame_ids, weights = [], []
with open('COLVAR_REWEIGHT', 'r') as fin:
    for iframe, line in enumerate(fin):
        if line.startswith('#'): continue 
        cols = line.split()
        _, bias = float(cols[0]), float(cols[3])
        weight = np.exp(bias/kt)
        #print(bias, weight)
        weights.append(weight)
        frame_ids.append(iframe)

normed_weight = np.array(weights) / np.sum(weights)
with open('frame_ids_w_weight.out', 'w') as fout:
    fout.write('# frame_id, normed_weight \in [0,1]\n')
    for iframe, p in zip(frame_ids, normed_weight):
        fout.write(f"{iframe} {p:.8E}\n")
