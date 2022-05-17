#!/bin/bash
region = g
proj_map = N0/12

CaseNumber = 1 # Select the case number
CurrentDirectory = !pwd


if [ $CaseNumber -eq 1 ]
then 
	# Case1Dir=/Users/omer/Documents/Programming/PyGplates/ForPublication/Case1/
	CaseDir=${CurrentDirectory}/Case1
	# Case1OutputDir=/Users/omer/Documents/Programming/PyGplates/ForPublication/Output-Case1/
	CaseOutputDir=${CurrentDirectory}/Output-Case1
	AgeGridDir=${CurrentDirectory}/Agegrid-M21-NNR
	CratonicShapes=${CurrentDirectory}/Cratonic-Shapes-M21-NNR
	root_for_Kimb_Data=${CurrentDirectory}/Kimberlites/M21-NNR
	
	
elif [$CaseNumber -eq 2 ]
then
	# Case1Dir=/Users/omer/Documents/Programming/PyGplates/ForPublication/Case1/
	CaseDir=${CurrentDirectory}/Case2
	# Case1OutputDir=/Users/omer/Documents/Programming/PyGplates/ForPublication/Output-Case1/
	CaseOutputDir=${CurrentDirectory}/Output-Case2
	AgeGridDir=${CurrentDirectory}/Agegrid-M21-NNR
	CratonicShapes=${CurrentDirectory}/Cratonic-Shapes-M21-NNR
	root_for_Kimb_Data=${CurrentDirectory}/Kimberlites/M21-NNR
	
elif [$CaseNumber -eq 3 ]
then
	# Case1Dir=/Users/omer/Documents/Programming/PyGplates/ForPublication/Case1/
	CaseDir=${CurrentDirectory}/Case3
	# Case1OutputDir=/Users/omer/Documents/Programming/PyGplates/ForPublication/Output-Case1/
	CaseOutputDir=${CurrentDirectory}/Output-Case3
	AgeGridDir=${CurrentDirectory}/Agegrid-M21-NNR
	CratonicShapes=${CurrentDirectory}/Cratonic-Shapes-M21-NNR
	root_for_Kimb_Data=${CurrentDirectory}/Kimberlites/M21-NNR
	
elif [$CaseNumber -eq 4 ]
then
	# Case1Dir=/Users/omer/Documents/Programming/PyGplates/ForPublication/Case1/
	CaseDir=${CurrentDirectory}/Case4
	# Case1OutputDir=/Users/omer/Documents/Programming/PyGplates/ForPublication/Output-Case1/
	CaseOutputDir=${CurrentDirectory}/Output-Case4
	AgeGridDir=${CurrentDirectory}/Agegrid-M21
	CratonicShapes=${CurrentDirectory}/Cratonic-Shapes-M21
	root_for_Kimb_Data=${CurrentDirectory}/Kimberlites/M21
fi

#For Cases 1,2,3
# root_for_Kimb_Data=/Users/omer/Documents/Programming/PyGplates/Kimberlites

for Age in `seq 0 20 200`; do	
echo $Age

# filexyz=${Case4Dir}/Case4-Radial-Heat-Advection-Between-322km-and-CMB-Averaged-${timeMa}-Ma.xyz
filexyz=${CaseDir}/${CaseNumber}-Radial-Heat-Advection-Between-322km-and-CMB-Averaged-${Age}-Ma.xyz

echo $filexyz

# Introduce names for grid files and output .ps file to be converted to PDF and/or PNG/JPG
psfile=${CaseOutputDir}/${CaseNumber}-Radial-Heat-Advection-Between-322km-and-CMB-Averaged-${Age}-Ma.ps
medianfile=${CaseOutputDir}/${CaseNumber}_Radial-Heat-Advection_between_322km_and_CMB_averaged_${Age}-Ma.median
gridFile=${CaseOutputDir}/${CaseNumber}_Radial-Heat-Advection_between_322km_and_CMB_averaged_${Age}-Ma.nc
gridFile_1_0=${CaseOutputDir}/${CaseNumber}_Radial-Heat-Advection_between_322km_and_CMB_averaged_1_and_0_${Age}-Ma.nc
gridFileMasked=${CaseOutputDir}/${CaseNumber}_Radial-Heat-Advection_between_322km_and_CMB_averaged_${Age}masked-Ma.nc


