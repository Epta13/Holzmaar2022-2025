# Holzmaar Lateglacial Multi-Proxy Paleoclimate Analysis

[![License: CC0-1.0](https://img.shields.io/badge/License-CC0%201.0-lightgrey.svg)](http://creativecommons.org/publicdomain/zero/1.0/)
[![R](https://img.shields.io/badge/R-4.0+-blue.svg)](https://www.r-project.org/)

High-resolution multi-proxy analysis of Lateglacial sediments from Holzmaar maar lake, Germany, covering the period from approximately 15,000 to 11,000 calibrated years before present (cal yr BP).

## Project Overview

This repository contains the complete analytical workflow for a high-resolution paleoenvironmental study of the Holzmaar maar lake sediments. The study integrates multiple proxies to reconstruct environmental conditions during the Lateglacial period, including the Pleniglacial, Bølling-Allerød interstadial, and Younger Dryas cold reversal.

### Key Features

- **High-resolution XRF data** (1 mm resolution) for geochemical analysis
- **Hyperspectral imaging (HSI)** data for sediment composition
- **Sedimentary pigment analysis** for primary production reconstruction
- **Diatom assemblages** as indicators of lake conditions
- **Pollen data** for vegetation and climate reconstruction (including modeled extension using Meerfelder Maar data)
- **Statistical analyses**: PCA, clustering (CONISS), RDA, and correlation analyses
- **Integration with external proxies**: NGRIP ice core, insolation, GDGT temperature proxies

## Study Period

The analyses focus on the Lateglacial transition:
- **Pleniglacial** (before ~14,700 cal yr BP)
- **Bølling** (~14,700-14,000 cal yr BP)
- **Allerød** (~14,000-12,900 cal yr BP)
- **Younger Dryas** (~12,900-11,700 cal yr BP)

## Repository Structure
.
├── data/ # Data files
│ ├── SourceData/ # Original source data
│ │ ├── External/ # External proxy data
│ │ │ └── csvs/ # CSV versions of external data
│ │ ├── HZM19_LG_section_XRF.xlsx
│ │ ├── HZM_HSI-XRF_1mm_calibrated.xlsx
│ │ ├── LR_data.xlsx # Low-resolution data
│ │ └── Pollen_Litt_Usinger_stacked.xlsx
│ ├── *_cleaned.csv # Processed data
│ └── *_interpolated.csv # Interpolated datasets
│
├── notebooks/ # Analysis notebooks (numbered workflow)
│ ├── 01_XRF_norm_clr.Rmd # XRF data normalization (CLR transformation)
│ ├── 02_ProxyProxy.Rmd # Proxy-proxy correlations
│ ├── 03_Interpolation.Rmd # Data interpolation
│ ├── 04_ClusteringAndPCA_XRF.Rmd # XRF clustering and PCA
│ ├── 05_Plotting_XRF_clusters.Rmd # XRF visualization
│ ├── 06_ClusteringAndPCA_MergedDatasets.Rmd
│ ├── 07_LowRes_data_prep.Rmd # Low-res data preparation & Figure 2
│ ├── 08_Interpolation_External.Rmd # External data interpolation
│ ├── 09_RDA-Fig3_inUse.Rmd # RDA analysis & Figure 3
│ ├── 10_DiscucssionPlot.Rmd # Discussion figure
│ ├── 11_Combined_Figure.Rmd # Combined figure assembly
│ ├── Pollen_modelling.Rmd # Pollen data modeling
│ └── Functions/ # Utility functions
│ ├── series5_functions.R
│ ├── user_functions.r
│ └── utility_functions.r
│
├── figs/ # Generated figures
│
├── environment.yml # Conda environment
├── requirements.txt # Python dependencies
├── install.R # R package installation
└── Dockerfile # Docker container definition


## Methods

### Data Processing

1. **XRF Data Normalization**: Centered log-ratio (CLR) transformation for compositional data analysis
2. **Data Interpolation**: Standardization of different temporal resolutions
3. **Statistical Transformations**: Additive log-ratio (ALR) for pigment data

### Statistical Analyses

- **Principal Component Analysis (PCA)**: Dimensionality reduction and pattern identification
- **Hierarchical Clustering (CONISS)**: Stratigraphic zonation
- **Redundancy Analysis (RDA)**: Constrained ordination with external environmental variables
- **Correlation Analysis**: Proxy-proxy relationships
- **Pollen Modeling**: Extension of Holzmaar pollen record using Meerfelder Maar data with scaling factors

### External Proxies

- NGRIP δ18O (ice core climate proxy)
- Solar insolation (orbital forcing)
- GDGT-based temperature reconstructions
- Pollen data from Meerfelder Maar (nearby lake)
- Regional pollen records (Egelsee, Gerzensee)

## Installation & Setup

### Requirements

- R (≥ 4.0)
- Python (≥ 3.8) - for specific analyses
- RStudio (recommended)

### R Packages

Key packages include: `vegan`, `FactoMineR`, `factoextra`, `rioja`, `ggplot2`, `dplyr`, `tidyr`, `readxl`, `corrplot`, and others.

Install packages using:
```r
# Install pacman if not already installed
if (!require("pacman")) install.packages("pacman")

# Install all required packages
pacman::p_load("vegan", "factoextra", "FactoMineR", "ggsci", "readxl", 
               "dplyr", "ggplot2", "grid", "ggvegan", "BiodiversityR", 
               "ggrepel", "ggforce", "tibble", "tidyr", "openxlsx", "car", 
               "rstatix", "DT", "data.table", "reshape2", "psych", "cluster", 
               "dendroextras", "rioja", "mclust", "corto", "corrplot", 
               "ggpubr", "bruceR")

Using Conda Environment
conda env create -f environment.yml
conda activate base

Using Docker
docker build -t holzmaar .
docker run -p 8787:8787 holzmaar
# Then open browser to http://localhost:8787

Usage
The analysis workflow is organized in numbered notebooks that should be run sequentially:

01_XRF_norm_clr.Rmd: Start here - normalizes XRF data using CLR transformation
02_ProxyProxy.Rmd: Explores correlations between different proxies
03_Interpolation.Rmd: Interpolates data to common depth/age scales
04_ClusteringAndPCA_XRF.Rmd: Hierarchical clustering and PCA of XRF data
05_Plotting_XRF_clusters.Rmd: Visualizes XRF clusters and selected elements
06_ClusteringAndPCA_MergedDatasets.Rmd: Combined analysis of multiple proxies
07_LowRes_data_prep.Rmd: Prepares low-resolution data (pigments, diatoms) and creates Figure 2
08_Interpolation_External.Rmd: Prepares external proxy data for analysis
09_RDA-Fig3_inUse.Rmd: Main RDA analysis and Figure 3 generation
10_DiscucssionPlot.Rmd: Creates discussion figure
11_Combined_Figure.Rmd: Assembles final combined figure
Pollen_modelling.Rmd: (Optional) Extends pollen record using Meerfelder Maar data
Each notebook is self-contained with code chunks that can be executed in RStudio. Open the .Rmd files in RStudio and run chunks sequentially, or knit the entire document.

Quick Start
# Open RStudio in the project directory
# File > Open Project > holzmaar.Rproj

# Run notebooks in order, starting with:
rmarkdown::render("notebooks/01_XRF_norm_clr.Rmd")

Key Results
The multi-proxy analysis reveals:

Distinct environmental phases corresponding to the Lateglacial climatic transitions
High-resolution reconstruction of lake productivity, anoxia, and catchment dynamics
Correlation between regional climate signals (NGRIP) and local environmental response
Integration of high-resolution geochemical data (XRF, HSI) with biological proxies
Identification of the Laacher See Tephra (LST) layer
Trajectory analysis showing evolution from minerogenic/allochthonous to organic/autochthonous sediment
Data Availability
Raw data: Located in SourceData
Processed data: Cleaned and interpolated files in data
Figures: Generated outputs in figs
All source data and code are provided to ensure full reproducibility of the analyses.

Citation
If you use this code or data, please cite:
@software{holzmaar_analysis_2026,
  author = {Your Name},
  title = {Holzmaar Lateglacial Multi-Proxy Paleoclimate Analysis},
  year = {2026},
  url = {https://github.com/yourusername/Holzmaar2022-2025}
}

License
This work is licensed under CC0 1.0 Universal (Public Domain). You are free to use, modify, and distribute this work without restriction.

Authors
Petra Zahajská - University of Bern
petra.zahajska at unibe.ch


Acknowledgments
Holzmaar and Meerfelder Maar sediment core retrieval and sampling
External proxy data sources:
    NGRIP ice core data
    Insolation calculations
    Regional pollen records (Litt & Usinger)
    GDGT temperature reconstructions
Statistical analysis support and methods development

Contributing
This repository contains the analysis code for a published/submitted manuscript. Questions or suggestions can be directed via GitHub issues or to petra.zahajska at unibe.ch.

Related Publications
