# Quick Start Guide - Running Cleaned Notebooks

**Last Updated:** 2025-03-11

## ⚡ 5-Minute Quick Start

### Step 1: Install Dependencies (2 min)
```r
# Copy and run in R console
packages <- c("tidyverse", "readxl", "openxlsx", "vegan", "cluster", "ape", 
              "lme4", "bruceR", "cowplot", "patchwork", "ggpattern", "gridExtra",
              "sp", "raster", "zoo", "data.table")
install.packages(packages)
remotes::install_github("psychbruce/bruceR")  # If first install fails
```

### Step 2: Check File Structure (1 min)
Ensure this structure exists:
```
HolzmaarPaper2025/
├── notebooks_cleaned/         ← You are here
├── data/
│   ├── SourceData/           ← Must have input files
│   └── *.xlsx, *.csv         ← Will be created
├── figs/                     ← Will be created
```

### Step 3: Run Notebook Sequence (varies)
**Option A: Run all independently first**
```r
# These can run in any order (5-10 min each):
01_XRF_norm_clr.Rmd
02_ProxyProxy.Rmd
03_Interpolation.Rmd
Pollen_modelling.Rmd
Sequential_Extraction_Plots.Rmd
```

**Option B: Then run dependent sequence**
```r
# Must run in this order (10-20 min total):
04_ClusteringAndPCA_XRF.Rmd
05_Plotting_XRF_clusters.Rmd
06_ClusteringAndPCA_MergedDatasets.Rmd
07_LowRes_data_prep.Rmd
08_Interpolation_External.Rmd
10_DiscucssionPlot.Rmd
11_Combined_Figure.Rmd
```

---

## ✅ Verification Checklist

After Each Notebook, Check:

- [ ] **No errors** in console (red X marks)
- [ ] **Output message** shows files saved
- [ ] **New files** appear in ../data/ or ../figs/ directories
- [ ] **Plots display** correctly (no blank windows)

---

## 🔧 If Something Goes Wrong

| Problem | Check | Fix |
|---------|-------|-----|
| "File not found" | Is file in data/SourceData/? | Copy missing file or check path |
| "Package not found" | Run install.packages()? | `install.packages("package_name")` |
| "Column 'X' not found" | Are colnames correct? | Run `colnames(data)` to check |
| "Object not found" | Did previous notebooks run? | Re-run previous notebook first |
| Blank plots | Are data ranges valid? | Check `cat()` diagnostic output |

---

## 📊 Expected Outputs

After successfully running all notebooks, you should have:

**Main Figures:**
- `../figs/discussion_multiplot_v2_with_pigments.png` (8.27 × 7.5 inches)
- `../figs/FigDiscussion.svg` (vector format)
- `../figs/Pinus_Betula_pollen_combined.png` (pollen comparison)
- `../figs/Sequential_Extraction_*_Flipped.png` (stratigraphic plots)

**Data Files:**
- `../data/XRF_HZM_norm.xlsx` (normalized XRF)
- `../data/XRF_HZM_clr.xlsx` (CLR-transformed)
- `../data/XRF_clustered_PC.xlsx` (PCA results)
- Plus 10+ other processed data files

---

## 🚀 Advanced Tips

### Run Specific Sections Only
Use Ctrl+Enter (Cmd+Enter on Mac) to run individual code chunks

### Skip Time-Consuming Steps
Modify code to load pre-computed results instead of recalculating

### Parallel Execution (Windows)
Run independent notebooks in separate R sessions simultaneously

### Create Custom Figures
Modify ggplot2 code at end of each notebook; outputs update automatically

---

## 💡 For Developers

### Add New Analysis
1. Copy notebook template structure
2. Include setup/libraries chunk
3. Add diagnostic output (cat statements)
4. Save outputs explicitly with write.xlsx()
5. End with sessionInfo()

### Debug Workflow
1. Run one chunk at a time (Ctrl+Enter)
2. Check data dimensions: `str(data)`, `head(data)`
3. Verify column names: `colnames(data)`
4. Plot intermediate results: `plot(data$column)`

---

## 📞 Support

**For errors:** See CLEANING_GUIDE.md "Troubleshooting" section

**For documentation:** See README.md for full workflow details

**For code issues:** Check inline comments in notebooks

---

**Ready to start?** Begin with `01_XRF_norm_clr.Rmd` →