# If Reconstruction is M21 Merdith et al., (2021)
#CratonsM21Folder=/Users/omer/Documents/Programming/PyGplates/Supplement/Reconstructions/M21/CratonsReconstructed
#CratonFile=${CratonsM21Folder}/Cratons_reconstructed_M21_${timeMa}.00Ma.xy


# agegrid=${AgeGridDir}agegridsampled_${timeMa}-Ma.grd
if [ $CaseNumber -eq 4 ]
then
	maskFileRd2=mask_Rd_2${Age}.nc
	CratonicShapesPlot=${CratonicShapes}/Cratons_reconstructed_M21_${Age}.00Ma.xy
	gmt grdmask -Rd -I0.1 $CratonicShapesPlot -N0/1/1 -G$maskFileRd2 
	agegrid=${AgeGridDir}/agegrid_final_with_continents_${AgeMa}.grd
	gmt blockmedian $filexyz -Rd -I0.1 -V > $medianfile
	gmt surface $medianfile -I0.1 -R${region} -V -G$gridFile # Resolution is 0.1 deg.
	gmt grdclip $gridFile -Rd -G$gridFile_1_0 -Sa0.99/1 -Sb0.99/0 -V # Set values equal and above 1 as 1, others as 0.
	rm  $medianfile # remove temporary grid file
	gmt grdmath $maskFileRd2 $gridFile_1_0 MUL = $gridFileMasked
	gmt grdmath $agegrid -0.1 GT = Ocean.grd 
	KimberlitesXY=${root_for_Kimb_Data}/${Age}Ma_kimberlite_locations-M21.xy
	
fi

maskFile=mask_${timeMa}.nc
maskFileRd=mask_Rd_${timeMa}.nc

maskFileM21=mask_M21_${timeMa}.nc	
maskFileM21Rd=mask_M21_Rd_${timeMa}.nc


# gmt sphinterpolate $medianfile -I0.1 -R${region} -V -G$gridFile # Resolution is 0.1 deg.

# gmt grdedit $gridFile -R-180/180/-90/90


#Below for reconstruction M21 
#gmt grdmask -Rd -I0.1 $CratonFile -N0/1/1 -G$maskFileM21 
#gmt grdmask -Rd -I0.1 $CratonFile -N-1/1/1 -G$maskFileM21Rd 


# CoastlinesPlot=${CratonicShapesRootM21}/Coastlines-M21-${timeMa}.00Ma.xy

gmt grdimage -R${region} -J${proj_map} $gridFile -CColourmap-RHA.cpt -t50 -V -K > $psfile
gmt psxy $CratonicShapesPlot -R${region} -J${proj_map} -Gblack -O -V -K >> $psfile 
gmt grdimage -R${region} -J${proj_map} $gridFile -CColourmap-RHA.cpt -t70 -O -V -K >> $psfile

# CoastlinesPlot=${CratonicShapesRootM21}/reconstructed_MerdithCratons_${timeMa}.00Ma.xy

gmt psxy $CratonicShapesPlot -R${region} -J${proj_map}  -W0.2p,black -Ggreen -O -V -K >> $psfile 
gmt grdimage -R${region} -J${proj_map} $gridFile -CColourmap-RHA.cpt -t40 -O -V -K >> $psfile
gmt grdimage -R${region} -J${proj_map} Ocean.grd  -COcean.cpt -t65 -O -V -K >> $psfile
gmt grdimage -R${region} -J${proj_map} $gridFileMasked -CColourmap-RHA_Masked.cpt -t60 -O -V -K >> $psfile

# Add reconstructed kimberlites
# KimberlitesXY=${root_for_Kimb_Data}/XYreconstructed_${timeMa}.00Ma.xy

# KimberlitesXY=${root_for_Kimb_Data}/${Age}Ma_kimberlite_locations-M21.xy
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

