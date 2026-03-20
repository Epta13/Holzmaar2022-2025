# This file contains packages which should be added to the notebook
# during the build process. It is standard R code which is run during
# the build process and typically comprises a set of `install.packages()`
# commands.

# Install all required packages for the Holzmaar analysis pipeline
# Updated: March 12, 2026

# List of all required packages
required_packages <- c(
  # Data manipulation & import/export
  "tidyverse", "readxl", "openxlsx", "data.table", "reshape2", "dplyr", "tidyr", "janitor",
  
  # Statistical analysis & multivariate methods
  "vegan", "FactoMineR", "factoextra", "cluster", "dendroextras", "rioja", "psych", 
  "BiodiversityR", "ape", "lme4", "car", "rstatix", "mclust", "bruceR",
  
  # Visualization
  "ggplot2", "cowplot", "ggrepel", "ggvegan", "ggforce", "ggsci", "rcartocolor", 
  "viridis", "ggpubr", "ggthemes", "ggmap", "ggtext", "heatmaply", "pheatmap", 
  "latex2exp", "maps",
  
  # Utility & other
  "magrittr", "gapminder", "forcats", "tibble", "grid", "scatterplot3d", 
  "tidypaleo", "corrplot", "DT", "corto"
)

# Install packages
install.packages(required_packages)

cat("✓ All required packages have been installed\n")
cat("  Install time may be 5-10 minutes on first run\n")

# Bioconductor packages (uncomment if needed)
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("ComplexHeatmap")


# Bioconductor packages (uncomment if needed)
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("ComplexHeatmap")

cat("✓ All required packages have been installed\n")
cat("  Install time may be 5-10 minutes on first run\n")
