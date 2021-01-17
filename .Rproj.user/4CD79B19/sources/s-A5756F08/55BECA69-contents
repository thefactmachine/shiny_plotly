vgsales <- read.csv(url(paste0("https://assets.datacamp.com/production/",
                               "repositories/1792/datasets/",
                               "2396f3f587e31ea726911e5d8974c5f98db5eee1/vgsales.csv")))

write.csv(vgsales, "plotly_data/vgsales.csv")

rm(list = ls())

library(plotly)
library(dplyr)

# reordering factor levels
library(forcats)
vgsales <- read.csv("plotly_data/vgsales.csv")
wine <- read.csv("plotly_data/wine.csv")
winequality <- read.csv("plotly_data/winequality.csv")


# ========================================================================
# ========================================================================
# Convert a basic ggplot into a scatter plot
# ========================================================================

# Store the scatterplot of Critic_Score vs. NA_Sales sales in 2016
scatter <- vgsales %>%
  filter(Year == 2016) %>%
  ggplot(aes(x = NA_Sales, y = Global_Sales)) +
  geom_point(alpha = 0.3)

# Convert the scatterplot to a plotly graphic
ggplotly(scatter)

# ========================================================================
# ========================================================================
# Create a basic plot.ly bar chart
# ========================================================================
glimpse(wine)
# 3 types -- basic plot
wine %>% count(Type) %>%
  plot_ly(x = ~Type, y = ~n) %>%
  add_bars()

# ========================================================================
#  Create a basic plot.ly bar chart [reorder factor]
# ========================================================================
# sort by count
df_plot_sort_by_count <- wine %>% count(Type) %>%
  mutate(Type = forcats::fct_reorder(as.character(Type), n, .desc = TRUE))

df_plot_sort_by_count %>%
  plot_ly(x = ~Type, y = ~n) %>%
  add_bars()

# ========================================================================
# Create a histogram 
# ========================================================================
# histogram
wine %>%
  plot_ly(x = ~Phenols) %>%
  # add histogram trace -- number of bins
  add_histogram(nbinsx = 20)

# histogram
wine %>%
  plot_ly(x = ~Phenols) %>%
  # specify width of bins - chose summary() of variable first
  add_histogram(xbins = list(start = 0.8, end = 4, size = 0.25))

# ========================================================================
# bivariate graphics ================================================
# ========================================================================

# scatter plot
winequality %>%
  plot_ly(x = ~residual_sugar, y = ~fixed_acidity) %>%
  # displays a dot for each ordered pair
  add_markers()

# stacked bar
winequality %>%
  count(type, quality_label) %>%
  plot_ly(x = ~type, y = ~n, color = ~quality_label) %>%
  # normal bar chart by default
  add_bars() %>%
  layout(barmode = "stack")

# stacked bar using proportions
winequality %>%
  count(type, quality_label) %>%
  group_by(type) %>%
  mutate(prop = n / sum(n)) %>%
  plot_ly(x = ~type, y = ~prop, color = ~quality_label) %>%
  # normal bar chart by default
  add_bars() %>%
  layout(barmode = "stack")

# boxplots
winequality %>%
  plot_ly(x = ~quality_label, y = ~alcohol) %>%
  add_boxplot()




