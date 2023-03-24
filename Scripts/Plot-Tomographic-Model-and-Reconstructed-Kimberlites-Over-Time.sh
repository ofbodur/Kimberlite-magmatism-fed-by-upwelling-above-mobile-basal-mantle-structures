#!/bin/bash

# Ömer F. Bodur
# Last Update: 11 July 2022
# University of Wollongong

region=g
proj_map=N0/12

CaseNumber=4 # Select the case number 1 for NNR


TomoGrid=SEMUCB-WM1_2867-Neg.nc



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

count=1
for Age in `seq 0 20 210`; do	


if [ $CaseNumber -eq 4 ]
then
	# KimberlitesXY=${root_for_Kimb_Data}/${Age}_Ma_kimberlite_locations-M21-API5.xy
	KimberlitesXY=${root_for_Kimb_Data}/${Age}_Ma_kimberlite_locations-M21-API5-Merdith.xy # Anchor 0, M21
	
else
	# KimberlitesXY=${root_for_Kimb_Data}/${Age}Ma_kimberlite_locations-M21-NNR.xy
	KimberlitesXY=${root_for_Kimb_Data}/${Age}_Ma_kimberlite_locations-M21-API5-NNR-New.xy
	
fi

# Add reconstructed kimberlites
# gmt psxy $KimberlitesXY -R${region} -J${proj_map} -Sc0.17 -W0.3p,black -Gwhite -t5 -O -V -K >> $psfile #1)
# gmt psxy $KimberlitesXY -R${region} -J${proj_map} -Sc0.08 -W0.06p,black -Gmagenta  -t3 -O -V -K >> $psfile #2)
# gmt psxy $KimberlitesXY -R${region} -J${proj_map} -Sc0.03 -W0.06p,black -Gblack -t3 -O -V -K >> $psfile #3)



psfile=Reconstructed-Kimberlites-for-the-last-210-Myr-M21-SEMUCB-WM1-Background-V2_${Age}_Ma.ps

gmt grdimage -R${region} -J${proj_map} ${TomoGrid} -CcolorsLLSVP_OMER.cpt -V -K > $psfile

#gmt pscoast -R$region -J${proj_map} -Dl -W0.25p,black -O -V -K >> $psfile


CratonicShapes="$PWD"/Cratonic-Shapes-M21
#CratonicShapesPlot=${CratonicShapes}/Cratonic-Shapes-M21-API5-reconstructed_${Age}.00Ma.xy
CratonicShapesPlot=${CratonicShapes}/Cratons_reconstructed_${Age}.00Ma.xy
gmt psxy $CratonicShapesPlot -R${region} -J${proj_map} -Gblack -t80 -O -V -K >> $psfile



# Below is the old line, same with Figure1.sh
#gmt psxy $KimberlitesXY -R${region} -J${proj_map} -Sc0.2 -W0.0p,black -CcolorsKimb_OMER.cpt -O -V -K >> $psfile #1)

# USE BELOW LINE FOR AGE CODED COLORS
# gmt psxy $KimberlitesXY -R${region} -J${proj_map} -Sc0.2 -W1.0p,black -CcolorsKimb.cpt -O -V -K >> $psfile #1)
gmt psxy $KimberlitesXY -R${region} -J${proj_map} -Sc0.3 -W1.0p,black -CcolorsKimb_OMER.cpt -O -V -K >> $psfile #1)




#count=$((count +9))
#done

gmt psbasemap -R${region} -J${proj_map} -Ba90f9/a60f11 -O -V  >> $psfile

gmt psconvert $psfile -A -Tf
gmt psconvert $psfile -A -Tg

rm $psfile

count=$((count +9))
done

