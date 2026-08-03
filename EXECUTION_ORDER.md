# Notebook Execution Order Guide
**For reproducible analysis execution**

## Sequential Execution Order (00→17)

### Phase 1: Foundation & Context (Notebooks 00-01)
```
00_Map.Rmd
    └─→ Generates: Figure 1 (geographic maps)
    └─→ Dependencies: data/SourceData/Map/
    └─→ Output: Figure_01_*.pdf/.png

01_XRF_norm_clr.Rmd
    └─→ Purpose: CLR transformation of XRF geochemistry
    └─→ Dependencies: Raw XRF data
    └─→ Output: Normalized XRF dataset
```

### Phase 2: Data Exploration (Notebooks 02-03)
```
02_ProxyProxy.Rmd
    └─→ Purpose: Proxy correlations & relationships
    └─→ Generates: Supplementary Figure 3 (correlation heatmaps)
    └─→ Dependencies: 01_XRF_norm_clr output

03_Interpolation.Rmd
    └─→ Purpose: Align time series across proxies
    └─→ Output: Interpolated datasets
    └─→ Dependencies: 01 output
```

### Phase 3: XRF Analysis (Notebooks 04-05)
```
04_ClusteringAndPCA_XRF.Rmd
    └─→ Purpose: XRF-specific clustering & PCA
    └─→ Generates: PC loadings, cluster assignments
    └─→ Dependencies: 03_Interpolation output

05_Plotting_XRF_clusters.Rmd
    └─→ Purpose: XRF visualization (Figure 2 component)
    └─→ Generates: Figure 2 XRF panels
    └─→ Dependencies: 04 output
    └─→ Variant: 05_Plotting_XRF_clusters_with_Diatoms.Rmd
```

### Phase 4: Multi-Proxy Integration (Notebooks 06-07)
```
06_ClusteringAndPCA_MergedDatasets.Rmd
    └─→ Purpose: Integrate all proxy data
    └─→ Generates: Merged community clusters
    └─→ Dependencies: 03, 04, and pigment/diatom data

07_LowRes_data_prep.Rmd
    └─→ Purpose: Prepare for RDA analyses
    └─→ Generates: Figure 2 (complete synthesis)
    └─→ Outputs: pig_alr.xlsx, diatom_filtered.xlsx
    └─→ Dependencies: 06 output
```

### Phase 5: External Data Integration (Notebooks 08-09)
```
08_Interpolation_External.Rmd
    └─→ Purpose: Integrate climate proxies (NGRIP, GDGT, insolation)
    └─→ Dependencies: External data from data/

08_RDA-Fig3.Rmd (companion to 08)
    └─→ Purpose: Initial RDA visualization
    └─→ Generates: RDA ordination plots

09_RDA-Fig3_inUse.Rmd
    └─→ Purpose: Refined RDA analysis (preferred version)
    └─→ Generates: Figure 2 RDA panels
    └─→ Dependencies: 08 output
```

### Phase 6: Quality Control & Variable Selection (Notebooks 10-12)
```
10_RDA_QualityControl_VIF.Rmd
    └─→ Purpose: Multicollinearity screening (VIF < 10)
    └─→ Generates: VIF diagnostics, quality plots
    └─→ CRITICAL: Run before variable selection
    
    10_DiscussionPlot.Rmd (companion)
    10_DiscussionPlot_PinusBetula.Rmd (variant)
    └─→ Purpose: Results interpretation plots

11_RDA_VIF_Selection.Rmd
    └─→ Purpose: Variable selection using VIF output
    └─→ Generates: Final environmental variable set
    └─→ Dependencies: 10 output (MUST RUN FIRST)

11_Supplement_VIF_Threshold_Analysis.Rmd
    └─→ Purpose: Detailed VIF threshold exploration
    └─→ Generates: Supplementary VIF analysis figures
    └─→ Dependencies: 10 output

11_Combined_Figure.Rmd
    └─→ Purpose: Composite figure generation
    └─→ Dependencies: 09, 11 outputs

12_Variable_Selection_Exploration.Rmd
    └─→ Purpose: Alternative variable sets
    └─→ Generates: Supplementary sensitivity analysis
    └─→ Dependencies: 08, 11 outputs
```

