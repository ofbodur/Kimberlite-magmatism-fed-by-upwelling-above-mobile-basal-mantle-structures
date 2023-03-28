# Kimberlite magmatism fed by upwelling above mobile basal mantle structures


![Snapshot-180Ma](https://user-images.githubusercontent.com/10364530/228105477-f059e80d-89d5-4dc3-b978-b3845c862098.png)



![Case1-Radial-Heat-Advection-Between-322km-and-CMB-Averaged-180-Ma-Regular](https://user-images.githubusercontent.com/10364530/227427540-a05fb899-b3b5-4df8-925d-ebf5fe7a36f3.png)


### This is a supplement to the manuscript # NGS-2022-03-00591 currently in revision in Nature Geoscience.
 
This supplement aims at providing users to be able access model outputs as well as to reproduce maps and 3-D images of radial heat advection (RHA). All bash scripts are provided in the main directory.

1. "CreateMap.sh" allows users to access #.xyz files which lists lat/lon/RHA for Cases 1-4 (data given in respective folders with Case name as folder name in this directory) at every 20 Myr between 200 Ma and present day (recreating Figure 2a, Extended Data Figures 3-right column, 4,6), and maps the RHA in Robinson projected coordinates, overlain by reconstructed cratons in grey, and reconstructed kimberlites plotted as filled circles with a colormap varying by time. Outputs (PDF files) are also provided in respective folders "Output-Case#" for reference. The script requires users to choose the model to be processsed as well as mantle region (Upper/Lower/Whole Mantle only for Case 1). ``` CaseNumber=1 # Select the case number ``` 
    Depending on the choice of model and mantle region, some of the parts of the script will need to be commented (or commented out). This information can be found in the explanation lines or comments within the script.

2. "Figure1.sh" allows users to recreate Figure 1a,b. Users need to choose the reconstruction model (M21 or M21 NNR) from the line below: ``` CaseNumber=4 # 4 for M21 (1 for M21-NNR) ```. The script uses different colormaps for tomographic model and age of reconstructed kimberlies, which are also provided in the main directory.

3. "Distance-to-Hot-Map.sh" allows users to create maps of distance to hot structures in tomographic models or distance to RHA field in geodynamic models Cases1-4. User can recreate Extended Data Figure 3a and Extended Data Figure 3 (left column). In its current version, it takes SEMUCB-WM1 tomographic model filtered to maximum spherical harmonic degree 12 (l_max_=12), calculates and maps the angular distance away from the contour dVs=-0.1% towards positive (colder) regions. 

4. Statistical analysis folder

5. Radial Heat Advection folder

Please send me email of your questions or requests regarding this repository at ofbodur@gmail.com (permanent email adrress). 
