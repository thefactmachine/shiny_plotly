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





# === Customising your layout =================
# Adding axis labels
winequality %>%
  plot_ly(x = ~free_so2, y = ~total_so2) %>%
  add_markers(marker = list(opacity = 0.2)) %>%
  layout(xaxis = list(title = "Free S02 (ppm)"),
         yaxis = list(title = "Total S02 (ppm)"),
         title = "Does this scatter plot look nice?")

# transform scale
winequality %>%
  plot_ly(x = ~free_so2, y = ~total_so2) %>%
  add_markers(marker = list(opacity = 0.2)) %>%
  layout(xaxis = list(title = "Free S02 (ppm) - log scale", type = "log"),
         yaxis = list(title = "Total S02 (ppm) - log scale ", type = "log"),
         title = "Does this scatter plot look nice?")

# remove zero line
winequality %>%
  plot_ly(x = ~free_so2, y = ~total_so2) %>%
  add_markers(marker = list(opacity = 0.2)) %>%
  layout(xaxis = list(title = "Free S02 (ppm)", zeroline = FALSE),
         yaxis = list(title = "Total S02 (ppm)", zeroline = FALSE),
         title = "Does this scatter plot look nice?"
         )

# customise the canvas
winequality %>%
  plot_ly(x = ~free_so2, y = ~total_so2) %>%
  add_markers(marker = list(opacity = 0.2)) %>%
  layout(xaxis = list(title = "Free S02 (ppm)"),
         yaxis = list(title = "Total S02 (ppm)"),
         title = "Does this scatter plot look nice?",
         plot_bgcolor = toRGB("gray90"),
         paper_bgcolor = toRGB("skyblue"))




# === Advanced Charts =================

# layering traces =====================

# following returns list.  Extract character vector:
# m$fitted %>% length() == 178
m <- loess(Alcohol ~ Flavanoids, data = wine, span = 1.5)

# returns formula
class(~fitted(m))

wine %>%
  plot_ly(x = ~Flavanoids, y = ~Alcohol) %>%
  add_markers() %>%
  # inherits the x axis from base layer
  add_lines(y = ~fitted(m)) %>%
  layout(showlegend = FALSE)

#  ==================
# compare two models  =====================
m2 <- lm(Alcohol ~ poly(Flavanoids, 2), data = wine)

# does not display name properly
wine %>%
  plot_ly(x = ~Flavanoids, y = ~Alcohol) %>%
  add_markers(showlegend = FALSE) %>%
  # inherits the x axis from base layer
  add_lines(y = ~fitted(m, name = "LOESS")) %>%
  add_lines(y = ~fitted(m2, name = "Polynomial"))

# layering densities
d1 <- wine %>% filter(Type == 1)
d2 <- wine %>% filter(Type == 2)
d3 <- wine %>% filter(Type == 3)

density1 <- density(d1$Flavanoids)
density2 <- density(d2$Flavanoids)
density3 <- density(d3$Flavanoids)

plot_ly(opacity = 0.5) %>%
  add_lines(x = ~density1$x, y = ~density1$y, name = "Type A") %>%
  add_lines(x = ~density2$x, y = ~density2$y, name = "Type B") %>%
  add_lines(x = ~density3$x, y = ~density3$y, name = "Type C") %>%
  layout(xaxis = list(title = "Flavonoids"),
         yaxis = list(title = "Density"))

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

# =================================
# automatically creating facets
# group_by() + do()

# there are six types of platform in the cohort below

vgsales %>%
  filter(!is.na(Critic_Score) &  !is.na(Critic_Score)) %>%
  filter(Year == 2016) %>%
  group_by(Platform) %>%
  do (
    plot = plot_ly(data = ., x = ~Critic_Score, y = ~User_Score) %>%
      add_markers(name = ~Platform)
  ) %>%
  subplot(nrows = 3, shareY = TRUE, shareX = TRUE)

# -------------------------------------
# scatterplot matrices (pair wise )

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

# take note how COOL the interactive feature is.  You can
# use the lasso tool in the Plotly interface to drag a selection.
# the following adds color



vgsales %>%
  filter(!is.na(NA_Sales) &  !is.na(EU_Sales) & !is.na(JP_Sales)) %>%
  filter(Year == 2016) %>%
  mutate(nintendo = ifelse(Publisher == "Nintendo", "Nintendo", "Other")) %>%
  plot_ly(color = ~nintendo) %>%
  add_trace(
    type = 'splom',
    dimensions = list(
      list(label = 'N. America', values = ~NA_Sales),
      list(label = 'Europe', values = ~EU_Sales),
      list(label = 'Japan', values = ~JP_Sales)
    )
  )

# binned scatter plot ===========================
vgsales %>%
  filter(!is.na(Critic_Score) &  !is.na(Critic_Score)) %>%
  filter(Year == 2016) %>%
  plot_ly(x = ~Critic_Score, y = ~User_Score) %>%
  add_histogram2d(nbinsx = 50, nbinsy = 50)

subplot(p1, p2, nrows = 1)
vgsales %>% filter(Year == 2016 & Genre == "Adventure")

