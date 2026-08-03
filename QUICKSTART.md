# 🚀 Quick Start Guide

Get the Holzmaar analysis pipeline running in **5 minutes**.

---

## Option 1: Cloud (Recommended - No Installation)

### ☁️ Run in Renku (Instant, Browser-Based)

Click to launch in your browser with all dependencies pre-configured:

[![Renku Badge](https://renkulab.io/badges/projects.svg)](https://renkulab.io/p/snsf-anoxia-project/holzmaar)

**[Open in Renku](https://renkulab.io/p/snsf-anoxia-project/holzmaar)** 
- ✅ No installation required
- ✅ All notebooks run immediately
- ✅ Figures saved to `figs/` folder
- ✅ 18.1 minutes total execution time

---

## Option 2: Local Installation (Mac/Linux)

### 1️⃣ Clone Repository

```bash
git clone https://github.com/Epta13/Holzmaar2022-2025.git
cd Holzmaar2022-2025
```

### 2️⃣ Install Environment (Choose One)

**A) Using Conda (Recommended)**
```bash
conda env create -f environment.yml
conda activate holzmaar
```

**B) Using R Directly**
```r
source("install.R")  # Install all packages at once
```

### 3️⃣ Verify Data

```bash
# Check data files are present
ls data/SourceData/*.xlsx
ls data/SourceData/External/csvs/*.csv
```

### 4️⃣ Run Notebooks

**Run All 18 Notebooks**
```bash
Rscript run_analysis_pipeline.R
```

**Run Specific Notebook** (in RStudio)
1. Open `notebooks/00_Map.Rmd`
2. Click **Knit** button or press `Cmd+Shift+K`

---

## Execution Options

### 📋 Full Pipeline (All 18 Notebooks)
```bash
Rscript run_analysis_pipeline.R
```
**Duration:** ~18 minutes
**Output:** All figures, analyses, and data products

### 📊 Main Results Only
See `EXECUTION_ORDER.md` for running subsets:
- Map generation
- XRF analysis & clustering
- RDA multivariate analysis
- Figure generation

### ⏱️ Quick Test (Single Notebook)
```bash
# Test if environment works
Rscript -e "rmarkdown::render('notebooks/01_XRF_norm_clr.Rmd')"
```
**Duration:** ~12 seconds

---

## 📂 What's Included

✅ **18 Analysis Notebooks** (complete pipeline)
✅ **100+ Data Files** (raw and processed)
✅ **Comprehensive Documentation**
- README.md - Full project guide
- NOTEBOOKS_ANALYSIS.md - Detailed notebook descriptions
- EXECUTION_ORDER.md - How to run notebooks
✅ **Environment Files**
- environment.yml (Conda)
- install.R (R packages)

---

## 🆘 Troubleshooting

### "Package not found" error
```bash
# Reinstall environment
conda activate holzmaar
conda update --all
```

### Knit button doesn't work
```r
# Install rmarkdown
install.packages("rmarkdown")
```

### Out of memory
- Run notebooks individually instead of all at once
- Each notebook is self-contained and can run in isolation

### Missing data files
```bash
# Verify SourceData folder has all files
ls data/SourceData/ | wc -l  # Should see 20+ files
```

---

## 📖 Next Steps

1. **Understand the Pipeline:** Read [NOTEBOOKS_ANALYSIS.md](NOTEBOOKS_ANALYSIS.md)
2. **Run Notebooks:** Follow [EXECUTION_ORDER.md](EXECUTION_ORDER.md)
3. **Explore Results:** Check `figs/` folder for output plots
4. **Modify Analysis:** Edit `.Rmd` files and re-run

---

## 📞 Getting Help

- **Questions about data?** → See [README.md](README.md#data-dictionary--proxy-significance)
- **Notebook execution issues?** → Check [EXECUTION_ORDER.md](EXECUTION_ORDER.md)
- **Detailed analysis methods?** → Read [NOTEBOOKS_ANALYSIS.md](NOTEBOOKS_ANALYSIS.md)
- **Data dependencies?** → Check [DATA_MANIFEST.md](DATA_MANIFEST.md)

---

## 🔗 Related Resources

- **GitHub Repository:** https://github.com/Epta13/Holzmaar2022-2025
- **Publication:** "Zahajska et al. 2026, Biogeosciences"
- **Data Citation:** Zenodo https://doi.org/10.5281/zenodo.18429717
- **RStudio Project:** Open `holzmaar.Rproj` in RStudio

---

**Happy analyzing!** 🎉
