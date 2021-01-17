
rm(list = ls())
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



# ===========================================================================
# these are like facets
# Subplot =====================

glimpse(vgsales)

# too many to display on the same chart
vgsales$Genre %>% table()
vgsales$Genre %>% unique() %>% length()


p1_data <- vgsales %>%
  filter(Year == 2016 & Genre == "Action") %>%
  filter(!is.na(Critic_Score) &  !is.na(Critic_Score))

p2_data <- vgsales %>%
  filter(Year == 2016 & Genre == "Adventure") %>%
  filter(!is.na(Critic_Score) &  !is.na(Critic_Score))



p1 <- p1_data %>%
  plot_ly(x = ~Critic_Score, y = ~User_Score) %>%
  add_markers(name = ~Genre)

p2 <- p2_data %>%
  plot_ly(x = ~Critic_Score, y = ~User_Score) %>%
  add_markers(name = ~Genre)

subplot(p1, p2, nrows = 1)

# plot with common axis
subplot(p1, p2, nrows = 1, shareX = TRUE, shareY = TRUE)

# ===========================================================================

# automatically creating facets   group_by() + do()

# there are six types of platform in the cohort below
df_base <-  vgsales %>%
  filter(!is.na(Critic_Score) & !is.na(Critic_Score)) %>%
  filter(Year == 2016) %>% select(Platform, Critic_Score, User_Score)

df_base %>% glimpse()

df_base$Platform %>% table()
  

df_base %>%  
  group_by(Platform) %>%
  do (
    plot = plot_ly(data = ., x = ~Critic_Score, y = ~User_Score) %>%
      add_markers(name = ~Platform)
  ) %>%
  subplot(nrows = 3, shareY = TRUE, shareX = TRUE)


# ===========================================================================
# ===========================================================================

# scatterplot matrices (pair wise ) (note lassoo selection - interactive )
# correllation matrix
# the hard part is the following structure
lst_structure <- list(
  list(label = 'Alcohol', values = ~Alcohol),
  list(label = 'Flavanoids  ', values = ~Flavanoids ),
  list(label = 'Color', values = ~Color)
)

wine %>%
  plot_ly() %>%
  # stands for scatter plot ...matrix ??
  add_trace(type = 'splom', dimensions = lst_structure)

# ===========================================================================
# ===========================================================================

# take note how COOL the interactive feature is.  You can
# use the lasso tool in the Plotly interface to drag a selection.
# the following adds color

df_vg_sales <- vgsales %>%
  filter(!is.na(NA_Sales) &  !is.na(EU_Sales) & !is.na(JP_Sales)) %>%
  filter(Year == 2016) %>%
  mutate(nintendo = ifelse(Publisher == "Nintendo", "Nintendo", "Other"))
  
  
df_vg_sales %>%  
  plot_ly(color = ~nintendo) %>%
  add_trace(
    type = 'splom',
    dimensions = list(
      list(label = 'N. America', values = ~NA_Sales),
      list(label = 'Europe', values = ~EU_Sales),
      list(label = 'Japan', values = ~JP_Sales)
    )
  )

# binned scatter plot [heatmap] ===========================
vgsales %>%
  filter(!is.na(Critic_Score) &  !is.na(Critic_Score)) %>%
  filter(Year == 2016) %>%
  plot_ly(x = ~Critic_Score, y = ~User_Score) %>%
  add_histogram2d(nbinsx = 50, nbinsy = 50)


