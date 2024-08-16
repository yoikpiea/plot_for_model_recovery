# Model Recovery Comparison

This R script performs model recovery comparison as illustrated in Supplemental Figure 2b from the paper:

**Brown, V. M., Hallquist, M. N., Frank, M. J., & Dombrovski, A. Y. (2022).** *Humans adaptively resolve the explore-exploit dilemma under cognitive constraints: Evidence from a multi-armed bandit task.* Cognition, 229, 105233. [Link to paper](https://doi.org/10.1016/j.cognition.2022.105233)

## Overview

This R code visualizes model recovery results using simulated and experimental data. It generates two primary plots:

1. **Density Plot (p1):** Displays the density distribution of experimental data with a shaded confidence interval.
2. **Boxplot with Beeswarm Plot (p2):** Shows the distribution of simulated data using a transparent boxplot combined with a beeswarm plot, where the median line is emphasized.

The visualizations are created using the `ggplot2`, `ggbeeswarm`,  `patchwork` and `dplyr`packages.

## Requirements

- R version 4.0.0 or higher
- `ggplot2` package
- `ggbeeswarm` package
- `patchwork` package
- `dplyr` package

## Run the Script:

Clone the repository and execute the R script to generate the plots.

git clone https://github.com/yoikpiea/plot_for_model_recovery.git
cd plot_for_model_recovery
Data_Visualization_for_parameter_recovery.R