### Phase 7: Supplementary Analyses (Notebooks 13-17)
```
13_Pigments_SupplementaryPlots.Rmd
    └─→ Purpose: Sedimentary pigment analysis
    └─→ Generates: Supplementary pigment figures
    └─→ Dependencies: 07 output

14_Sequential_Extraction_Plots.Rmd
    └─→ Purpose: Geochemical fractionation
    └─→ Generates: Multiple variants (absolute, relative, combined)
    └─→ Dependencies: XRF data

15_Chl_Pheo_Diatom_Analysis.Rmd
    └─→ Purpose: Chlorophyll/pheopigment ratios
    └─→ Generates: Pigment degradation indicators
    └─→ Dependencies: 13, 07 outputs

16_Diatom_Dendrogram_Barplot.Rmd
    └─→ Purpose: Diatom community structure
    └─→ Generates: Dendrogram & species abundance plots
    └─→ Dependencies: 07 output

17_Pollen_modelling.Rmd
    └─→ Purpose: Climate reconstruction from pollen
    └─→ Generates: Modeled pollen extension
    └─→ Final analysis in workflow
```

---

## ⚠️ Critical Dependencies (Must Run in Order)

**BLOCKING:**
- 00 must run first (foundation context)
- 01 must run before 02, 03, 04 (normalization)
- 03 must run before 04, 06 (interpolation)
- 10_RDA_QualityControl_VIF **must run before** 11_RDA_VIF_Selection (VIF prerequisites)

**RECOMMENDED:**
- Run 01-07 sequentially (data processing pipeline)
- Run 08-09 together (external data integration)
- Complete 10-12 before 13-17 (main analyses before supplementary)

---

## 📊 Suggested Execution Paths

### **Path A: Full Reproducible Workflow**
```
00 → 01 → 02 → 03 → 04 → 05 → 06 → 07 → 08 → 09 → 10 → 11 → 12 → 13 → 14 → 15 → 16 → 17
```
**Time:** ~4-6 hours (includes all computations)
**Output:** Complete paper with all figures

### **Path B: Main Results Only**
```
00 → 01 → 03 → 04 → 05 → 06 → 07 → 08 → 09 → 10 → 11
```
**Time:** ~2-3 hours
**Output:** Figure 1 & 2, main RDA analysis

### **Path C: Supplementary Figures Only**
```
(requires 07 output) → 13 → 14 → 15 → 16 → 17
```
**Time:** ~1 hour
**Output:** All supplementary figures

---

## 🔍 How to Know Each Notebook Completed Successfully

| Notebook | Success Indicators |
|----------|-------------------|
| 00_Map | Figure_01_*.pdf files in figs/ |
| 01_XRF_norm_clr | Normalized data saved, print statement confirms CLR |
| 02_ProxyProxy | Correlation heatmap displayed |
| 03_Interpolation | Interpolated CSV files created |
| 04_ClusteringAndPCA_XRF | PCA plots & cluster assignments printed |
| 05_Plotting_XRF_clusters | Figure2_*.png variants in figs/ |
| 06_ClusteringAndPCA_Merged | Merged cluster assignments printed |
| 07_LowRes_data_prep | Figure2_*.pdf, xlsx files created |
| 08_Interpolation_External | External data merged, no errors |
| 09_RDA-Fig3_inUse | RDA ordination plot displayed, R² values printed |
| 10_RDA_QualityControl_VIF | VIF table printed (all values < 10 for final set) |
| 11_RDA_VIF_Selection | Selected variables printed, Figure created |
| 12_Variable_Selection | Exploration results displayed |
| 13_Pigments_SupplementaryPlots | Pigment figures generated |
| 14_Sequential_Extraction | Multiple extraction variant PDFs created |
| 15_Chl_Pheo_Diatom | Ratio plots displayed |
| 16_Diatom_Dendrogram | Dendrogram PNG/PDF created |
| 17_Pollen_modelling | Modeled pollen data printed/saved |

---

## 💡 Tips for New Users

1. **Start with Path B** (main results) to understand workflow quickly
2. **Check intermediate outputs** using the success indicators above
3. **Use notebooks_cleaned/ folder** for cleaner, publication versions
4. **Refer to NOTEBOOKS_ANALYSIS.md** for detailed notebook descriptions
5. **Check RDA_QUALITY_ASSESSMENT.md** for methods details
