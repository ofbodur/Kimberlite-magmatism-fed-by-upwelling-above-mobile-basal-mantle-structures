# ¬Kimberlite magmatism fed by upwelling above mobile basal mantle structures



![Case1-Radial-Heat-Advection-Between-322km-and-CMB-Averaged-180-Ma-Regular](https://user-images.githubusercontent.com/10364530/227427540-a05fb899-b3b5-4df8-925d-ebf5fe7a36f3.png)


### This is a supplement to the manuscript # NGS-2022-03-00591 currently in revision in Nature Geoscience.
 
This supplement aims at providing users to be able access model outputs as well as to reproduce maps and 3-D images of radial heat advection (RHA). All bash scripts are provided in the "Scripts" folder in this directory.

1. "./CreateMap.sh" allows users to access #.xyz files which lists lat/lon/RHA for Cases 1-4 (data given in respective folders with Case name as folder name in this directory) at every 20 Myr between 200 Ma and present day (recreating Figure 2a, Extended Data Figures 3-right column, 4,6), and maps the RHA in Robinson projected coordinates, overlain by reconstructed cratons in grey, and reconstructed kimberlites plotted as filled circles with a colormap varying by time. Outputs (PDF files) are also provided in respective folders "Output-Case#" for reference. The script requires users to choose the model to be processsed as well as mantle region (Upper/Lower/Whole Mantle only for Case 1). Depending on the choice of model and mantle region, some of the parts of the script will need to be commented (or commented out). This information can be found in the explanation lines or comments within the script.

2. 
### Please choose case number before running the code in Line 10 of CreateMap.sh as below:

``` CaseNumber=1 # Select the case number ```

The outputs for all cases are provided for reference.


