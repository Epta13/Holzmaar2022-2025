# Holzmaar Paper 

This directory contains fully documented, reproducible R notebooks for the Holzmaar paleoclimate and paleoenvironmental reconstruction project.

## Notebook Overview

### Data Processing Pipeline

1. **01_XRF_norm_clr.Rmd** - XRF Data Normalization and CLR Transformation
   - Loads ITRAX XRF data and HSI data
   - Performs normalization (% counts)
   - Applies Centered Log Ratio (CLR) and Additive Log Ratio (ALR) transformations
   - Outputs: XRF_HZM_norm.xlsx, XRF_HZM_clr.xlsx, XRF_HZM_alr.xlsx

2. **02_ProxyProxy.Rmd** - Proxy-Proxy Correlations
   - Analyzes correlations between different paleoclimate proxies
   - Identifies co-variation patterns

3. **03_Interpolation.Rmd** - Depth Interpolation and Alignment
   - Aligns high-resolution data to common depth scale
   - Interpolates where necessary

4. **04_ClusteringAndPCA_XRF.Rmd** - XRF Clustering and PCA Analysis
   - Performs Principal Component Analysis
   - K-means clustering (k=5)
   - Outputs: XRF_clustered_PC.xlsx (required by downstream notebooks)

5. **05_Plotting_XRF_clusters.Rmd** - XRF Cluster Visualization
   - Creates stratigraphic plots of XRF clusters
   - Requires output from notebook 04

6. **06_ClusteringAndPCA_MergedDatasets.Rmd** - Merged Dataset Analysis
   - PCA on combined XRF+proxy datasets
   - Clustering on merged data

7. **07_LowRes_data_prep.Rmd** - Low-Resolution Data Preparation
   - Prepares external low-resolution data
   - Creates diatom datasets for analysis

8. **08_Pollen_modelling.Rmd** - Pollen Modelling
   - Generates modelled pollen predictions extending coverage (13258-10995 BP)
   - Scales Meerfelder Maar reference site to Holzmaar paleoclimate
   - Outputs: HolzPol_predicted_13258-10995.csv

9. **09_Sequential_Extraction_Plots.Rmd** - Sequential Extraction Visualization
   - Creates stratigraphic plots of sequential extraction data
   - Shows element fractionation patterns (Fe, Mn, P redox cycling)

10. **10_Interpolation_External.Rmd** - External Data Interpolation
    - Interpolates external proxy records to Holzmaar depth scale
    - Requires low-res data from notebook 07

11. **11_RDA-Fig3_inUse.Rmd** - RDA Analysis and Figure 3
    - Redundancy analysis of environmental drivers
    - Creates Fig3 for publication

12. **12_DiscucssionPlot.Rmd** - Discussion Figure Compilation
    - Creates comprehensive multiproxy discussion figure
    - Integrates all proxy records and modelled pollen

13. **13_DiscucssionPlot_PinusBetula.Rmd** - Pollen Panel Export
    - Creates standalone Pinus + Betula comparison figure
    - Shows modelled data integration

14. **14_Combined_Figure.Rmd** - Final Combined Publication Figure
    - Assembles all panels for publication
    - Final size and formatting

## Execution Order

### Independent notebooks (can run first):
- 01_XRF_norm_clr.Rmd
- 02_ProxyProxy.Rmd
- 03_Interpolation.Rmd
- 08_Pollen_modelling.Rmd
- 09_Sequential_Extraction_Plots.Rmd

### Dependent notebooks (must follow others):
- 04_ClusteringAndPCA_XRF.Rmd (requires: 01)
- 05_Plotting_XRF_clusters.Rmd (requires: 04)
- 06_ClusteringAndPCA_MergedDatasets.Rmd (requires: 01, 02, 03)
- 07_LowRes_data_prep.Rmd (requires: 02)
- 10_Interpolation_External.Rmd (requires: 07)
- 11_RDA-Fig3_inUse.Rmd (requires: 01, 02, 03)
- 12_DiscucssionPlot.Rmd (requires: 01, 04, 05, 10, 08_Pollen_modelling)
- 13_DiscucssionPlot_PinusBetula.Rmd (requires: 12_DiscucssionPlot)
- 14_Combined_Figure.Rmd (requires: 12_DiscucssionPlot, 09_Sequential_Extraction)

## System Requirements

### R Version
- R >= 4.0.0

### Required Libraries

**Data Manipulation:**
- tidyverse (dplyr, tidyr, ggplot2)
- readxl, openxlsx
- data.table

**Statistical Analysis:**
- vegan (multivariate ecology)
- cluster (clustering algorithms)
- ape (phylogenetics)
- lme4 (mixed models)
- bruceR (utility functions including LOOKUP)

**Visualization:**
- ggplot2, cowplot, patchwork
- ggpattern (patterned fills)
- gridExtra

**Spatial/Temporal:**
- sp, raster (spatial data)
- zoo (time series)
- approx functions for interpolation

**Other:**
- stats, utils, grDevices (base R)

### Installation

All required packages can be installed via:
```r
packages <- c("tidyverse", "readxl", "openxlsx", "vegan", "cluster", "ape", 
              "lme4", "bruceR", "cowplot", "patchwork", "ggpattern", "gridExtra",
              "sp", "raster", "zoo", "data.table")
install.packages(packages)
```

## Data Requirements

All input data files must be placed in `../data/` directory relative to notebooks:

- `SourceData/HZM_xrf_raw_measurements.xlsx` - ITRAX XRF measurements
- `SourceData/HZM_hsi_xrf_calibrated_1mm.xlsx` - HSI calibrated data
- `SourceData/External/csvs/*.csv` - External proxy records

## Output Files

All notebooks generate output files in `../figs/` and `../data/` directories:

### Data Outputs:
- `XRF_*.xlsx` - Transformed XRF data (normalized, CLR, ALR)
- `HZM_HR_cleaned.xlsx` - Cleaned high-resolution data
- `*clustered*.xlsx` - Clustering results

### Figure Outputs:
- `FigDiscussion.png/svg` - Main discussion figure
- `Pinus_Betula_pollen_combined.png/svg` - Pollen comparison
- `Sequential_Extraction_*_Flipped.png/svg` - Sequential extraction plots
- Various individual proxy plots

## Contributing

When making modifications:
1. Maintain documentation standards
2. Add version updated dates to headers
3. Include comments for any code changes
4. Test reproducibility before committing

## Citation

If using these notebooks or code, please cite Zahajská, P., García, M. L., Birlo, S., Lami, A., Stebich, M., Schouten, S. J., Schmidhauser, N. R. M. M., Zolitschka, B., Vogel, H., and Grosjean, M.: A high-resolution perspective on climate drivers of lake stratification and phototrophic community dynamics in Late Glacial Central Europe, EGUsphere [preprint], https://doi.org/10.5194/egusphere-2026-1390, 2026 and acknowledge data sources.

