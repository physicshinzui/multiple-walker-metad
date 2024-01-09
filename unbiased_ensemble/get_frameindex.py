import numpy as np 
import argparse 

p = argparse.Argumentparser()
p.add_argument('--xrange', '-xr', required=True)
p.add_argument('--yrange', '-yr', required=True)
args = p.parse_args()

cv1_range = args.xr #[8.5, 9.0]
cv2_range = args.yr #[8.5, 9.0]
with open('colvar.out', 'r') as fin:
    for line in fin:
       if line.startswith('#'): continue 
       t, cv1, cv2 = line.split()
       cv1 = float(cv1)
       cv2 = float(cv2)

       if cv1 >= cv1_range[0] and cv1 <= cv1_range[1]:
           if cv2 >= cv2_range[0] and cv2 <= cv2_range[1]:
               print(t)


