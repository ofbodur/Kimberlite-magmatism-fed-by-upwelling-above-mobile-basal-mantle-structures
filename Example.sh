region = g
proj_map = N0/12


CaseNumber=1 # Select the case number
CurrentDirectory = !pwd
if [ $CaseNumber -eq 1 ]
then 
	# Case1Dir=/Users/omer/Documents/Programming/PyGplates/ForPublication/Case1/
	Case1Dir=${CurrentDirectory}/Case1
	# Case1OutputDir=/Users/omer/Documents/Programming/PyGplates/ForPublication/Output-Case1/
	Case1OutputDir=${CurrentDirectory}/Output-Case1
fi
