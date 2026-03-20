# ZENODO SUBMISSION - QUICK REFERENCE VERSIONS

## CONDENSED VERSION (for Zenodo form fields)

### Title
Holzmaar Paleoclimate and Paleoenvironmental Dataset (0-23,200 BP): Multi-proxy Records from a Volcanic Crater Lake, Germany

### Description (Brief - ~300 words)
High-resolution, multi-proxy paleoclimate and paleoenvironmental records from Holzmaar, a volcanic crater lake in the Volcanic Eifel, Rhineland-Palatinate, Germany (50°7′8″N, 6°52′45″E). The dataset comprises continuous sediment records spanning approximately 23,200 years, providing insights into late Quaternary climate variability and ecosystem dynamics in central Europe.

The dataset includes:
- **Elemental Geochemistry**: X-ray fluorescence (XRF) measurements of 30+ elements at 1 mm resolution (~4,500 measurements)
- **Pigment Analysis**: Hyperspectral imaging (HSI) calibrated against HPLC standards, tracking primary production and phytoplankton community composition
- **Redox Geochemistry**: Sequential extraction of iron, manganese, and phosphorus reflecting paleoredox conditions
- **Micropalaeontological Data**: Pollen stratigraphy (measured 0-15,030 BP, modelled extension to 13,258 BP) and diatom assemblages
- **Physical Properties**: Depth-to-age calibration and pigment production rates
- **External Reference Data**: Comparative climate proxies including GDGT temperatures, NGRIP δ18O, solar insolation, and Alpine lake temperature records

All data are standardized, normalized, and quality-assured. Complete reproducibility is ensured through 14 R Markdown notebooks documenting every processing step from raw measurements to publication figures. The analysis pipeline uses open-source R packages (tidyverse, vegan, FactoMineR, ggplot2) and is fully version-controlled.

### Keywords
paleoclimate, paleoenvironment, late Quaternary, multi-proxy, XRF, pigments, pollen, diatoms, redox geochemistry, volcanic crater lake, Germany, Central Europe, climate reconstruction, reproducible research

### Subject Area
Earth and Environmental Sciences / Paleoclimate

### Geographic Coverage
Volcanic Eifel, Rhineland-Palatinate, Germany (50°7′8″N, 6°52′45″E)

### Temporal Coverage
0-23,200 years before present (BP)

### Language
English

### Resource Type
Dataset / Research data

---

## FIELDS FOR ZENODO FORM

**Title:**
Holzmaar Paleoclimate and Paleoenvironmental Dataset (0-23,200 BP): Multi-proxy Records from a Volcanic Crater Lake, Germany

**Description:**
High-resolution multi-proxy paleoclimate records from a volcanic crater lake in Germany spanning 23,200 years. Contains elemental geochemistry (XRF), pigment analysis (HSI), redox geochemistry, pollen, diatoms, and external climate comparisons. Complete with reproducible analysis code in R.

**Creator/Author:**
[Your Name]
[Your Affiliation/Organization]

**Date of Publication:**
2026-03-20

**Access Rights:**
Open Access

**License:**
Creative Commons Attribution 4.0 International (CC-BY-4.0)
[or select your preferred license]

**Keywords (comma-separated):**
paleoclimate, paleoenvironment, multi-proxy reconstruction, XRF geochemistry, pigments, pollen, diatoms, redox cycling, volcanic crater lake, Quaternary, Central Europe, R data analysis, reproducible research

**Related Identifiers (if applicable):**
- Related publications: [add DOI if published]
- Repository: https://github.com/Epta13/Holzmaar2022-2025
- Analysis Code: Included in /notebooks/ directory

**Funding Information:**
[Add if applicable]

**References:**
- Zolitschka et al. (2000). Geology 28(9): 783-786. doi:10.1130/0091-7613(2000)28<783:ADLWCP>2.0.CO;2
- [Additional references]

---

## FILE INVENTORY FOR ZENODO

**Primary Data Files (data/SourceData/):**
1. HZM_xrf_raw_measurements.xlsx (1.2 MB)
2. HZM_hsi_xrf_calibrated_1mm.xlsx (1.5 MB)
3. HZM_hsi_composite.xlsx (2.1 MB)
4. HZM_pigment_calibration.xlsx (30 KB)
5. HZM_lowres_redox_diatom_pigment.xlsx (320 KB)
6. HZM_pigment_production.xlsx (16 KB)
7. HZM_diatom_assemblages.xlsx (34 KB)
8. HZM_xrf_depth_scale.csv (17 KB)

**External Data Files (data/SourceData/External/csvs/):**
9. holzmaar_pollen_records.csv (18 KB)
10-14. Reference proxy data (GDGT, Gerzensee, Egelsee, NGRIP, insolation)
15-17. Reference pollen sequences (Meerfelder Maar)
18. Pollen_Litt_Usinger_stacked.xlsx (1.3 MB)
19. meerfelderMaar_pollen_master.xlsx (21 KB)

**Modelled Data:**
20. HolzPol_predicted_13258-10995.csv

**Supporting Files:**
- R Analysis Notebooks (14 .Rmd files)
- Documentation (README.md, QUICKSTART.md, etc.)
- Functions directory (utility scripts)
- environment.yml, install.R, requirements.txt

---

## RECOMMENDATIONS FOR ZENODO SUBMISSION

1. **Upload as Dataset** (not code/software, since code is secondary to data)
2. **Include README file** redirecting users to ZENODO_DATASET_DESCRIPTION.md
3. **Include install.R/environment.yml** for reproducibility
4. **Link GitHub repository** for ongoing development and issue tracking
5. **Add version number** (e.g., v1.0) and consider future updates
6. **Consider embargo period** if needed (typically 0-6 months)
7. **Add funding acknowledgments** visible in Zenodo
8. **DOI created automatically** - use for citations

### Recommended Zenodo Settings:
- **Publication Date:** [Your choice - today or hold for embargo]
- **Communities:** Paleoclimate Research, Data Science (optional)
- **Creators as Contributors:** Check to ensure attribution
- **Versioning:** Enable to allow future updates

---

## POST-SUBMISSION CHECKLIST

- [ ] Verify DOI created
- [ ] Test all data file downloads
- [ ] Verify metadata displays correctly
- [ ] Update project README with Zenodo DOI
- [ ] Update GitHub repository with Zenodo link
- [ ] Create GitHub Release linking to Zenodo
- [ ] Share data with collaborators
- [ ] Update any related publications with dataset DOI

