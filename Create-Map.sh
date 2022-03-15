
region=g
proj_map=N0/12

# Select Model - Case1 
# Case1Dir=/Users/omer/Documents/Programming/PyGplates/ForPublication/Case1/
# Case1OutputDir=/Users/omer/Documents/Programming/PyGplates/ForPublication/Output-Case1/

# Select Model - Case2 
#Case2Dir=/Users/omer/Documents/Programming/PyGplates/ForPublication/Case2/
#Case2OutputDir=/Users/omer/Documents/Programming/PyGplates/ForPublication/Output-Case2/

# Select Model - Case3 
# Case3Dir=/Users/omer/Documents/Programming/PyGplates/ForPublication/Case3/
# Case3OutputDir=/Users/omer/Documents/Programming/PyGplates/ForPublication/Output-Case3/

# Select Model - Case4 
Case4Dir=/Users/omer/Documents/Programming/PyGplates/ForPublication/Case4/
Case4OutputDir=/Users/omer/Documents/Programming/PyGplates/ForPublication/Output-Case4/

# Only for Case 1,2,3
# AgeGridDir=/Users/omer/Documents/Programming/PyGplates/ForPublication/Agegrid/

# Only for Case 4
AgeGridDirM21=/Users/omer/Documents/Programming/PyGplates/ForPublication/Agegrid-M21/

# For Cases 1,2,3
# CratonicShapesRootM21NNR=/Users/omer/Documents/Programming/PyGplates/ForPublication/Cratonic-Shapes-M21-NNR

# Only for Case 4
CratonicShapesRootM21=/Users/omer/Documents/Programming/PyGplates/ForPublication/Cratonic-Shapes-M21

#For Cases 1,2,3
# root_for_Kimb_Data=/Users/omer/Documents/Programming/PyGplates/Kimberlites

# Only for Case 4
root_for_Kimb_Data_M21=/Users/omer/Documents/Programming/PyGplates/ForPublication/Kimberlites/M21

for timeMa in `seq 0 20 200`; do	

echo $timeMa

filexyz=${Case4Dir}/Case4-Radial-Heat-Advection-Between-322km-and-CMB-Averaged-${timeMa}-Ma.xyz

echo $filexyz

# Introduce names for grid files and output .ps file to be converted to PDF and/or PNG/JPG
psfile=${Case4OutputDir}Case4-Radial-Heat-Advection-Between-322km-and-CMB-Averaged-${timeMa}-Ma.ps
medianfile=${Case4OutputDir}Case4_Radial-Heat-Advection_between_322km_and_CMB_averaged_${timeMa}-Ma.median
gridFile=${Case4OutputDir}Case4_Radial-Heat-Advection_between_322km_and_CMB_averaged_${timeMa}-Ma.nc
gridFile_1_0=${Case4OutputDir}Case4_Radial-Heat-Advection_between_322km_and_CMB_averaged_1_and_0_${timeMa}-Ma.nc
gridFileMasked=${Case4OutputDir}Case4_Radial-Heat-Advection_between_322km_and_CMB_averaged_${timeMa}masked-Ma.nc


# If Reconstruction is M21 Merdith et al., (2021)
#CratonsM21Folder=/Users/omer/Documents/Programming/PyGplates/Supplement/Reconstructions/M21/CratonsReconstructed
#CratonFile=${CratonsM21Folder}/Cratons_reconstructed_M21_${timeMa}.00Ma.xy


# agegrid=${AgeGridDir}agegridsampled_${timeMa}-Ma.grd
agegrid=${AgeGridDirM21}/agegrid_final_with_continents_${timeMa}.grd
maskFile=mask_${timeMa}.nc
maskFileRd=mask_Rd_${timeMa}.nc
maskFileRd2=mask_Rd_2${timeMa}.nc

maskFileM21=mask_M21_${timeMa}.nc	
maskFileM21Rd=mask_M21_Rd_${timeMa}.nc


