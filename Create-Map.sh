#!/bin/bash

# Ömer F. Bodur
# Last Update: 24 May 2022
# University of Wollongong

region=g
proj_map=N0/12

CaseNumber=1 # Select the case number

if [ $CaseNumber -eq 1 ]
then 
	CaseDir="$PWD"/Case1
	CaseOutputDir="$PWD"/Output-Case1
	AgeGridDir="$PWD"/Agegrid-M21-NNR
	CratonicShapes="$PWD"/Cratonic-Shapes-M21-NNR
	root_for_Kimb_Data="$PWD"/Kimberlites/M21-NNR
	maskFileDir="$PWD"/Masks
	
elif [ $CaseNumber -eq 2 ]
then
	CaseDir="$PWD"/Case2
	CaseOutputDir="$PWD"/Output-Case2
	AgeGridDir="$PWD"/Agegrid-M21-NNR
	CratonicShapes="$PWD"/Cratonic-Shapes-M21-NNR
	root_for_Kimb_Data="$PWD"/Kimberlites/M21-NNR
	maskFileDir="$PWD"/Masks

elif [ $CaseNumber -eq 3 ]
then
	CaseDir="$PWD"/Case3
	CaseOutputDir="$PWD"/Output-Case3
	AgeGridDir="$PWD"/Agegrid-M21-NNR
	CratonicShapes="$PWD"/Cratonic-Shapes-M21-NNR
	root_for_Kimb_Data="$PWD"/Kimberlites/M21-NNR
	maskFileDir="$PWD"/Masks
	
elif [ $CaseNumber -eq 4 ]
then
	CaseDir="$PWD"/Case4
	echo $CaseDir
	CaseOutputDir="$PWD"/Output-Case4
	AgeGridDir="$PWD"/Agegrid-M21
	CratonicShapes="$PWD"/Cratonic-Shapes-M21
	root_for_Kimb_Data="$PWD"/Kimberlites/M21
 	maskFileDir="$PWD"/Masks

fi


for Age in `seq 0 20 200`; do	
echo $Age

filexyz=${CaseDir}/Case${CaseNumber}-Radial-Heat-Advection-Between-322km-and-CMB-Averaged-${Age}-Ma.xyz

echo $filexyz

# Introduce names for grid files and output .ps file to be converted to PDF and/or PNG/JPG
psfile=${CaseOutputDir}/Case${CaseNumber}-Radial-Heat-Advection-Between-322km-and-CMB-Averaged-${Age}-Ma.ps
medianfile=${CaseOutputDir}/Case${CaseNumber}_Radial-Heat-Advection_between_322km_and_CMB_averaged_${Age}-Ma.median
gridFile=${CaseOutputDir}/Case${CaseNumber}_Radial-Heat-Advection_between_322km_and_CMB_averaged_${Age}-Ma.nc
gridFile_1_0=${CaseOutputDir}/Case${CaseNumber}_Radial-Heat-Advection_between_322km_and_CMB_averaged_1_and_0_${Age}-Ma.nc
gridFileMasked=${CaseOutputDir}/Case${CaseNumber}_Radial-Heat-Advection_between_322km_and_CMB_averaged_${Age}masked-Ma.nc


if [ $CaseNumber -eq 4 ]
then
	maskFileRd2=${maskFileDir}/mask_Rd_M21_${Age}.nc
	CratonicShapesPlot=${CratonicShapes}/Cratonic-Shapes-M21-API5-reconstructed_${Age}.00Ma.xy
	gmt grdmask -Rd -I0.1 $CratonicShapesPlot -N0/1/1 -G$maskFileRd2 
	agegrid=${AgeGridDir}/agegrid_final_with_continents_${Age}.grd
	gmt blockmedian $filexyz -Rd -I0.1 -V > $medianfile
	gmt surface $medianfile -I0.1 -R${region} -V -G$gridFile # Resolution is 0.1 deg.
	gmt grdclip $gridFile -Rd -G$gridFile_1_0 -Sa0.99/1 -Sb0.99/0 -V # Set values equal and above 1 as 1, others as 0.
	gmt grdmath $maskFileRd2 $gridFile_1_0 MUL = $gridFileMasked
	gmt grdmath $agegrid -0.1 GT = Ocean.grd 
	KimberlitesXY=${root_for_Kimb_Data}/${Age}_Ma_kimberlite_locations-M21-API5.xy

else
	maskFileRd2=${maskFileDir}/mask_M21_NNR_${Age}.nc
	CratonicShapesPlot=${CratonicShapes}/reconstructed_MerdithCratons_${Age}.00Ma.xy
	gmt grdmask -Rg -I0.1 $CratonicShapesPlot -N0/1/1 -G$maskFileRd2 
	agegrid=${AgeGridDir}/agegridsampled_${Age}-Ma.grd
	gmt blockmedian $filexyz -Rg -I0.1 -V > $medianfile
	gmt surface $medianfile -I0.1 -R${region} -V -G$gridFile # Resolution is 0.1 deg.
	gmt grdclip $gridFile -Rg -G$gridFile_1_0 -Sa0.99/1 -Sb0.99/0 -V # Set values equal and above 1 as 1, others as 0.
	gmt grdmath $maskFileRd2 $gridFile_1_0 MUL = $gridFileMasked
	gmt grdmath $agegrid -0.1 GT = Ocean.grd 
	KimberlitesXY=${root_for_Kimb_Data}/${Age}Ma_kimberlite_locations-M21-NNR.xy
	
fi


# Radial Heat Advection Imaging
gmt grdimage -R${region} -J${proj_map} $gridFile -CColourmap-RHA.cpt -t50 -V -K > $psfile
gmt psxy $CratonicShapesPlot -R${region} -J${proj_map} -Gblack -O -V -K >> $psfile 
gmt grdimage -R${region} -J${proj_map} $gridFile -CColourmap-RHA.cpt -t70 -O -V -K >> $psfile


gmt psxy $CratonicShapesPlot -R${region} -J${proj_map}  -W0.2p,black -Ggreen -O -V -K >> $psfile 
gmt grdimage -R${region} -J${proj_map} $gridFile -CColourmap-RHA.cpt -t40 -O -V -K >> $psfile
gmt grdimage -R${region} -J${proj_map} Ocean.grd  -COcean.cpt -t65 -O -V -K >> $psfile
gmt grdimage -R${region} -J${proj_map} $gridFileMasked -CColourmap-RHA_Masked.cpt -t60 -O -V -K >> $psfile

# Add reconstructed kimberlites
gmt psxy $KimberlitesXY -R${region} -J${proj_map} -Sc0.17 -W0.3p,black -Gwhite -t5 -O -V -K >> $psfile #1)
gmt psxy $KimberlitesXY -R${region} -J${proj_map} -Sc0.08 -W0.06p,black -Gmagenta  -t3 -O -V -K >> $psfile #2)
gmt psxy $KimberlitesXY -R${region} -J${proj_map} -Sc0.03 -W0.06p,black -Gblack -t3 -O -V -K >> $psfile #3)


gmt psbasemap -R${region} -J${proj_map} -Ba90f9/a60f11 -O -V  >> $psfile

gmt psconvert $psfile -A -Tf

rm $medianfile
rm $gridFileMasked
rm $psfile

done

