# Notebook Execution Order Guide
**For reproducible analysis execution of the Holzmaar 23-notebook pipeline (00-22)**

## Overview
The notebook pipeline is organized into **6 sequential phases** with explicit dependencies and parallelization opportunities.

---

## Sequential Execution Order (00→22)

### Phase 1: Foundation & Context (Notebooks 00-01)
```
00_Map.Rmd
    └─→ Purpose: Geographic context and site mapping
    └─→ Dependencies: data/SourceData/Map/ files
    └─→ Output: Map figures (geologic and paleoclimate context)

01_XRF_norm_clr.Rmd
    └─→ Purpose: XRF data harmonization with CLR transformation
    └─→ Dependencies: HZM19_LG_section_XRF.xlsx, HSI-XRF calibrated file
    └─→ Output: XRF_HZM_clr.xlsx, XRF_HZM_alr.xlsx, XRF_HZM_norm.xlsx
```

### Phase 2: Data Harmonization & Proxy Calibration (Notebooks 02-03)
```
02_ProxyProxy.Rmd
    └─→ Purpose: HSI-XRF proxy intercalibration
    └─→ Dependencies: 01_XRF_norm_clr output + HSI calibration data
    └─→ Output: HZM_HSI_calibrated.xlsx (age model + calibrated data)

03_Interpolation.Rmd
    └─→ Purpose: Temporal synchronization (all data to XRF depth scale)
    └─→ Dependencies: 02_ProxyProxy output + 01_XRF output
    └─→ Output: HSI_interpolated_cleaned.xlsx
```

### Phase 3: Core XRF Analysis (Notebooks 04-06)
```
04_ClusteringAndPCA_XRF.Rmd
    └─→ Purpose: CONISS stratigraphy + PCA on XRF data
    └─→ Dependencies: 03_Interpolation output
    └─→ Output: XRF cluster assignments, PC scores (via CONISS + PCA)
    └─→ ⚠️ NOTE: Missing PC export file (XRF_clustered_PC.xlsx)

05_Plotting_XRF_clusters.Rmd
    └─→ Purpose: Multi-panel XRF visualization
    └─→ Dependencies: 04 output + HZM_HR_cleaned.xlsx
    └─→ Output: Figure 2 - XRF stratigraphic panels
    └─→ ⚠️ KNOWN ISSUE: Requires XRF_clustered_PC.xlsx (not generated in 04)

06_Plotting_XRF_clusters_with_Diatoms.Rmd
    └─→ Purpose: XRF with diatom assemblage overlay
    └─→ Dependencies: 05 output + diatom data
    └─→ Output: Supplementary XRF-diatom figure
```

### Phase 4: Multi-Proxy Integration (Notebooks 07-10)
```
07_ClusteringAndPCA_MergedDatasets.Rmd
    └─→ Purpose: Integrated clustering (XRF + pigments + diatoms)
    └─→ Dependencies: 04 output + pigment/diatom data
    └─→ Output: Merged community cluster assignments

08_LowRes_data_prep.Rmd
    └─→ Purpose: Preparation of pigments, diatoms, and redox data
    └─→ Dependencies: Raw pigment, diatom, and Fe/Mn/P data
    └─→ Output: pig_alr.xlsx (CLR-transformed pigments)
    └─→ Output: cleaned_PigOMug_clustered.xlsx, diatom assemblages
    └─→ ⚠️ NOTE: Largest notebook (2689 lines)

09_Interpolation_External.Rmd
    └─→ Purpose: Integrate external climate proxies (NGRIP, GDGT, insolation)
    └─→ Dependencies: 08_LowRes_data_prep output
    └─→ Output: Merged proxy dataset with climate drivers
    └─→ ⚠️ KNOWN ISSUE: References missing diatom_filtered.xlsx

10_RDA-Fig3_inUse.Rmd
    └─→ Purpose: Redundancy Analysis (published version)
    └─→ Dependencies: 09_Interpolation_External output + 08 pigment data
    └─→ Output: Figure 3 - RDA ordination plot
    └─→ ✅ PRIMARY RDA: Only published RDA version (prefers manual var selection)
```

