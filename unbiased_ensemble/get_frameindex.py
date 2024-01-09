import numpy as np 

cv1_range = [8.5, 9.0]
cv2_range = [8.5, 9.0]
with open('colvar.out', 'r') as fin:
    for line in fin:
       if line.startswith('#'): continue 
       t, cv1, cv2 = line.split()
       cv1 = float(cv1)
       cv2 = float(cv2)

       if cv1 >= cv1_range[0] and cv1 <= cv1_range[1]:
           if cv2 >= cv2_range[0] and cv2 <= cv2_range[1]:
               print(t)