gmt blockmedian $filexyz -Rd -I0.1 -V > $medianfile
gmt surface $medianfile -I0.1 -R${region} -V -G$gridFile # Resolution is 0.1 deg.
# gmt sphinterpolate $medianfile -I0.1 -R${region} -V -G$gridFile # Resolution is 0.1 deg.

# gmt grdedit $gridFile -R-180/180/-90/90
gmt grdclip $gridFile -Rd -G$gridFile_1_0 -Sa0.99/1 -Sb0.99/0 -V # Set values equal and above 1 as 1, others as 0.

rm  $medianfile # remove temporary grid file

CoastlinesPlot=${CratonicShapesRootM21}/Cratons_reconstructed_M21_${timeMa}.00Ma.xy

gmt grdmask -Rd -I0.1 $CoastlinesPlot -N0/1/1 -G$maskFileRd2 

#Below for reconstruction M21 
#gmt grdmask -Rd -I0.1 $CratonFile -N0/1/1 -G$maskFileM21 
#gmt grdmask -Rd -I0.1 $CratonFile -N-1/1/1 -G$maskFileM21Rd 


gmt grdmath $maskFileRd2 $gridFile_1_0 MUL = $gridFileMasked


gmt grdmath $agegrid -0.1 GT = Ocean.grd 

CoastlinesPlot=${CratonicShapesRootM21}/Coastlines-M21-${timeMa}.00Ma.xy

gmt grdimage -R${region} -J${proj_map} $gridFile -CColourmap-RHA.cpt -t50 -V -K > $psfile

gmt psxy $CoastlinesPlot -R${region} -J${proj_map} -Gblack -O -V -K >> $psfile 

gmt grdimage -R${region} -J${proj_map} $gridFile -CColourmap-RHA.cpt -t70 -O -V -K >> $psfile

CoastlinesPlot=${CratonicShapesRootM21}/reconstructed_MerdithCratons_${timeMa}.00Ma.xy

gmt psxy $CoastlinesPlot -R${region} -J${proj_map}  -W0.2p,black -Ggreen -O -V -K >> $psfile 

gmt grdimage -R${region} -J${proj_map} $gridFile -CColourmap-RHA.cpt -t40 -O -V -K >> $psfile

gmt grdimage -R${region} -J${proj_map} Ocean.grd  -COcean.cpt -t65 -O -V -K >> $psfile

gmt grdimage -R${region} -J${proj_map} $gridFileMasked -CColourmap-RHA_Masked.cpt -t60 -O -V -K >> $psfile

# Add reconstructed kimberlites
# KimberlitesXY=${root_for_Kimb_Data}/XYreconstructed_${timeMa}.00Ma.xy
KimberlitesXY=${root_for_Kimb_Data_M21}/${timeMa}Ma_kimberlite_locations-M21.xy
gmt psxy $KimberlitesXY -R${region} -J${proj_map} -Sc0.17 -W0.3p,black -Gwhite -t5 -O -V -K >> $psfile #1)
gmt psxy $KimberlitesXY -R${region} -J${proj_map} -Sc0.08 -W0.06p,black -Gmagenta  -t3 -O -V -K >> $psfile #2)
gmt psxy $KimberlitesXY -R${region} -J${proj_map} -Sc0.03 -W0.06p,black -Gblack -t3 -O -V -K >> $psfile #3)

# KimberlitesTrack=${root_for_Kimb_Data_M21}/${timeMa}Ma_kimberlite_locationsM21-Track.xy

# gmt grdtrack $KimberlitesTrack -G$gridFile >sonuc_tracked_${timeMa}.xy

gmt psbasemap -R${region} -J${proj_map} -Ba90f9/a60f11 -O -V  >> $psfile

gmt psconvert $psfile -A -Tf

# rm $gridFile
rm $psfile

# timeMa=$(( timeMa +20 )) # every 20 Myr
done

