# Data Manifest: Input vs. Generated Files

**Purpose:** Document which data files are essential inputs and which are generated outputs from the analysis pipeline.

**Last Updated:** August 3, 2026

---

## 📥 ESSENTIAL INPUT DATA (Must Keep in Git)

These files are **raw/primary data** that the notebooks READ. They must be in the repository for the analysis to run.

### Raw Holzmaar Core Data
Located in `data/SourceData/`

| File | Size | Format | Used By | Purpose |
|------|------|--------|---------|---------|
| `HZM19_LG_section_XRF.xlsx` | 1.2 MB | Excel | 01_XRF_norm_clr | Primary XRF elemental measurements |
| `HZM_HSI-XRF_1mm_calibrated_napari_2025-01-13_V3.xlsx` | 1.4 MB | Excel | 01_XRF_norm_clr, 02_ProxyProxy | HSI + XRF calibrated composite |
| `HZM_hsi_composite.xlsx` | 2.0 MB | Excel | 02_ProxyProxy | Hyperspectral imaging raw data |
| `HZM_lowres_redox_diatom_pigment.xlsx` | 314 KB | Excel | 07_LowRes_data_prep | Low-resolution redox, diatom, pigment data |
| `HZM_pigment_production.xlsx` | 16 KB | Excel | 07_LowRes_data_prep | Pigment calibration data |
| `HZM_pigment_calibration.xlsx` | 29 KB | Excel | 02_ProxyProxy | Pigment calibration reference |
| `HZM_diatom_assemblages.xlsx` | 33 KB | Excel | 07_LowRes_data_prep | Diatom species assemblages |
| `HZM_calib.xlsx` | 29 KB | Excel | 02_ProxyProxy | Calibration/reference data |
| `HZM_xrf_depth_scale.csv` | 17 KB | CSV | Various | Depth scale reference |
| `LR_data.xlsx` | 314 KB | Excel | 07_LowRes_data_prep | Low-resolution composite data |
| `diatoms_Lujan.xlsx` | 33 KB | Excel | 07_LowRes_data_prep | Diatom taxonomy and names |

### External Climate Reference Data
Located in `data/SourceData/External/csvs/`

| File | Format | Used By | Purpose |
|------|--------|---------|---------|
| `holzmaar_pollen_records.csv` | CSV | 17_Pollen_modelling | Reference pollen assemblages |
| `gdgt_temperature_proxy.csv` | CSV | 08_Interpolation_External | GDGT temperature calibration |
| `gerzensee_temperature.csv` | CSV | 08_Interpolation_External | Alpine reference temperature |
| `egelsee_temperature.csv` | CSV | 08_Interpolation_External | German Alps reference temperature |
| `NGRIP_oxygen_isotopes.csv` | CSV | 08_Interpolation_External | Ice core reference signal |
| `insolation_data.csv` | CSV | 08_Interpolation_External | Orbital forcing |
| `Meerfeldemar_pollen.xlsx` | Excel | 17_Pollen_modelling | Reference pollen for calibration |

### Reference/Support Data

| File | Used By | Purpose |
|------|---------|---------|
| `Pollen_Litt_Usinger_stacked.xlsx` | 17_Pollen_modelling | Pollen reference dataset |
| `HSI_composite.xlsx` | 02_ProxyProxy | HSI raw composite |
| `LR_all.xlsx` | 07_LowRes_data_prep | Low-res composite |
| `LR_all_bulk.xlsx` | 07_LowRes_data_prep | Low-res bulk data |

---

## 📤 GENERATED OUTPUT DATA (Can Be Recreated)

These files are **created by running the notebooks**. They are intermediate outputs used by downstream analyses. **Can be safely deleted** - the notebooks will regenerate them.

### Normalized/Transformed Data
Created by early notebooks, used by downstream analyses

| File | Created By | Size | Purpose |
|------|-----------|------|---------|
| `HZM_HR_cleaned.xlsx` | 01_XRF_norm_clr | 800 KB | Cleaned high-resolution data |
| `XRF_HZM_norm.xlsx` | 01_XRF_norm_clr | 1.2 MB | Normalized XRF data |
| `XRF_HZM_clr.xlsx` | 01_XRF_norm_clr | 1.2 MB | CLR-transformed XRF |
| `XRF_HZM_alr.xlsx` | 01_XRF_norm_clr | 1.2 MB | ALR-transformed XRF |
| `XRF_scale_cleaned.csv` | 01_XRF_norm_clr | 25 KB | Cleaned depth scale |

### Interpolated Data
Created by 03_Interpolation and 08_Interpolation_External

| File | Created By | Purpose |
|------|-----------|---------|
| `interpolated.csv` | 03_Interpolation | Time-aligned datasets |
| `HSI_interpolated.csv` | 03_Interpolation | Interpolated HSI data |
| `HSI_interpolated_cleaned.csv` | 03_Interpolation | Cleaned interpolated HSI |
| `HSI_interpolated_cleaned.xlsx` | 03_Interpolation | Excel version of interpolated HSI |
| `HSI_HR_data.csv` | 03_Interpolation | High-res HSI |

### Clustering & PCA Outputs
Created by 04_ClusteringAndPCA and 06_ClusteringAndPCA_Merged

| File | Created By | Purpose |
|------|-----------|---------|
| `XRF_clustered.xlsx` | 04_ClusteringAndPCA_XRF | XRF cluster assignments |
| `XRF_clustered_PC.xlsx` | 04_ClusteringAndPCA_XRF | XRF PC scores |
| `merged_clustered.xlsx` | 06_ClusteringAndPCA_MergedDatasets | Multi-proxy cluster assignments |

### Pigment Data Outputs
Created by 07_LowRes_data_prep

