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


# ====================================================================
# ====================================================================
# ====================================================================
# section 2
# customise your traces

# specify color
winequality %>%
  plot_ly(x = ~fixed_acidity) %>%
  # if do not add I() plotly assumes that you are specifying a variable
  # and mapping this to color
  add_histogram(color = I("red"))

# specify opacity - because of overplotting
winequality %>%
  plot_ly(x = ~residual_sugar, y = ~fixed_acidity) %>%
  add_markers(marker = list(opacity = 0.05), color = I("green"))

# change glyph
winequality %>%
  plot_ly(x = ~residual_sugar, y = ~fixed_acidity) %>%
  add_markers(marker = list(symbol = "circle-open"))


# can change size of scatter plot by using "size"
# for histogram use "width"

vgsales2016  <- vgsales %>% filter(Year == 2016)

# can use precise colors
vgsales2016 %>%
  plot_ly(x = ~Critic_Score) %>%
  add_histogram(color = I("#111e6c"))

# === thoughtful use of color
wine %>%
  plot_ly(x = ~Flavanoids, y = ~Alcohol, color = ~Type) %>%
  add_markers()

# change color variable
wine %>%
  plot_ly(x = ~Flavanoids, y = ~Alcohol, color = ~Color) %>%
  add_markers()

# add theme
wine %>%
  plot_ly(x = ~Flavanoids, y = ~Alcohol, color = ~Color) %>%
  add_markers(colors = "Dark2")

# define specify colors
wine %>%
  plot_ly(x = ~Flavanoids, y = ~Alcohol, color = ~Color) %>%
  add_markers(colors = c("orange", "black", "skyblue"))


# === Hover info =================

# hoverinfo values = "all", "x" ,"y", "x+y", "x+y+z"
wine %>%
  count(Type) %>%
  plot_ly(x = ~Type, y = ~n, hoverinfo = "y") %>%
  add_bars()

# 1) hoverinfo = "text"
# 2) ~ to map columns to aesthetic parameters

wine %>%
  plot_ly(x = ~Flavanoids, y = ~Alcohol,
          hoverinfo = "text",
          text = ~paste("Flavanoids:", Flavanoids, "<br>", "Alcohol:", Alcohol)
  ) %>%
  add_markers()



