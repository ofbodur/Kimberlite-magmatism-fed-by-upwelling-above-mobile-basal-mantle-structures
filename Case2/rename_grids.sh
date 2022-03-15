step=40 # initialise age number
ageMa=200

while (( $step <= 50  ))
do

mv -v gld439_sonuclar_between_322km_and_CMBkm_averaged${step}.xyz Case2-Radial-Heat-Advection-Between-322km-and-CMB-Averaged-${ageMa}-Ma.xyz
# mv -v gld445-LIPS-and-Mantle-Plumes-${age}-Ma.nc gld445-Mantle-Plumes-${age}-Ma.nc
#ls -rtlh agegrid_mask_${age}.0Ma.nc
#echo agegrid_final_mask_${age}.grd

step=$(($step + 1))
ageMa=$(($ageMa - 20))
done

