# Holzmaar Paleoclimate and Paleoenvironmental Dataset (0-23,200 BP)

## Dataset Overview

This dataset contains high-resolution, multi-proxy paleoclimate and paleoenvironmental records from Holzmaar, a volcanic crater lake in the Volcanic Eifel region of Rhineland-Palatinate, Germany (50°7′8″N, 6°52′45″E). The lake sediments preserve a continuous record spanning ~23,200 years, providing insights into late Quaternary climate variability, ecosystem dynamics, and environmental change in central Europe.

## Study Site

**Location:** Holzmaar, Volcanic Eifel, Rhineland-Palatinate, Germany  
**Coordinates:** 50°7′8″N, 6°52′45″E  
**Lake Type:** Maar (volcanic crater lake)  
**Lake Dimensions:** Area 6.8 ha; diameter 325 m; average depth 21 m  
**Temporal Coverage:** ~0-23,200 years before present (BP); measured records 0-15,030 BP with modelled extension to 13,258 BP

## Dataset Contents

### Primary Data Files

#### 1. **Elemental Geochemistry (X-ray Fluorescence)**
- **File:** `HZM_xrf_raw_measurements.xlsx`
- **Description:** Raw elemental counts per second from ITRAX core scanner
- **Covered Elements:** Fe, K, Ca, Ti, Mn, P, Si, S, Cl, and others
- **Resolution:** ~1 mm
- **Analytical Method:** X-ray fluorescence (XRF) using ITRAX core scanner
- **Use:** Elemental composition tracking, redox cycling, terrigenous input

#### 2. **Hyperspectral Imaging (HSI) and Pigments**
- **File:** `HZM_hsi_xrf_calibrated_1mm.xlsx`
- **Description:** Calibrated high-resolution combined HSI and XRF dataset
- **Pigments Measured:** Chlorophyll derivatives, carotenoids, bacteriopheophytin-a, total chlorophyll
- **Calibration:** Spectrophotometer standards (files: bacteriopheophytin_a_hplc.png, total_chlorophyll_hplc.png, phycocyanin_fluorescence.png)
- **Resolution:** 1 mm
- **Use:** Productivity indicators, phytoplankton community composition, primary production

#### 3. **Pigment Calibration Standards**
- **File:** `HZM_pigment_calibration.xlsx`
- **Description:** HPLC calibration data for pigment quantification
- **Sheet:** "for_LM" contains calibration relationships
- **Compounds:** Chlorophyll a and derivatives, carotenoids

#### 4. **HSI Composite Data**
- **File:** `HZM_hsi_composite.xlsx`
- **Description:** Hyperspectral imaging composite dataset
- **Use:** Spectral reflectance analysis, pigment calibration

#### 5. **Redox Geochemistry & Sequential Extraction**
- **File:** `HZM_sequential_extraction_fe_mn_p.xlsx`
- **Description:** Sequential extraction results for iron (Fe), manganese (Mn), and phosphorus (P)
- **Geochemical Phases:** Exchangeable, bound to Fe-Mn oxides, bound to organic matter, residual
- **Resolution:** Low-resolution subset
- **Analytes:** Fe, Mn, P speciation
- **Use:** Paleoredox reconstruction, nutrient cycling, organic matter decomposition

#### 6. **Low-Resolution Integrated Dataset**
- **File:** `HZM_lowres_redox_diatom_pigment.xlsx`
- **Sheets:** 
  - "Redox_Dia_PigOMug": Redox elements, diatoms, pigments (all normalized to organic matter)
  - "Redox_Dia_PigBulk": Same data normalized to bulk sediment weight
  - "Redox_Dia_PigOM": Pigments normalized to organic matter
  - "Pig conversion": Molecular weights for pigment conversions
- **Description:** Compilation of redox-sensitive elements, diatom assemblages, and pigment concentrations at reduced resolution
- **Normalization:** Organic matter (OM) content or bulk sediment mass

