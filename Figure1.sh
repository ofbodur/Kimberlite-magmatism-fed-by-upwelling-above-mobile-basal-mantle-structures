#!/bin/bash

# Ömer F. Bodur
# Last Update: 11 July 2022
# University of Wollongong

region=g
proj_map=N0/12

CaseNumber=4 # Select the case number

psfile=${CaseDir}/Case${CaseNumber}-Reconstructed-Kimberlites-for-the-last-210-Myr.ps

gmt pscoast -R$region -J${proj_map} -Dl -W0.24p,black -O -V -K > $psfile


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


if [ $CaseNumber -eq 4 ]
then
	KimberlitesXY=${root_for_Kimb_Data}/${Age}_Ma_kimberlite_locations-M21-API5.xy

else
	KimberlitesXY=${root_for_Kimb_Data}/${Age}Ma_kimberlite_locations-M21-NNR.xy
	
fi

# Add reconstructed kimberlites
gmt psxy $KimberlitesXY -R${region} -J${proj_map} -Sc0.17 -W0.3p,black -Gwhite -t5 -O -V -K >> $psfile #1)
gmt psxy $KimberlitesXY -R${region} -J${proj_map} -Sc0.08 -W0.06p,black -Gmagenta  -t3 -O -V -K >> $psfile #2)
gmt psxy $KimberlitesXY -R${region} -J${proj_map} -Sc0.03 -W0.06p,black -Gblack -t3 -O -V -K >> $psfile #3)


done

gmt psbasemap -R${region} -J${proj_map} -Ba90f9/a60f11 -O -V  >> $psfile

gmt psconvert $psfile -A -Tf



