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


for Age in `seq 0 20 210`; do	
echo $Age

# For whole mantle
filexyz=${CaseDir}/Case${CaseNumber}-Radial-Heat-Advection-Between-322km-and-CMB-Averaged-${Age}-Ma.xyz

#For Lower mantle only
# filexyz=${CaseDir}/LowerMantle/Case${CaseNumber}-Radial-Heat-Advection-Lower-Mantle-Only-Averaged-${Age}-Ma.xyz

#For Upper mantle only
#filexyz=${CaseDir}/UpperMantle/Case${CaseNumber}-Radial-Heat-Advection-Upper-Mantle-Only-Averaged-${Age}-Ma.xyz

echo $filexyz

#For Whole Mantle Only
# Introduce names for grid files and output .ps file to be converted to PDF and/or PNG/JPG
psfile=${CaseOutputDir}/Case${CaseNumber}-Radial-Heat-Advection-Between-322km-and-CMB-Averaged-${Age}-Ma-Regular.ps
medianfile=${CaseOutputDir}/Case${CaseNumber}_Radial-Heat-Advection_between_322km_and_CMB_averaged_${Age}-Ma.median
gridFile=${CaseOutputDir}/Case${CaseNumber}_Radial-Heat-Advection_between_322km_and_CMB_averaged_${Age}-Ma.nc
gridFile_1_0=${CaseOutputDir}/Case${CaseNumber}_Radial-Heat-Advection_between_322km_and_CMB_averaged_1_and_0_${Age}-Ma.nc
gridFileMasked=${CaseOutputDir}/Case${CaseNumber}_Radial-Heat-Advection_between_322km_and_CMB_averaged_${Age}masked-Ma.nc


#For Lower Mantle Only
# Introduce names for grid files and output .ps file to be converted to PDF and/or PNG/JPG
# psfile=${CaseOutputDir}/Case${CaseNumber}-Radial-Heat-Advection-Lower-Mantle-Only-Averaged-${Age}-Ma-ReviewAug.ps
# medianfile=${CaseOutputDir}/Case${CaseNumber}_Radial-Heat-Advection-Lower-Mantle-Only-Averaged_${Age}-Ma.median
# gridFile=${CaseOutputDir}/Case${CaseNumber}_Radial-Heat-Advection-Lower-Mantle-Only-Averaged_${Age}-Ma.nc
# gridFile_1_0=${CaseOutputDir}/Case${CaseNumber}_Radial-Heat-Advection-Lower-Mantle-Only-Averaged_1_and_0_${Age}-Ma.nc
# gridFileMasked=${CaseOutputDir}/Case${CaseNumber}_Radial-Heat-Advection-Lower-Mantle-Only-Averaged_${Age}masked-Ma.nc
#

#For Upper Mantle Only
#Introduce names for grid files and output .ps file to be converted to PDF and/or PNG/JPG
#psfile=${CaseOutputDir}/Case${CaseNumber}-Radial-Heat-Advection-Upper-Mantle-Only-Averaged-${Age}-Ma-ReviewAug.ps
#medianfile=${CaseOutputDir}/Case${CaseNumber}_Radial-Heat-Advection-Upper-Mantle-Only-Averaged_${Age}-Ma.median
#gridFile=${CaseOutputDir}/Case${CaseNumber}_Radial-Heat-Advection-Upper-Mantle-Only-Averaged_${Age}-Ma.nc
#gridFile_1_0=${CaseOutputDir}/Case${CaseNumber}_Radial-Heat-Advection-Upper-Mantle-Only-Averaged_1_and_0_${Age}-Ma.nc
#gridFileMasked=${CaseOutputDir}/Case${CaseNumber}_Radial-Heat-Advection-Upper-Mantle-Only-Averaged_${Age}masked-Ma.nc


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
	gmt grdmask -Rd -fc -I0.1 $CratonicShapesPlot -N0/1/1 -G$maskFileRd2  # added -fg
	agegrid=${AgeGridDir}/agegridsampled_${Age}-Ma.grd
	gmt blockmedian $filexyz -Rg -I0.1 -V > $medianfile
	gmt surface $medianfile -I0.1 -R${region} -V -G$gridFile # Resolution is 0.1 deg.
	gmt grdclip $gridFile -Rg -G$gridFile_1_0 -Sa0.99/1 -Sb0.99/0 -V # Set values equal and above 1 as 1, others as 0.
	gmt grdedit $gridFile_1_0 -Rd -S # change grid format
	gmt grdmath $maskFileRd2 $gridFile_1_0 MUL = $gridFileMasked # Make sure they have the same format
	gmt grdmath $agegrid -0.1 GT = Ocean.grd 
	KimberlitesXY=${root_for_Kimb_Data}/${Age}Ma_kimberlite_locations-M21-NNR.xy
	
