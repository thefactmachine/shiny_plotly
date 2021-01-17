

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





# === Advanced Charts =================

# stats::fitted() is a generic function which extracts fitted values from 
# objects returned by modeling functions. 
m <- loess(Alcohol ~ Flavanoids, data = wine, span = 1.5)

# returns formula
class(~stats::fitted(m))

# ======================================================================
# layering traces =====================
# adding loess to a scatter plot
wine %>%
  plot_ly(x = ~Flavanoids, y = ~Alcohol) %>%
  add_markers() %>%
  # inherits the x axis from base layer
  add_lines(y = ~fitted(m)) %>%
  layout(showlegend = FALSE)



# ======================================================================
# compare two models 1 scatter plot and 2 lines =======================

m2 <- lm(Alcohol ~ poly(Flavanoids, 2), data = wine)
# does not display name properly
wine %>%
  plot_ly(x = ~Flavanoids, y = ~Alcohol) %>%
  add_markers(showlegend = FALSE) %>%
  # inherits the x axis from base layer
  add_lines(y = ~fitted(m, name = "LOESS")) %>%
  add_lines(y = ~fitted(m2, name = "Polynomial"))

# ======================================================================
# ======================================================================

# layering densities === these are like histograms === only with lines.
d1 <- wine %>% filter(Type == 1)
d2 <- wine %>% filter(Type == 2)
d3 <- wine %>% filter(Type == 3)

density1 <- stats::density(d1$Flavanoids)
density2 <- stats::density(d2$Flavanoids)
density3 <- stats::density(d3$Flavanoids)

plot_ly(opacity = 0.5) %>%
  add_lines(x = ~density1$x, y = ~density1$y, name = "Type A") %>%
  add_lines(x = ~density2$x, y = ~density2$y, name = "Type B") %>%
  add_lines(x = ~density3$x, y = ~density3$y, name = "Type C") %>%
  layout(xaxis = list(title = "Flavonoids"),
         yaxis = list(title = "Density"))