# Script Name: Data_Visualization for parameter recovery.R
# Author: Yolk pie
# Date: 2024-08-16
# Description: This script visualizes simulated and experimental data distributions to do comparision to verify 
#              that model has captured core of the data
#              using density plots, boxplots, and beeswarm plots in R.
#              The plots are combined using the patchwork package.
# Dependencies: ggplot2, ggbeeswarm, patchwork
# ===================================================================

# -------------------------------------------------------------------
# Load Required Libraries
# -------------------------------------------------------------------
# The following libraries are required for creating and combining plots:
# - ggplot2: For creating complex and customizable plots.
# - ggbeeswarm: For adding a beeswarm plot, which is a method for 
#               visualizing distributions by plotting individual points.
# - patchwork: For combining multiple ggplot objects into a single layout.
# - dplyr: For organize data.
library(ggplot2)
library(ggbeeswarm)
library(patchwork)
library(dplyr)

# -------------------------------------------------------------------
# Generate Simulated and Experimental Data: data could be replaced by your data here!!!
# -------------------------------------------------------------------
# This section generates two datasets:
# - Simulated data: Randomly generated data following a normal distribution
#   with a mean of 0 and a standard deviation of 1.
# - Experimental data: Randomly generated data following a normal distribution
#   with a mean of 0.5 and a standard deviation of 1.
set.seed(123)
simulated_data <- rnorm(100, mean = 0, sd = 1)
experimental_data <- rnorm(100, mean = 0.5, sd = 1)
df_exp <- data.frame(value = experimental_data, group = "Experimental")
df_sim <- data.frame(value = simulated_data, group = "Simulated")

# -------------------------------------------------------------------
# Calculate 95% Confidence Interval for Experimental Data
# -------------------------------------------------------------------
# This section calculates the 95% confidence interval (CI) for the mean of the 
# experimental data. The CI is used to assess the precision of the mean estimate 
# and is visualized in the density plot. The lower and upper bounds of the CI 
# are computed based on the sample mean, standard error, and the t-distribution.
ci <- df_exp %>%
  summarise(
    mean = mean(value, na.rm = TRUE),
    sd = sd(value, na.rm = TRUE),
    n = n(),
    se = sd / sqrt(n),
    ci_low = mean - qt(0.975, df = n - 1) * se,
    ci_high = mean + qt(0.975, df = n - 1) * se
  )

# -------------------------------------------------------------------
# Plot 1: Density Plot of Experimental Data
# -------------------------------------------------------------------
# This plot visualizes the distribution of the experimental data using a density plot.
# The density plot shows the distribution's shape and spread. Additionally, a red line 
# at the baseline represents the 95% confidence interval calculated in the previous step.
# A minimal theme is applied for a clean look, and axis elements are customized for clarity.
p1 <- ggplot(df_exp, aes(x = value)) +
  geom_density(fill = "grey", alpha = 0.7) +
  xlim(-3, 3) +
  ylim(0, NA) +
  theme_minimal(base_size = 15) +
  labs(y = "", x = "") +
  annotate("segment", x = ci$ci_low, xend = ci$ci_high, y = 0, yend = 0, 
           size = 2, color = "red") +
  theme(
    panel.background = element_rect(fill = "white", color = NA),
    panel.grid = element_blank(),
    axis.title.x = element_blank(),
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    axis.title.y = element_text(angle = 90, vjust = 0.5, hjust = 0.5),
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank(),
    plot.title = element_text(angle = 90, vjust = 0.5, hjust = 0.5)
  ) +
  annotate("text", x = -3, y = 0.2, label = "Empirical", 
           angle = 90, hjust = -0.1, vjust = 1.5, size = 5)

# -------------------------------------------------------------------
# Plot 2: Boxplot and Beeswarm Plot of Experimental Data
# -------------------------------------------------------------------
# This plot visualizes the experimental data using a boxplot combined with a 
# beeswarm plot. The boxplot provides a summary of the data distribution, 
# showing the median, quartiles, and potential outliers. The beeswarm plot 
# overlays individual data points, providing a detailed view of the distribution.
# The plot is flipped horizontally, and axis elements are customized for a clear presentation.
p2 <- ggplot(df_exp, aes(x = group, y = value)) +
  geom_boxplot(color = "pink",width = 0.4, outlier.shape = NA) +
  geom_beeswarm(color = "pink", size = 2, method = "hex") +
  stat_summary(fun = median, geom = "crossbar", width = 0.4, color = "hotpink", size = 1) + 
  annotate("text", x = 0.8, y = -3, label = "Recovered", 
           angle = 90, hjust = -0.1, vjust = 1.5, size = 5) +
  coord_flip() +
  theme_minimal(base_size = 15) +
  labs(y = "Model Recovery", x = "") +
  scale_y_continuous(
    breaks = seq(-3, 3, by = 0.5),
    limits = c(-3, 3)
  ) +
  theme(
    panel.background = element_rect(fill = "white", color = NA),
    panel.grid = element_blank(),
    axis.title.y = element_text(angle = 90, vjust = 0.5, hjust = 0.5),
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank(),
    axis.ticks.x = element_line(),
    axis.line.x = element_line(size = 0.8, color = "black")
  )

# -------------------------------------------------------------------
# Combine and Display the Plots Using Patchwork
# -------------------------------------------------------------------
# In this final section, the two plots are combined into a single visualization
# using the patchwork package. The plots are arranged vertically with a custom
# height ratio. The combined plot is then displayed.
combined_plot <- p1 / p2 + plot_layout(heights = c(3.5, 3))

# Display the combined plot
print(combined_plot)

# Save fig to plot_Model_Recovery.png
ggsave("plot_Model_Recovery.png", plot = combined_plot, width = 6, height = 6, units = "in") 