#### 7. **Depth Scale**
- **File:** `HZM_xrf_depth_scale.csv`
- **Description:** XRF depth-to-age calibration scale
- **Resolution:** 1 mm intervals
- **Use:** Depth normalization for all high-resolution data

#### 8. **Pollen Records**
- **File:** `holzmaar_pollen_records.csv`
- **Description:** Holzmaar pollen stratigraphy
- **Age Range:** 0-15,030 BP (measured data)
- **Taxa:** Woody and herbaceous pollen, spores
- **Resolution:** Variable, approximately 30-year intervals
- **Modelled Extension:** `HolzPol_predicted_13258-10995.csv` (statistically modelled pollen using Meerfelder Maar calibration)

#### 9. **Pigment Production Rates**
- **File:** `HZM_pigment_production.xlsx`
- **Description:** Calculated pigment production rates with classification
- **Classifications:** Pioneers, secondary colonisers, diatoms + bacteria
- **Note:** Based on 50% threshold analysis

#### 10. **Diatom Assemblages**
- **File:** `HZM_diatom_assemblages.xlsx`
- **Sheets:**
  - Sheet 1: Diatom counts
  - "diatoms_name": Taxon nomenclature
  - "PolZ": Pollen zone designations
- **Description:** Diatom species abundance and classification
- **Resolution:** Low-resolution
- **Use:** Lake productivity, pH, temperature reconstruction

### External Reference Datasets

#### External Paleoclimate Proxies
- **`gdgt_temperature_proxy.csv`**: GDGT-derived temperature estimates (Ragberg-Zander calibration) from Auel-ELSA core, Northern Germany
- **`gerzensee_temperature.csv`**: Diatom-inferred July temperatures from Lake Gerzensee, Switzerland
- **`egelsee_temperature.csv`**: Diatom-inferred temperatures from Lake Egelsee, German Alps
- **`ngrip_oxygen_isotopes.csv`**: NGRIP (North Greenland Ice Core Project) δ18O isotope record
- **`insolation_data.csv`**: Orbital insolation calculations (July and January solar insolation at 50°N)

#### Reference Pollen Datasets
- **`meerfelderMaar_betula_pollen.csv`**: Meerfelder Maar Betula (birch) pollen reference sequence (used for calibration)
- **`meerfelderMaar_pinus_pollen.csv`**: Meerfelder Maar Pinus (pine) pollen reference sequence
- **`meerfelderMaar_herbs_pollen.csv`**: Meerfelder Maar herbaceous pollen reference sequence
- **`Pollen_Litt_Usinger_stacked.xlsx`**: European literature pollen compilation (Usinger reference)
- **`meerfelderMaar_pollen_master.xlsx`**: Complete Meerfelder Maar pollen dataset with age-depth model

### Supporting Documentation
- **YAML metadata** in R notebooks
- **Calibration images**: bacteriopheophytin_a_hplc.png, total_chlorophyll_hplc.png, phycocyanin_fluorescence.png

## Data Processing & Analysis

### Quality Assurance
- All data normalized (% counts, centered log ratio transformations, additive log ratio transformations)
- Missing values handled through interpolation and statistical imputation
- Outliers identified and documented

### Analytical Methods

1. **X-ray Fluorescence (XRF):** ITRAX core scanner; elemental quantification in counts per second
2. **Hyperspectral Imaging (HSI):** Pigment analysis via spectral reflectance; calibrated against HPLC standards
3. **Sequential Extraction:** Standard geochemical fractionation procedure (exchangeable → oxide-bound → organic-bound → residual)
4. **Pollen Analysis:** Standard palynological methods; taxonomic identification to species level where possible
5. **Diatom Analysis:** Standard micropalaeontological methods
6. **Statistical Modelling:** Linear regression, k-means clustering, PCA (Principal Component Analysis), redundancy analysis (RDA)

