
set multiplot layout 2,1
set title 'CV1'
plot for [i=1:5] sprintf("COLVAR_%d", i) using 1:2 every 10 w l notitle 
set title 'CV2'
plot for [i=1:5] sprintf("COLVAR_%d", i) using 1:3 every 10 w l notitle 
unset multiplot