fi

# Radial Heat Advection Imaging
gmt psxy $CratonicShapesPlot -R${region} -J${proj_map} -Gblack -t30 -V -K > $psfile 

gmt grdimage -R${region} -J${proj_map} $gridFile -CColourmap-RHA.cpt -t30 -O -V -K >> $psfile


# gmt grdimage -R${region} -J${proj_map} $gridFile -CColourmap-RHA.cpt -t70 -O -V -K >> $psfile
# gmt psxy $CratonicShapesPlot -R${region} -J${proj_map}  -W0.2p,black -Gwhite -O -V -K >> $psfile
# gmt grdimage -R${region} -J${proj_map} $gridFile -CColourmap-RHA.cpt -t40 -O -V -K >> $psfile
# gmt grdimage -R${region} -J${proj_map} Ocean.grd  -COcean.cpt -t65 -O -V -K >> $psfile
# gmt grdimage -R${region} -J${proj_map} $gridFileMasked -CColourmap-RHA_Masked.cpt -t50 -O -V -K >> $psfile


# Kimberlites colored by Age
root_for_Kimb_Data="$PWD"/Kimberlites/M21-NNR
KimberlitesXY=${root_for_Kimb_Data}/${Age}_Ma_kimberlite_locations-M21-API5-NNR-New.xy
# USE BELOW LINE FOR AGE CODED COLORS
# gmt psxy $KimberlitesXY -R${region} -J${proj_map} -Sc0.2 -W1.0p,black -CcolorsKimb.cpt -O -V -K >> $psfile #1)
gmt psxy $KimberlitesXY -R${region} -J${proj_map} -Sc0.3 -W1.0p,black -CcolorsKimb_OMER.cpt -O -V -K >> $psfile #1)


# USE BELOW FOR CONSTANT COLOR (EXTENDED DATA FIG)
# gmt psxy $KimberlitesXY -R${region} -J${proj_map} -Sc0.2 -W1.0p,black -CcolorsKimbConstant.cpt -O -V -K >> $psfile #1)


# gmt mapproject $KBSlice -R${region} -E -I > KBSlice.xy
# USE BELOW LINE FOR AGE CODED COLORS

# gmt psxy $KimberlitesXY -R${region} -J${proj_map} -Sc0.2 -W1.0p,black -CcolorsKimb.cpt -O -V -K >> $psfile #1)
gmt psxy $KimberlitesXY -R${region} -J${proj_map} -Sc0.3 -W0.7p,black -CcolorsKimb_OMER.cpt -O -V -K >> $psfile #1)
	
# USE BELOW FOR CONSTANT COLOR (EXTENDED DATA FIG)
# gmt psxy $KimberlitesXY -R${region} -J${proj_map} -Sc0.2 -W1.0p,black -CcolorsKimbConstant.cpt -O -V -K >> $psfile #1)


KBSlice="$PWD"/Cross-Section-Coords/KB-Cross-Sections.xy
AFSlice="$PWD"/Cross-Section-Coords/AF-Cross-Sections.xy
#
#if [ $Age -eq 180 ]
#then
	
# gmt psxy $KBSlice -Rd -J${proj_map} -W0.7p,black -O -V -K >> $psfile #1)
#gmt psxy $AFSlice -Rd -J${proj_map} -W1.7p,black -O -V -K >> $psfile #1)
#fi
#continue
# Add reconstructed kimberlites - OLD
# gmt psxy $KimberlitesXY -R${region} -J${proj_map} -Sc0.17 -W0.3p,black -Gwhite -t5 -O -V -K >> $psfile #1)
# gmt psxy $KimberlitesXY -R${region} -J${proj_map} -Sc0.08 -W0.06p,black -Gmagenta  -t3 -O -V -K >> $psfile #2)
# gmt psxy $KimberlitesXY -R${region} -J${proj_map} -Sc0.03 -W0.06p,black -Gblack -t3 -O -V -K >> $psfile #3)


gmt psbasemap -R${region} -J${proj_map} -Ba90f9/a60f11 -O -V  >> $psfile

gmt psconvert $psfile -A -Tf
gmt psconvert $psfile -A -Tg

rm $medianfile
# rm $gridFileMasked
rm $psfile

done

