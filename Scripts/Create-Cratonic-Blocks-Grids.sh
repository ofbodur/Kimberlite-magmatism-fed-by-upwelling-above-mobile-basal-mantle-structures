region=g
proj_map=N0/12

CaseDir="$PWD"/Case1
CaseOutputDir="$PWD"/Output-Case1
AgeGridDir="$PWD"/Agegrid-M21-NNR
CratonicShapes="$PWD"/Cratonic-Shapes-M21-NNR
root_for_Kimb_Data="$PWD"/Kimberlites/M21-NNR
maskFileDir="$PWD"/Masks

for Age in `seq 1000 20 1000`; do	
echo $Age
		
maskFileRd2=${maskFileDir}/mask_M21_NNR_${Age}.nc
CratonicShapesPlot=${CratonicShapes}/reconstructed_MerdithCratons_${Age}.00Ma.xy
gmt grdmask -Rd -fc -I0.1 $CratonicShapesPlot -N0/1/1 -G$maskFileRd2  # added -fg

done