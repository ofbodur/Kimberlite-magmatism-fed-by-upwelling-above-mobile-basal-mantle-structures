#!/bin/bash

# Ömer F. Bodur
# Last Update: 11 July 2022
# University of Wollongong
# Create Distance to Kimberlite maps for both Case 1 and one of Tomog. Models.

region=g
proj_map=N0/12

CaseNumber=4 # Select the case number. Set it to 4 for Tomographic models


# psfile=Reconstructed-Kimberlites-for-the-last-210-Myr-M21-NNR-SMEAN2Background-V2.ps

# gmt pscoast -R$region -J${proj_map} -Dl -W0.15p,black -O -V -K >> $psfile


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
	CratonicShapes="$PWD"/Cratonic-Shapes-M21/Aug-2022/
	root_for_Kimb_Data="$PWD"/Kimberlites/M21/Kimbs-Aug-2022
 	maskFileDir="$PWD"/Masks
	CratonicShapesPlot=${CratonicShapes}/Cratons_reconstructed_${Age}.00Ma.xy

elif [ $CaseNumber -eq 5 ]
then
	CaseDir="$PWD"/Case1
	CaseOutputDir="$PWD"/Output-Case1
	AgeGridDir="$PWD"/Agegrid-M21-NNR
	CratonicShapes="$PWD"/Cratonic-Shapes-M21-NNR
	root_for_Kimb_Data="$PWD"/Kimberlites/M21-NNR
	maskFileDir="$PWD"/Masks

fi

count=1
for Age in `seq 180 20 200`; do	

# TomoGrid=s40rts_2867_Distance_to_Hot.nc # 2775 km depth slice
# TomoGrid=SEMUCB-WM1_2867_Distance_to_Hot.nc # 2867 km depth slice
TomoGrid=SEMUCB-WM1_2867_lmax_12_Distance_to_Hot.nc # 2867 km depth slice, lmax-12 spherical harmonic deg.

# TomoGrid=s40rts_2867_Distance_to_Hot.nc # 2867 km depth slice
# TomoGrid=savani_2818_Distance_to_Hot.nc
# TomoGrid=GypsumS_2900_Distance_to_Hot.nc

# TomoGrid=Case1_WholeMantle_180_Ma_Distance_to_Hot.nc
# TomoGrid=Case2_WholeMantle_180_Ma_Distance_to_Hot.nc
# TomoGrid=Case3_WholeMantle_180_Ma_Distance_to_Hot.nc
# TomoGrid=Case4_WholeMantle_180_Ma_Distance_to_Hot.nc

# psfile=180Ma-Distance-to-Hot-Structures-Map-SEMUCB-WM1-${Age}-Ma-GreenKimbs.ps
psfile=180Ma-Distance-to-Hot-Structures-Map-SEMUCB-WM1-${Age}-Ma-GreenKimbs-lmax-12deg_only_0_05percent.ps

# psfile=180Ma-Distance-to-Hot-Structures-Map-S40RTS-${Age}-Ma-GreenKimbs.ps
# psfile=180Ma-Distance-to-Hot-Structures-Map-GyPSuM-S-${Age}-Ma-GreenKimbs.ps
# psfile=180Ma-Distance-to-Hot-Structures-Map-Case1-WholeMantle-${Age}-Ma-GreenKimbs.ps
# psfile=180Ma-Distance-to-Hot-Structures-Map-Case2-WholeMantle-${Age}-Ma-GreenKimbs.ps
# psfile=180Ma-Distance-to-Hot-Structures-Map-Case3-WholeMantle-${Age}-Ma-GreenKimbs.ps
# psfile=180Ma-Distance-to-Hot-Structures-Map-Case4-WholeMantle-${Age}-Ma-GreenKimbs.ps


# gmt psxy $CratonicShapesPlot -R${region} -J${proj_map} -Gblack -t30 -V -K > $psfile


if [ $CaseNumber -eq 4 ]
then
	# KimberlitesXY=${root_for_Kimb_Data}/${Age}_Ma_kimberlite_locations-M21-API5.xy
	# KimberlitesXY=${root_for_Kimb_Data}/${Age}_Ma_kimberlite_locations-M21-API5-Merdith.xy # Anchor 0, M21
	KimberlitesXY=${root_for_Kimb_Data}/Kimberlites_${Age}_Ma-M21-with-Age.xyz # Anchor 0, M21
	# KimberlitesXY=${root_for_Kimb_Data}/Kimberlites_${Age}_Ma-M21-with-Age.xyz # Anchor 0, M21
	
elif [ $CaseNumber -eq 5 ]
then
	KimberlitesXY=${root_for_Kimb_Data}/${Age}_Ma-M21-NNR-Case4-with-Age.xyz	
	
else
	# KimberlitesXY=${root_for_Kimb_Data}/${Age}Ma_kimberlite_locations-M21-NNR.xy
	KimberlitesXY=${root_for_Kimb_Data}/${Age}_Ma_kimberlite_locations-M21-API5-NNR-New.xy
	
fi

# Add reconstructed kimberlites
# gmt psxy $KimberlitesXY -R${region} -J${proj_map} -Sc0.17 -W0.3p,black -Gwhite -t5 -O -V -K >> $psfile #1)
# gmt psxy $KimberlitesXY -R${region} -J${proj_map} -Sc0.08 -W0.06p,black -Gmagenta  -t3 -O -V -K >> $psfile #2)
# gmt psxy $KimberlitesXY -R${region} -J${proj_map} -Sc0.03 -W0.06p,black -Gblack -t3 -O -V -K >> $psfile #3)

#FOR M21 
CratonicShapesPlot=${CratonicShapes}/Cratons_reconstructed_${Age}.00Ma.xy

#FOR M21-NNR 
# CratonicShapesPlot=${CratonicShapes}/reconstructed_MerdithCratons_${Age}.00Ma.xy

#FOR M21-NNR-Case4
# CratonicShapesPlot=${CratonicShapes}/CratonicBlocksForCase4/reconstructed_${Age}.00Ma.xy


# gmt grdimage -R${region} -J${proj_map} ${TomoGrid} -CDistancecolors.cpt -V -K > $psfile
gmt grdimage -R${region} -J${proj_map} ${TomoGrid} -CcolorsDistance_inferno_ColorMap.cpt -V -K > $psfile
gmt psxy $CratonicShapesPlot -R${region} -J${proj_map}  -Gblack -t70 -O -V -K >> $psfile 

gmt psxy $KimberlitesXY -R${region} -J${proj_map} -Sc0.2 -W0.2p,black -CcolorsKimb_OMER.cpt -O -V -K >> $psfile #1)

# gmt grdcontour -R${region} -J${proj_map} SEMUCB-WM1_2867_lmax_12.nc -A+-0.1 -O -V -K >> $psfile

# gmt grdcontour -R${region} -J${proj_map} SEMUCB-WM1_2867_lmax_12.nc -A+-0.15 -O -V -K >> $psfile

gmt grdcontour -R${region} -J${proj_map} SEMUCB-WM1_2867_lmax_12.nc -A+-0.05 -O -V -K >> $psfile

gmt psbasemap -R${region} -J${proj_map} -Ba90f9/a60f11 -O -V  >> $psfile

gmt psconvert $psfile -A -Tf
gmt psconvert $psfile -A -Tg

rm $psfile

count=$((count +9))

done




