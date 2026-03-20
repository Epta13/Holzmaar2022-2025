# Holzmaar (HZM) Paleoenvironmental Reconstruction Pipeline

A comprehensive R-based analytical framework for high-resolution paleoclimate reconstruction from the Holzmaar volcanic crater lake (Germany). This project integrates X-Ray Fluorescence (XRF), Hyperspectral Imaging (HSI), pollen analysis, and diatom records to investigate the coupling between lacustrine geochemistry and biological productivity during the Late Quaternary, with emphasis on the Late-Glacial transition (ca. 15,000-10,000 BP).

![R Version](https://img.shields.io/badge/R-≥4.0.0-blue?style=flat-square)
![License](https://img.shields.io/badge/license-CC--BY--4.0-lightgrey?style=flat-square)
[![launch - renku](https://renkulab.io/renku-badge.svg)](https://renkulab.io/p/snsf-anoxia-project/holzmaar/sessions/01KB3K2R1H43S7YYNCYB9HNN91/start)

---

## Project Overview

**Holzmaar** is a small volcanic crater lake in the Volcanic Eifel region (Rhineland-Palatinate, Germany) with sediments preserving a continuous paleoclimate record spanning ~23,200 years. This project develops and documents a reproducible analytical pipeline for multi-proxy paleoenvironmental reconstruction, serving as both a scientific contribution and a methodological reference for reproducible paleoclimate research.


## Dataset & Data Sources

### Primary Data (Holzmaar Core)
| Proxy | File | Resolution | N Observations | Description |
|-------|------|-----------|---|---|
| **XRF** | `HZM_xrf_raw_measurements.xlsx` | 1 mm | ~4,500 | Elemental geochemistry (30+ elements) |
| **HSI (Full-Resolution)** | `HZM_hsi_composite.xlsx` | 80 μm | ~45,000 | Full hyperspectral imaging dataset |
| **HSI-XRF (Calibrated)** | `HZM_hsi_xrf_calibrated_1mm.xlsx` | 1 mm | ~4,500 | Pigments + calibrated XRF composite |
| **Redox** | `HZM_sequential_extraction_fe_mn_p.xlsx` | Low-res | ~500 | Fe/Mn/P speciation & redox cycling |
| **Pollen** | `holzmaar_pollen_records.csv` | ~30 yr | ~500 | Pollen stratigraphy (measured) |
| **Pollen (modelled)** | `HolzPol_predicted_13258-10995.csv` | ~100 yr | ~2,000 | Gap-filling via calibration |
| **Diatoms** | `HZM_diatom_assemblages.xlsx` | Low-res | ~1,000 | Diatom assemblages & pH proxies |

### External Comparative Data
- **`gdgt_temperature_proxy.csv`**: GDGT temperature calibration (Ragberg-Zander method)
- **`gerzensee_temperature.csv`**: Alpine lake diatom-T record (Switzerland)
- **`egelsee_temperature.csv`**: German Alps diatom-T record
- **`ngrip_oxygen_isotopes.csv`**: NGRIP δ18O ice core (global reference)
- **`insolation_data.csv`**: Orbital forcing calculations
- **Meerfelder Maar records**: Reference pollen sequences for calibration

**→ See [Zenodo Repository](https://zenodo.org/records/18429717) for complete dataset metadata and documentation** (DOI: [10.5281/zenodo.18429716](https://doi.org/10.5281/zenodo.18429716))

---

## 🔬 Analytical Pipeline

The workflow is organized into a **modular, reproducible pipeline**, ensuring transparency from raw data to publication-ready figures.

### **1️⃣ Data Harmonization & Compositional Data Analysis**

**Compositional Data Transformation (CoDA)**
- Implements **Centered Log-Ratio (CLR)** and **Additive Log-Ratio (ALR)** transformations
- Critical for sediment geochemistry to eliminate the "closed-sum" effect
- Ensures statistically valid correlations in element ratios
- *Notebook:* `01_XRF_norm_clr.Rmd`

**Quality Control & Outlier Detection**
- Removes instrument noise and air peaks from XRF data
- Validates data completeness and flags missing values
- *Notebooks:* `01_XRF_norm_clr.Rmd`, `03_Interpolation.Rmd`

**Resolution Alignment & Interpolation**
- Synchronizes disparate datasets (XRF @ 1mm, HSI @ 1mm, external proxies @ variable resolution)
- Uses linear interpolation to common reference scales
- Maintains temporal continuity across >23,000 years
- *Notebooks:* `03_Interpolation.Rmd`, `10_Interpolation_External.Rmd`

### **2️⃣ Multivariate Analysis & Ecological Modeling**

**Zonal Stratigraphy (CONISS)**
- Identifies significant environmental thresholds using **constrained hierarchical clustering**
- Defines boundaries of Bølling-Allerød and Younger Dryas climatic units
- *Notebook:* `04_ClusteringAndPCA_XRF.Rmd`

**Principal Component Analysis (PCA)**
- Reduces dimensionality of 30+ elemental measurements
- Visualizes "State Space" of lake system dynamics
- Identifies stable states and transitions over millennia
- *Notebooks:* `04_ClusteringAndPCA_XRF.Rmd`, `06_ClusteringAndPCA_MergedDatasets.Rmd`

**Redundancy Analysis (RDA)**
- Models relationships between **biological response variables** (pigments, diatoms) and **environmental drivers** (temperature, redox, vegetation)
- Quantifies explanatory power of climate forcing
- *Notebook:* `11_RDA-Fig3_inUse.Rmd`

**Pollen & Vegetation Modeling**
- Statistical prediction of missing pollen data (13,258-10,995 BP)
- Calibration to Meerfelder Maar reference site
- Tracks pioneer species vs. established forest expansion
- Provides catchment-scale vegetation history
- *Notebook:* `08_Pollen_modelling.Rmd`

### **3️⃣ Synthesis & Visualization**

**Stratigraphic Synthesis**
- Integrates geochemical redox markers (Mn/Fe ratios)
- Combines productivity proxies (Chlorophyll-a, Bacteriopheophytin-a)
- Links to external climate drivers (NGRIP, insolation)
- *Notebooks:* `12_DiscucssionPlot.Rmd`, `13_DiscucssionPlot_PinusBetula.Rmd`

**Dynamic Visualizations**
- Time-series stratigraphic plots with automatic dating
- Multi-panel figures optimized for publication (A4 size)
- PCA trajectories, clustering dendrograms, correlation heatmaps
- Pattern-filled publication figures
- *Notebooks:* `05_Plotting_XRF_clusters.Rmd`, `09_Sequential_Extraction_Plots.Rmd`, `14_Combined_Figure.Rmd`

---

## Data Dictionary & Proxy Significance

### **Geochemical Proxies (XRF)**
| Element | Significance | Interpretation |
|---------|--------------|---|
| **Ti, K** | Clastic/minerogenic input | Catchment erosion, physical weathering, precipitation intensity |
| **Fe, Mn** | Redox-sensitive tracers | Sediment oxygenation, decomposition rates, nutrient cycling |
| **Ca** | Authigenic carbonate | Alkalinity, primary productivity, water chemistry |
| **Inc/Coh Ratio** | Organic vs. minerogenic | Lake biological productivity vs. terrestrial input |

### **Biological/Optical Proxies (HSI & Pollen)**
| Proxy | Significance | Interpretation |
|-------|--------------|---|
| **RABD 670** | Chlorophyll-a | Total aquatic primary productivity |
| **RABD 845** | Bacteriopheophytin-a | Photic zone euxinia, anoxia indicators |
| **Betula/Pinus Pollen** | Reforestation | Temperature recovery, climate amelioration |
| **Poaceae Pollen** | Open landscape | Cold/dry periods, reduced forest cover |
| **Diatom Assemblages** | primary producers community and nutrient availability| Lake conditions, paleoenvironment reconstruction |

---

## Project Structure

```
Holzmaar2022-2025/
│
├── README.md                              # This file
├── LICENSE                                # CC-BY-4.0 License
│
├── notebooks/                             # Analysis workflows
│   ├── 01_XRF_norm_clr.Rmd               # Data harmonization & CoDA
│   ├── 02_ProxyProxy.Rmd                 # Proxy intercorrelations
│   ├── 03_Interpolation.Rmd              # Resolution alignment
│   ├── 04_ClusteringAndPCA_XRF.Rmd       # Zonal stratigraphy & PCA
│   ├── 05_Plotting_XRF_clusters.Rmd      # Visualization
│   ├── 06_ClusteringAndPCA_MergedDatasets.Rmd  # Integrated analysis
│   ├── 07_LowRes_data_prep.Rmd           # External data prep
│   ├── 08_Pollen_modelling.Rmd           # Statistical pollen extension
│   ├── 09_Sequential_Extraction_Plots.Rmd # Redox visualization
│   ├── 10_Interpolation_External.Rmd     # Climate synthesis
│   ├── 11_RDA-Fig3_inUse.Rmd             # Redundancy analysis
│   ├── 12_DiscucssionPlot.Rmd            # Main discussion figure
│   ├── 13_DiscucssionPlot_PinusBetula.Rmd # Pollen export
│   ├── 14_Combined_Figure.Rmd            # Final composites
│   ├── README.md                         # Notebook guide
│   ├── QUICKSTART.md                     # 5-minute setup
│   └── Functions/                        # Utility functions
│       ├── utility_functions.r
│       ├── user_functions.r
│       └── series5_functions.R
│
├── data/
│   ├── SourceData/                       # Raw input files
│   │   ├── HZM_xrf_raw_measurements.xlsx
│   │   ├── HZM_hsi_xrf_calibrated_1mm.xlsx
│   │   ├── HZM_pigment_calibration.xlsx
│   │   ├── HZM_lowres_redox_diatom_pigment.xlsx
│   │   ├── HZM_pigment_production.xlsx
│   │   ├── HZM_diatom_assemblages.xlsx
│   │   ├── HZM_xrf_depth_scale.csv
│   │   └── External/csvs/               # Reference datasets
│   │       ├── holzmaar_pollen_records.csv
│   │       ├── gdgt_temperature_proxy.csv
│   │       ├── gerzensee_temperature.csv
│   │       ├── egelsee_temperature.csv
│   │       ├── ngrip_oxygen_isotopes.csv
│   │       ├── insolation_data.csv
│   │       ├── meerfelderMaar_*_pollen.csv
│   │       └── [other reference datasets]
│   ├── HolzPol_predicted_13258-10995.csv
│   └── [Processed outputs from notebooks]
│
├── figs/                                 # Output figures
│   ├── discussion_multiplot_*.png/svg
│   ├── Pinus_Betula_pollen_combined.*
│   ├── Sequential_Extraction_*_Flipped.*
│   └── [All publication figures]
│
├── environment.yml                       # Conda environment
├── install.R                             # R package dependencies
├── requirements.txt                      # Python dependencies
└── Dockerfile                            # Container specification
```

---

## Quick Start

### **1. Clone Repository**
```bash
git clone https://github.com/Epta13/Holzmaar2022-2025.git
cd Holzmaar2022-2025
```

### **2. Set Up Environment**

**☁️ Option 0: Renku (Browser-Based | No Installation Required)**
Click here to launch the project directly in your browser with all dependencies pre-configured:

[![Renku Badge](https://renkulab.io/badges/projects.svg)](https://renkulab.io/p/snsf-anoxia-project/holzmaar)

**[Open in Renku](https://renkulab.io/p/snsf-anoxia-project/holzmaar)** — Reproducible data analysis platform. All notebooks run immediately in the cloud without installing anything locally.

---

**Option A: Conda (Recommended for Local Installation)**
```bash
conda env create -f environment.yml
conda activate holzmaar
```

**Option B: R (Direct Installation)**
```r
source("install.R")  # Installs all required packages
```

### **3. Verify Data Files**
Ensure all input files are in `data/SourceData/`:
```bash
ls data/SourceData/*.xlsx
ls data/SourceData/External/csvs/*.csv
```

### **4. Run Notebooks**

**Parallel Execution** (independent notebooks first):
```r
# These can run in any order:
rmarkdown::render("notebooks/01_XRF_norm_clr.Rmd")
rmarkdown::render("notebooks/02_ProxyProxy.Rmd")
rmarkdown::render("notebooks/03_Interpolation.Rmd")
rmarkdown::render("notebooks/08_Pollen_modelling.Rmd")
```

**Sequential Execution** (dependent notebooks):
```r
# Then run these in order:
for (i in c(4, 5, 6, 7, 10, 11, 12, 13, 14)) {
  notebook <- sprintf("notebooks/%02d_*.Rmd", i)
  rmarkdown::render(notebook)
}
```

**Estimated Runtime:** 30-60 minutes total (parallel execution recommended)

### **5. Check Outputs**
```bash
ls figs/                    # Publication figures
ls data/*.xlsx              # Processed datasets
```

---

##  Execution Order & Dependencies

| Phase | Notebooks | Dependencies | Status |
|-------|-----------|--------------|--------|
| **Independent** | 01, 02, 03, 08, 09 | None | Can run in parallel |
| **Dependent-1** | 04, 05 | 01 | Must follow Phase 1 |
| **Dependent-2** | 06, 07 | 01-03 | Must follow Phase 1-2 |
| **Dependent-3** | 10, 11, 12, 13, 14 | All prior | Run at end |

**→ See [notebooks/README.md](notebooks/README.md) for detailed dependency chain**

---

## Technical Requirements

### **R & Packages**
- **R:** ≥ 4.0.0
- **Core packages:**
  - **Statistics:** vegan, FactoMineR, cluster, rioja, mclust, bruceR
  - **Data wrangling:** tidyverse (dplyr, tidyr, ggplot2), data.table, zoo, readxl, openxlsx
  - **Visualization:** cowplot, patchwork, ggpattern, gridExtra, ggrepel
  - **Utilities:** lme4, ape, sp, raster, EnvStats, psych

### **Python** (Optional)
- Python 3.8+ for ancillary analysis
- Dependencies listed in `requirements.txt`

### **System**
- 4+ GB RAM recommended for full dataset processing
- ~2 GB disk space for intermediate files
- Estimated analysis time: 1-2 hours (parallel execution)

---

## Documentation

| File | Purpose | Audience |
|------|---------|----------|
| **[notebooks/README.md](notebooks/README.md)** | Complete workflow guide | Researchers, developers |
| **[notebooks/QUICKSTART.md](notebooks/QUICKSTART.md)** | 5-minute setup guide | New users |
| **[Zenodo Repository](https://zenodo.org/records/18429717)** | Complete dataset metadata | Data repository & open science |

---

##  Reproducibility & Open Science

✅ **100% Reproducible**
- All code version-controlled with git
- Explicit package versions in environment files
- Deterministic outputs (seeds set in notebooks)
- Complete session info captured

✅ **FAIR Data Principles**
- **Findable:** Published on Zenodo with DOI
- **Accessible:** Open-access repository (CC-BY-4.0)
- **Interoperable:** Standard formats (Excel, CSV, PNG/SVG)
- **Reusable:** Complete metadata & comprehensive documentation

✅ **Version Control**
- Full git history with meaningful commits
- Semantic versioning (v1.0+)
- GitHub releases linked to Zenodo versions

---

##  Contributing

Contributions welcome! Please:

1. **Fork the repository**
2. **Create a feature branch** (`git checkout -b feature/your-feature`)
3. **Commit with clear messages** (`git commit -am 'Add new analysis'`)
4. **Push to the branch** (`git push origin feature/your-feature`)
5. **Submit a pull request**

For major changes, please open an issue first to discuss proposed modifications.

---

## License

This project is licensed under the **Creative Commons Attribution 4.0 International (CC-BY-4.0)** license. See [LICENSE](LICENSE) for details.

**You are free to:**
- Share, copy, and redistribute the material
- Adapt, remix, and build upon the material

**Under the condition that:**
- You give attribution to the original creators
- You indicate what changes were made

---

## Data Sources & References

### Primary Data (Holzmaar Core)

**Holzmaar Pollen Records:**
Litt, T.: Pollen profile THZM4AB, Holzmaar, Germany, https://doi.org/10.1594/PANGAEA.739893, 2010.

### External Comparative Data

**Meerfelder Maar Reference Pollen:**
Litt, T. and Stebich, M.: Pollen counts of sediment core MFM6, https://doi.org/10.1594/PANGAEA.59877, 2001.

**Gerzensee Temperature Record (Alpine Lake, Switzerland):**
Lotter, A. F., Heiri, O., Brooks, S., van Leeuwen, J. F., Eicher, U., and Ammann, B.: Rapid summer temperature changes during Termination 1a: high-resolution multi-proxy climate reconstructions from Gerzensee (Switzerland), *Quaternary Science Reviews*, **36**, 103–113, https://doi.org/10.1016/j.quascirev.2010.06.022, 2012.

**Egelsee Temperature Record (German Alps):**
Larocque-Tobler, I., Heiri, O., and Wehrli, M.: Late Glacial and Holocene temperature changes at Egelsee, Switzerland, reconstructed using subfossil chironomids, *Journal of Paleolimnology*, **43**, 649–666, https://doi.org/10.1007/s10933-009-9358-z, 2009.

**GDGT Temperature Calibration:**
Zander, P. D., Böhl, D., Sirocko, F., Auderset, A., Haug, G. H., and Martínez-García, A.: Reconstruction of warm-season temperatures in central Europe during the past 60,000 years from lacustrine branched glycerol dialkyl glycerol tetraethers (brGDGTs), *Climate of the Past*, **20**, 841–864, https://doi.org/10.5194/cp-20-841-2024, 2024.

**NGRIP Ice Core (Global Climate Reference):**
NGRIP Members: High-resolution record of Northern Hemisphere climate extending into the last interglacial period, *Nature*, **431**, 147–151, https://doi.org/10.1038/nature02805, 2004.

**Insolation Data (Orbital Forcing):**
Laskar, J., Robutel, P., Joutel, F., Gastineau, M., Correia, A. C., and Levrard, B.: A long-term numerical solution for the insolation quantities of the Earth, *Astronomy & Astrophysics*, **428**, 261–285, https://doi.org/10.1051/0004-6361:20041335, 2004.

**Global Holocene Paleotemperature Database:**
Kaufman, D., McKay, N., Routson, C., Erb, M., Davis, B., Heiri, O., Jaccard, S., Tierney, J., Dätwyler, C., Axford, Y., Brussel, T., Cartapanis, O., Chase, B., Dawson, A., de Vernal, A., Engels, S., Jonkers, L., Marsicek, J., Moffa-Sánchez, P., Morrill, C., Orsi, A., Rehfeld, K., Saunders, K., Sommer, P. S., Thomas, E., Tonello, M., Tóth, M., Vachula, R., Andreev, A., Bertrand, S., Biskaborn, B., Bringué, M., Brooks, S., Caniupán, M., Chevalier, M., Cwynar, L., Emile-Geay, J., Fegyveresi, J., Feurdean, A., Finsinger, W., Fortin, M.-C., Foster, L., Fox, M., Gajewski, K., Grosjean, M., Hausmann, S., Heinrichs, M., Holmes, N., Ilyashuk, B., Ilyashuk, E., Juggins, S., Khider, D., Koinig, K., Langdon, P., Larocque-Tobler, I., Li, J., Lotter, A., Luoto, T., Mackay, A., Magyari, E., Malevich, S., Mark, B., Massaferro, J., Montade, V., Nazarova, L., Novenko, E., Pařil, P., Pearson, E., Peros, M., Pienitz, R., Płóciennik, M., Porinchu, D., Potito, A., Rees, A., Reinemann, S., Roberts, S., Rolland, N., Salonen, S., Self, A., Seppä, H., Shala, S., St-Jacques, J.-M., Stenni, B., Syrykh, L., Tarrats, P., Taylor, K., van den Bos, V., Velle, G., Wahl, E., Walker, I., Wilmshurst, J., Zhang, E., and Zhilich, S.: A global database of Holocene paleotemperature records, *Scientific Data*, **7**, https://doi.org/10.1038/s41597-020-0445-3, 2020.

---

## Citation

**For the dataset:**
```bibtex
@dataset{Zahajska_2026_Holzmaar,
  author = {Zahajská, Petra and Others},
  title = {Holzmaar Paleoclimate and Paleoenvironmental Dataset (0-23,200 BP): 
           Multi-proxy Records from a Volcanic Crater Lake, Germany},
  year = {2026},
  publisher = {Zenodo},
  doi = {10.5281/zenodo.18429716}
}
```

**For the analysis pipeline:**
```bibtex
@dataset{Zahajska_2026_HZM_Pipeline,
  author = {Zahajská, Petra and Others},
  title = {Holzmaar (HZM) Paleoenvironmental Reconstruction Pipeline: 
           R-based Analytical Framework},
  year = {2026},
  publisher = {GitHub},
  url = {https://github.com/Epta13/Holzmaar2022-2025}
}
```

---

## Contact & Support

**Project Lead:** Petra Zahajská
**Email:** petra.zahajska.at.unibe.ch 
**Affiliation:** Institute of Geography & Oeschger Centre for Climate Change Research, University of Bern, Bern, Switzerland

For **data questions:** See [Zenodo Repository](https://zenodo.org/records/18429717) (DOI: 10.5281/zenodo.18429716)  
For **analysis questions:** Open an [issue on GitHub](https://github.com/Epta13/Holzmaar2022-2025/issues)  
For **reproducibility support:** See [notebooks/QUICKSTART.md](notebooks/QUICKSTART.md)

---

## Acknowledgments

- **Holzmaar core:** Birlo, S., Tylmann, W., and Zolitschka, B.: Bayesian age–depth modelling applied to varve and radiometric dating to optimize the transfer
of an existing high-resolution chronology to a new composite sediment profile from Holzmaar (West Eifel Volcanic Field, Germany),
Geochronology, 5, 65–90, https://doi.org/10.5194/gchron-5-65-2023, 2023.
- **Reference sites:** Meerfelder Maar, NGRIP, Alpine lakes
- **Funding:** This works was supported by Swiss National Science Foundation 200020_204220
- **R Community:** All contributing package developers

---

**Last Updated:** March 20, 2026  
**DOI:** [10.5281/zenodo.18429716](https://doi.org/10.5281/zenodo.18429716)