### Temporal Framework
- **Age Model:** Varve chronology and radiometric dating
- **Age Scale:** Primary age scale in years before present (BP), 1950 reference
- **Precision:** Decadal to centennial resolution depending on proxy type

## Data Organization

### File Structure
```
data/
├── SourceData/
│   ├── HZM_xrf_raw_measurements.xlsx
│   ├── HZM_hsi_xrf_calibrated_1mm.xlsx
│   ├── HZM_hsi_composite.xlsx
│   ├── HZM_pigment_calibration.xlsx
│   ├── HZM_lowres_redox_diatom_pigment.xlsx
│   ├── HZM_pigment_production.xlsx
│   ├── HZM_diatom_assemblages.xlsx
│   ├── HZM_xrf_depth_scale.csv
│   └── External/
│       └── csvs/
│           ├── holzmaar_pollen_records.csv
│           ├── gdgt_temperature_proxy.csv
│           ├── gerzensee_temperature.csv
│           ├── egelsee_temperature.csv
│           ├── ngrip_oxygen_isotopes.csv
│           ├── insolation_data.csv
│           ├── meerfelderMaar_betula_pollen.csv
│           ├── meerfelderMaar_pinus_pollen.csv
│           └── meerfelderMaar_herbs_pollen.csv
├── HolzPol_predicted_13258-10995.csv (modelled pollen extension)
└── [Intermediate processed files]
```

## Reproducibility

Complete reproducibility is ensured through:
1. **R Markdown Notebooks:** 14 fully documented analysis scripts showing all data processing steps
2. **Open-Source Tools:** R with tidyverse, vegan, FactoMineR, ggplot2, and other packages
3. **Dependency Tracking:** Explicit library loading and function sourcing in all notebooks
4. **Version Control:** Complete git history with implementation guides
5. **Session Information:** R version and package details documented in analysis notebooks

### Analysis Workflow
Run notebooks in this order:
1. Independent: 01_XRF_norm_clr, 02_ProxyProxy, 03_Interpolation, 08_Pollen_modelling, 09_Sequential_Extraction_Plots
2. Dependent: 04_ClusteringAndPCA_XRF, 05_Plotting_XRF_clusters
3. Integration: 06_ClusteringAndPCA_MergedDatasets, 07_LowRes_data_prep, 10_Interpolation_External
4. Publication Figures: 11_RDA-Fig3_inUse, 12_DiscucssionPlot, 13_DiscucssionPlot_PinusBetula, 14_Combined_Figure

## Data Types & Units

| Proxy | Variable | Unit | Resolution |
|-------|----------|------|-----------|
| XRF | Elemental counts | counts/second | 1 mm |
| HSI | Pigment absorbance | calibrated units | 1 mm |
| Pollen | Percentage (%) | % of total pollen | ~30 years (measured), ~100 years (modelled) |
| Diatoms | Percentage (%) | % of total diatoms | Low-resolution |
| Redox Markers | Concentration | Sequential extraction fractions | Low-resolution |
| Temperature | °C | Degrees Celsius | Variable by source |
| Isotopes | δ18O | ‰ (permille) | Variable by source |
| Insolation | W/m² | Watts per square meter | Orbital calculations |

## Known Limitations

1. **Pollen Gap:** Measured pollen data ends at 10,995 BP; extension to 13,258 BP based on statistical modelling using Meerfelder Maar calibration
2. **Temporal Variability:** Different proxies have different sampling resolutions; interpolation used where necessary
3. **Age Model:** Based on varve chronology and radiometric dating; uncertainties documented in publications
4. **Diatom Range:** Low-resolution data available; high-resolution diatom counts not included in this release
5. **Sequential Extraction:** Geochemical fractionation inherently operationally defined; results reflect experimental protocol

## Related Publications & Data Sources

### Primary References
- Zolitschka et al. (2000): "Annually dated late Weichselian continental paleoclimate record from the Eifel, Germany"
- Additional publications documenting Holzmaar paleoclimate records

