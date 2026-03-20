# Holzmaar (HZM) Paleoenvironmental Reconstruction Pipeline

A comprehensive R-based analytical framework for high-resolution paleoclimate reconstruction from the Holzmaar volcanic crater lake (Germany). This project integrates X-Ray Fluorescence (XRF), Hyperspectral Imaging (HSI), pollen analysis, and diatom records to investigate the coupling between lacustrine geochemistry and biological productivity during the Late Quaternary, with emphasis on the Late-Glacial transition (ca. 15,000-10,000 BP).

![Status](https://img.shields.io/badge/status-publication%20ready-brightgreen?style=flat-square)
![R Version](https://img.shields.io/badge/R-≥4.0.0-blue?style=flat-square)
![License](https://img.shields.io/badge/license-CC--BY--4.0-lightgrey?style=flat-square)

---

## 🎯 Project Overview

**Holzmaar** is a small volcanic crater lake in the Volcanic Eifel region (Rhineland-Palatinate, Germany) with sediments preserving a continuous paleoclimate record spanning ~23,200 years. This project develops and documents a reproducible analytical pipeline for multi-proxy paleoenvironmental reconstruction, serving as both a scientific contribution and a methodological reference for reproducible paleoclimate research.

### Key Features
- ✅ **High-resolution multi-proxy dataset** (0-23,200 years BP)
- ✅ **Fully reproducible** R-based analysis pipeline (14 documented notebooks)
- ✅ **Publication-ready figures** with automated generation
- ✅ **Open data & code** for transparency and reusability
- ✅ **Modular workflow** allowing selective execution and adaptation

---

## 📊 Dataset & Data Sources

### Primary Data (Holzmaar Core)
| Proxy | File | Resolution | N Observations | Description |
|-------|------|-----------|---|---|
| **XRF** | `HZM_xrf_raw_measurements.xlsx` | 1 mm | ~4,500 | Elemental geochemistry (30+ elements) |
| **HSI** | `HZM_hsi_xrf_calibrated_1mm.xlsx` | 1 mm | ~4,500 | Pigments + calibrated XRF composite |
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

**→ See [ZENODO_DATASET_DESCRIPTION.md](ZENODO_DATASET_DESCRIPTION.md) for complete metadata**

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

## 📖 Data Dictionary & Proxy Significance

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
| **Diatom Assemblages** | pH, temperature | Lake conditions, paleoclimate reconstruction |

---

## 📁 Project Structure

```
Holzmaar2022-2025/
│
├── README.md                              # This file
├── ZENODO_DATASET_DESCRIPTION.md         # Complete dataset metadata
├── ZENODO_SUBMISSION_FORMS.md            # Zenodo submission details
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

## 🚀 Quick Start

### **1. Clone Repository**
```bash
git clone https://github.com/Epta13/Holzmaar2022-2025.git
cd Holzmaar2022-2025
```

### **2. Set Up Environment**

**Option A: Conda (Recommended)**
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

## ⏱️ Execution Order & Dependencies

| Phase | Notebooks | Dependencies | Status |
|-------|-----------|--------------|--------|
| **Independent** | 01, 02, 03, 08, 09 | None | Can run in parallel |
| **Dependent-1** | 04, 05 | 01 | Must follow Phase 1 |
| **Dependent-2** | 06, 07 | 01-03 | Must follow Phase 1-2 |
| **Dependent-3** | 10, 11, 12, 13, 14 | All prior | Run at end |

**→ See [notebooks/README.md](notebooks/README.md) for detailed dependency chain**

---

## 📦 Technical Requirements

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

## 📚 Documentation

| File | Purpose | Audience |
|------|---------|----------|
| **[notebooks/README.md](notebooks/README.md)** | Complete workflow guide | Researchers, developers |
| **[notebooks/QUICKSTART.md](notebooks/QUICKSTART.md)** | 5-minute setup guide | New users |
| **[ZENODO_DATASET_DESCRIPTION.md](ZENODO_DATASET_DESCRIPTION.md)** | Full dataset metadata | Data repository curators |
| **[ZENODO_SUBMISSION_FORMS.md](ZENODO_SUBMISSION_FORMS.md)** | Zenodo submission details | Open science advocates |

---

## 🔄 Reproducibility & Open Science

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

## 🤝 Contributing

Contributions welcome! Please:

1. **Fork the repository**
2. **Create a feature branch** (`git checkout -b feature/your-feature`)
3. **Commit with clear messages** (`git commit -am 'Add new analysis'`)
4. **Push to the branch** (`git push origin feature/your-feature`)
5. **Submit a pull request**

For major changes, please open an issue first to discuss proposed modifications.

---

## 📄 License

This project is licensed under the **Creative Commons Attribution 4.0 International (CC-BY-4.0)** license. See [LICENSE](LICENSE) for details.

**You are free to:**
- Share, copy, and redistribute the material
- Adapt, remix, and build upon the material

**Under the condition that:**
- You give attribution to the original creators
- You indicate what changes were made

---

## 📖 Citation

**For the dataset:**
```bibtex
@dataset{Zahajska_2026_Holzmaar,
  author = {Zahajská, Petra and Others},
  title = {Holzmaar Paleoclimate and Paleoenvironmental Dataset (0-23,200 BP): 
           Multi-proxy Records from a Volcanic Crater Lake, Germany},
  year = {2026},
  publisher = {Zenodo},
  doi = {[your-zenodo-doi]}
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

## 📞 Contact & Support

**Project Lead:** [Your Name]  
**Email:** [Your Email]  
**Affiliation:** [Your Institution]  

For **data questions:** See [ZENODO_DATASET_DESCRIPTION.md](ZENODO_DATASET_DESCRIPTION.md)  
For **analysis questions:** Open an [issue on GitHub](https://github.com/Epta13/Holzmaar2022-2025/issues)  
For **reproducibility support:** See [notebooks/QUICKSTART.md](notebooks/QUICKSTART.md)

---

## 🙏 Acknowledgments

- **Holzmaar core:** [Original core description & dating]
- **Reference sites:** Meerfelder Maar, NGRIP, Alpine lakes
- **Funding:** [Funding agencies if applicable]
- **R Community:** All contributing package developers

---

**Last Updated:** March 20, 2026  
**Status:** Publication Ready ✅  
**DOI:** [Zenodo DOI - add after submission]