### Phase 5: Exploratory & Quality Control (Notebooks 11-15)
```
11_Variable_Selection_Exploration.Rmd
    └─→ Purpose: Exploratory analysis of environmental variables (PCA, correlation)
    └─→ Dependencies: External_forRDA_pig.xlsx (independent analysis)
    └─→ Output: Variable correlation heatmaps, predictor PCA plots
    └─→ ℹ️ ROLE: Inform variable selection decisions for notebooks 14-15
    └─→ RUN FIRST: Exploratory baseline before formal RDA

12_DiscucssionPlot.Rmd
    └─→ Purpose: Multi-proxy discussion figure (climate context)
    └─→ Dependencies: 09_Interpolation_External output + pollen data
    └─→ Output: Discussion figure with HSI + external climate (NGRIP, GDGT, insolation)
    └─→ ⚠️ KNOWN ISSUE: Undefined variable hsi_bphe (should be hsi_data)

13_DiscucssionPlot_PinusBetula.Rmd
    └─→ Purpose: Discussion figure variant (pollen-focused)
    └─→ Dependencies: Same as 12_DiscucssionPlot
    └─→ Output: Variant emphasizing Pinus/Betula reforestation signal

14_RDA_QualityControl_VIF.Rmd
    └─→ Purpose: Assess multicollinearity via Variance Inflation Factor (VIF)
    └─→ Dependencies: 08_LowRes_data_prep output (pig_alr.xlsx) + External_forRDA_pig.xlsx
    └─→ Output: VIF diagnostic tables and plots
    └─→ ℹ️ ROLE: Quality control before variable selection (Blanchet et al. 2008)
    └─→ RUN BEFORE 15: VIF results inform automatic variable selection

15_RDA_VIF_Selection.Rmd
    └─→ Purpose: RDA with automatic VIF-based variable selection
    └─→ Dependencies: 14_RDA_QualityControl_VIF output + 08 pigment data
    └─→ Output: RDA results, publication-ready figure (PNG)
    └─→ ℹ️ ROLE: Alternative to manual selection (addresses reviewer suggestions)
    └─→ PRODUCES PNG FOR 16: Required input for Combined_Figure
```

### Phase 6: Synthesis & Supplementary Analyses (Notebooks 16-22)
```
16_Combined_Figure.Rmd
    └─→ Purpose: Composite publication figure (Discussion + RDA)
    └─→ Dependencies: 12_DiscucssionPlot output (PNG) + 15_RDA_VIF_Selection (PNG)
    └─→ Output: combined_figure_discussion_RDA.png (publication-ready)
    └─→ ⚠️ BLOCKING DEPENDENCY: Must run AFTER both 12 and 15

17_Supplement_VIF_Threshold_Analysis.Rmd
    └─→ Purpose: Supplementary - empirical VIF threshold justification
    └─→ Dependencies: 08_LowRes_data_prep output (pig_alr.xlsx)
    └─→ Output: Supplementary figures comparing VIF thresholds (3-10)
    └─→ Produces multiple RDA variants with different VIF cutoffs
    └─→ RUN AFTER 15: Demonstrates robustness to threshold choice

18_Pigments_SupplementaryPlots.Rmd
    └─→ Purpose: Sedimentary pigment analysis and visualization
    └─→ Dependencies: 08_LowRes_data_prep output
    └─→ Output: Supplementary pigment figures

19_Sequential_Extraction_Plots.Rmd
    └─→ Purpose: Geochemical redox cycling (Fe/Mn/P fractionation)
    └─→ Dependencies: 08_LowRes_data_prep output
    └─→ Output: Multiple redox chemistry figures (absolute, relative, combined)

20_Chl_Pheo_Diatom_Analysis.Rmd
    └─→ Purpose: Chlorophyll-a / Bacteriopheophytin ratio analysis
    └─→ Dependencies: 09_Interpolation_External output
    └─→ Output: Chl/Pheo ratio figures (productivity and water depth proxy)

21_Diatom_Dendrogram_Barplot.Rmd
    └─→ Purpose: Diatom community clustering and composition
    └─→ Dependencies: 08_LowRes_data_prep output (diatom data)
    └─→ Output: Diatom dendrogram + compositional barplots by zone

22_Pollen_modelling.Rmd
    └─→ Purpose: Gap-fill missing pollen (13,258-10,995 BP)
    └─→ Dependencies: Meerfelder Maar calibration data + Holzmaar pollen
    └─→ Output: HolzPol_predicted_13258-10995.csv (used by notebook 12)
    └─→ ℹ️ NOTE: Required for 12_DiscucssionPlot (pollen data in figures)
```

---

## Execution Strategies