### Reference Sites & Datasets
- Meerfelder Maar: Reference pollen sequence for calibration
- NGRIP: Greenland ice core for global climate comparison
- European pollen compilations: International standards
- GDGT records: Northern European temperature calibration
- Gerzensee & Egelsee: Alpine lake temperature reconstructions

## Metadata & Citation

**Dataset Creators:** [Author information]  
**Affiliation:** [Institution]  
**Date Published:** 2026  
**Geographic Coverage:** Central Europe, Rhineland-Palatinate, Germany  
**Temporal Coverage:** 0-23,200 years BP  
**Language:** English  
**License:** [Specify license - e.g., CC-BY-4.0]

### How to Cite
```
[Author(s)] (2026). Holzmaar Paleoclimate and Paleoenvironmental Dataset 
(0-23,200 BP): Multi-proxy Records from a Volcanic Crater Lake, Germany. 
Zenodo. https://doi.org/[your-doi]
```

## Data Availability & Access

- **Format:** Excel (.xlsx), CSV (.csv)
- **Software Requirements:** R (≥4.0.0) for reproducible analysis; Excel, LibreOffice, or R for data viewing
- **File Sizes:** See individual file descriptions
- **Completeness:** 100% of primary source data included

## Contact & Support

For data questions or additional information, contact:
[Your name and email]

---

## File Manifest

| Filename | Type | Size | Rows | Columns | Description |
|----------|------|------|------|---------|-------------|
| HZM_xrf_raw_measurements.xlsx | XLSX | ~1.2 MB | ~4500 | 30+ | Raw XRF elemental counts |
| HZM_hsi_xrf_calibrated_1mm.xlsx | XLSX | ~1.5 MB | ~4500 | 80+ | Calibrated HSI+XRF combined data |
| HZM_hsi_composite.xlsx | XLSX | ~2.1 MB | ~4500 | 15+ | HSI spectral composite |
| HZM_pigment_calibration.xlsx | XLSX | ~30 KB | ~50 | 6 | HPLC calibration standards |
| HZM_lowres_redox_diatom_pigment.xlsx | XLSX | ~320 KB | ~500 | 100+ | Low-res integrated dataset |
| HZM_pigment_production.xlsx | XLSX | ~16 KB | ~20 | 5 | Pigment production rates & classification |
| HZM_diatom_assemblages.xlsx | XLSX | ~34 KB | 500-1000 | 95+ | Diatom species abundance |
| HZM_xrf_depth_scale.csv | CSV | ~17 KB | ~4500 | 1 | Depth calibration scale |
| holzmaar_pollen_records.csv | CSV | ~18 KB | ~500 | 15+ | Measured pollen stratigraphy |
| HolzPol_predicted_13258-10995.csv | CSV | Variable | ~2000 | 15+ | Modelled pollen extension |
| gdgt_temperature_proxy.csv | CSV | ~11 KB | ~300 | 6 | GDGT temperature calibration |
| gerzensee_temperature.csv | CSV | ~3.2 KB | ~100 | 3 | Gerzensee diatom-T record |
| egelsee_temperature.csv | CSV | ~3.2 KB | ~100 | 3 | Egelsee diatom-T record |
| ngrip_oxygen_isotopes.csv | CSV | ~1.1 MB | ~5000 | 3 | NGRIP δ18O isotope record |
| insolation_data.csv | CSV | ~7.7 KB | ~400 | 4 | Orbital insolation calculations |
| meerfelderMaar_*_pollen.csv | CSV | 2-3 KB each | ~200-400 | 2 | Reference pollen sequences (3 taxa) |
| Pollen_Litt_Usinger_stacked.xlsx | XLSX | ~1.3 MB | ~155 | 112+ | European pollen compilation |
| meerfelderMaar_pollen_master.xlsx | XLSX | ~21 KB | ~500 | 15+ | Meerfelder Maar master pollen file |

---

**Last Updated:** March 20, 2026  
**Dataset Version:** 1.0