| File | Created By | Size | Purpose |
|------|-----------|------|---------|
| `Pig_clean.xlsx` | 07_LowRes_data_prep | 150 KB | Cleaned pigment data |
| `pig_alr.xlsx` | 07_LowRes_data_prep | 180 KB | ALR-transformed pigments |
| `Pig_clustered_PC.xlsx` | 07_LowRes_data_prep | 200 KB | Pigment cluster PC scores |
| `cleaned_PigOMug_clustered.xlsx` | 07_LowRes_data_prep | 220 KB | Cleaned pigment clusters |
| `pigment_communities_*.xlsx` | 07_LowRes_data_prep | 100 KB each | Pigment community matrices |
| `diatom_filtered.xlsx` | 07_LowRes_data_prep | 150 KB | Filtered diatom data |

### Correlation & Statistics Outputs

| File | Created By | Purpose |
|------|-----------|---------|
| `Correlation_Summary.csv` | 02_ProxyProxy | Proxy correlation matrix |
| `External_forRDA.xlsx` | 08_Interpolation_External | External data for RDA |
| `External_forRDA_pig.xlsx` | 08_Interpolation_External | External data for pigment RDA |
| `External_forRDA_dia.xlsx` | 08_Interpolation_External | External data for diatom RDA |
| `External_Interpol_pig.xlsx` | 08_Interpolation_External | Interpolated external pigment data |
| `External_forRDA_pig_redox.csv` | 08_Interpolation_External | External pigment + redox |

### Pollen Modeling Outputs
Created by 17_Pollen_modelling

| File | Created By | Purpose |
|------|-----------|---------|
| `HolzPol_predicted_13258-10995.csv` | 17_Pollen_modelling | Modeled pollen for gap |
| `HolzPol_extended_with_predictions.csv` | 17_Pollen_modelling | Complete pollen record with predictions |
| `HolzPol_10995-15030_complete.csv` | 17_Pollen_modelling | Full pollen dataset |

---

## 🗑️ TEMPORARY/WORKING FILES (Can Be Deleted)

These are typically temporary Excel files created during development. They can be cleaned up.

**Temporary lock files** (safe to delete):
- `~$diatom_filtered.xlsx`
- `~$HZM_HSI_XRF_cal_napari.xlsx`
- `~$Pig_clustered_PC.xlsx`
- `~$LR_data.xlsx`
- `~$Pollen_Litt_Usinger_stacked.xlsx`

**Duplicate/Alternative versions** (check before deleting):
- `cleaned_PigOMug_clustered4.xlsx`
- `more_cleaned_PigOMug_clustered.xlsx`
- `pig_alr_cl.xlsx`
- `pig_alr_clust.xlsx`
- `HSI_HZM_alr_ohneRmean.xlsx`
- `HSI_HZM_alr.xlsx`
- `HSI_raw_XRF_cal_napari.xlsx`
- `HZM_HSI_calibrated.xlsx`
- `HZM_HSI_XRF_cal_napari.xlsx`
- `Pig_clean.csv.xlsx`

---

## 📋 RECOMMENDATIONS FOR GIT

### ✅ KEEP in Git (DO NOT ignore)

**Essential input data only:**
- ✅ `data/SourceData/` - All raw input files (keep ALL .xlsx and .csv files)
- ✅ `data/SourceData/External/csvs/` - All external reference data

**Size:** ~11 MB total (reasonable for Git)

### ❌ IGNORE in Git (Already in .gitignore)

**Generated outputs:**
- ❌ All .xlsx files in `data/` root (except in SourceData/) 
- ❌ All .csv files in `data/` root (intermediate outputs)
- ❌ These can be regenerated by running the notebooks

**Size saved:** ~8 MB

### 🔄 WORKFLOW TO CLEAN UP DATA FOLDER

If you want to clean the `data/` root folder (keep only SourceData):

```bash
# BACKUP FIRST!
cp -r data/ data_backup/

# Remove generated outputs (be careful!)
rm data/*.xlsx
rm data/*.csv

# Keep only:
# - data/SourceData/  (all contents)
# - data/External/    (if separate)
# - data/fig/         (if figures are there)

# Run notebooks to regenerate all processed data
```

---

## 🧠 Key Insights

1. **SourceData is all you need to start** 
   - Contains all raw input data (~11 MB)
   - Other files are all downstream outputs
   
2. **Intermediate outputs are ephemeral**
   - Files like `XRF_clustered.xlsx`, `pig_alr.xlsx` are generated during analysis
   - Safe to delete - notebooks regenerate them
   - Keeping them avoids re-computation
   
3. **Temporary files accumulate**
   - Lock files (`~$*.xlsx`) are Excel backup files
   - Duplicate versions from iterative development
   - Safe to clean up
   
4. **Current Git status**
   - All .xlsx and .csv files in `data/` root are gitignored (via pattern)
   - Only `data/SourceData/` is expected to be tracked
   - This keeps repository ~8 MB smaller

---

## 📝 Next Steps

**Option 1: Clean but Keep Outputs (Recommended)**
- Keep `data/SourceData/` in Git
- Let `data/*.xlsx` and `data/*.csv` grow with usage
- Regenerate when needed by re-running notebooks
- Gitignore keeps repo clean

**Option 2: Aggressive Cleanup**
- Delete all generated .xlsx and .csv from `data/` root
- Force users to run full pipeline (ensures reproducibility)
- Smallest Git footprint

**Option 3: Include Generated Outputs**
- Track `data/` directory fully in Git
- Larger repository (~50+ MB when all notebooks run)
- Faster for new users (no re-computation needed)
- Less reproducibility incentive

**Current Status:** Option 1 (recommended) ✅