### Recommended: Sequential Full Pipeline
**Estimated time: ~18 minutes (serial execution)**
```bash
# Phase 1
Rscript -e "rmarkdown::render('00_Map.Rmd')"
Rscript -e "rmarkdown::render('01_XRF_norm_clr.Rmd')"

# Phase 2
Rscript -e "rmarkdown::render('02_ProxyProxy.Rmd')"
Rscript -e "rmarkdown::render('03_Interpolation.Rmd')"

# Phase 3
Rscript -e "rmarkdown::render('04_ClusteringAndPCA_XRF.Rmd')"
Rscript -e "rmarkdown::render('05_Plotting_XRF_clusters.Rmd')"
Rscript -e "rmarkdown::render('06_Plotting_XRF_clusters_with_Diatoms.Rmd')"

# Phase 4
Rscript -e "rmarkdown::render('07_ClusteringAndPCA_MergedDatasets.Rmd')"
Rscript -e "rmarkdown::render('08_LowRes_data_prep.Rmd')"
Rscript -e "rmarkdown::render('09_Interpolation_External.Rmd')"
Rscript -e "rmarkdown::render('10_RDA-Fig3_inUse.Rmd')"

# Phase 5 (RDA analysis chain)
Rscript -e "rmarkdown::render('11_Variable_Selection_Exploration.Rmd')"  # Exploratory baseline
Rscript -e "rmarkdown::render('22_Pollen_modelling.Rmd')"              # Pollen data for discussion
Rscript -e "rmarkdown::render('12_DiscucssionPlot.Rmd')"               # Discussion figure
Rscript -e "rmarkdown::render('13_DiscucssionPlot_PinusBetula.Rmd')"   # Discussion variant
Rscript -e "rmarkdown::render('14_RDA_QualityControl_VIF.Rmd')"        # RDA diagnostics
Rscript -e "rmarkdown::render('15_RDA_VIF_Selection.Rmd')"             # Main RDA (produces PNG)

# Phase 6 (Synthesis & Supplementary)
Rscript -e "rmarkdown::render('16_Combined_Figure.Rmd')"               # Combined figure (needs 12 + 15 PNG)
Rscript -e "rmarkdown::render('17_Supplement_VIF_Threshold_Analysis.Rmd')"
Rscript -e "rmarkdown::render('18_Pigments_SupplementaryPlots.Rmd')"
Rscript -e "rmarkdown::render('19_Sequential_Extraction_Plots.Rmd')"
Rscript -e "rmarkdown::render('20_Chl_Pheo_Diatom_Analysis.Rmd')"
Rscript -e "rmarkdown::render('21_Diatom_Dendrogram_Barplot.Rmd')"
```

### Parallelization Opportunities
**Phase 1 notebooks can run in parallel** (if no dependencies):
- 00_Map.Rmd and 01_XRF_norm_clr.Rmd are independent

**Phase 3-4 notebooks can partially parallelize** after phase 2:
- 05_Plotting_* can run after 04 (independent of 06-10)
- 07_Clustering can run after 04
- 08_LowRes_prep is independent (runs on raw data)

**Phase 6 supplementary analyses are independent** (after phase 5):
- 18, 19, 20, 21 have no inter-dependencies
- Run these in parallel for faster supplementary analysis

---

## Critical Blocking Dependencies

| Notebook | Must Wait For | Reason |
|----------|---------------|--------|
| 05_Plotting_XRF_clusters | 04_ClusteringAndPCA_XRF | Requires XRF cluster/PC assignments |
| 07_ClusteringAndPCA_Merged | 04_ClusteringAndPCA_XRF, pigment data | Requires XRF clusters + pigment input |
| 09_Interpolation_External | 08_LowRes_data_prep | Requires pig_alr.xlsx output |
| 10_RDA-Fig3_inUse | 09_Interpolation_External | Requires merged climate proxy data |
| 12_DiscucssionPlot | 22_Pollen_modelling | Requires pollen predictions CSV |
| 14_RDA_QualityControl_VIF | 08_LowRes_data_prep | Requires pig_alr.xlsx output |
| 15_RDA_VIF_Selection | 14_RDA_QualityControl_VIF | Requires VIF diagnostic output |
| 16_Combined_Figure | 12_DiscucssionPlot + 15_RDA_VIF_Selection | Requires both PNG figures as input |
| 17_Supplement_VIF_Threshold | 14_RDA_QualityControl_VIF | Uses VIF assessment results |

---

## Known Issues & Workarounds

### Issue 1: Missing PC Export (Notebook 04)
- **Problem**: Notebook 04 performs PCA but doesn't export PC scores
- **File Required By**: 05_Plotting_XRF_clusters.Rmd (reads `XRF_clustered_PC.xlsx`)
- **Workaround**: Manually add export code to notebook 04 or manually create file from PCA object

### Issue 2: Undefined Variable (Notebook 12)
- **Problem**: Line uses `hsi_bphe$age` but variable never defined
- **Fix**: Change to `hsi_data$age`
- **Impact**: Prevents GDGT temperature interpolation in discussion plot

### Issue 3: Missing Source File
- **Problem**: `diatom_filtered.xlsx` read by notebook 09 but never created
- **Workaround**: Check if created by notebook 08 (not yet confirmed)

---

## Validation Checklist

Before committing to publication, verify:
- ✅ All 23 notebooks (00-22) execute without errors
- ✅ All output files generated in `figs/` directory
- ✅ No missing intermediate data files
- ✅ Publication figures generated (Figure 1 from 00, Figure 2 from 05, Figure 3 from 10, combined from 16)
- ✅ Supplementary figures present (from 17-22)
